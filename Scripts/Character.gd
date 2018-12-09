extends Node2D

export(bool) var can_jump = false
export(bool) var test = true
export(String) var sprite_name = "Joe"

var health = 3
var new_pos = Vector2()
var check = false
var sprite_path = ""
var has_powerup = false
var powerup
var vectors = [Vector2(-16, -16), Vector2(  0, -16), Vector2( 16, -16),
			   Vector2(-16,   0), Vector2(  0,   0), Vector2( 16,   0),
			   Vector2(-16,  16), Vector2(  0,  16), Vector2( 16,  16)]
var damage = 1
var pwr
var turn = false
var plr
var last_powerup
var temp
var pnum

func set_sprite():
	sprite_path = "res://Assets/" + sprite_name + ".png"
	get_node("Sprite").texture = load(sprite_path)
	if sprite_name in AL.JUMPERS:
		can_jump = true
	
	if name == "Character A":
		$Team.color = Color(255, 0, 0)
	else:
		$Team.color = Color(0, 0, 255)

func update_powerup():
	if name == "Character A":
		pwr = $"../../Controls/Player A/Powerup"
	else:
		pwr = $"../../Controls/Player B/Powerup"
	
	if has_powerup and powerup != last_powerup:
		if powerup == "Jump":
			pwr.texture = load("res://Assets/Jump.png")
			can_jump = true
			if last_powerup == "Medkit":
				health -= 1
		elif powerup == "Medkit":
			pwr.texture = load("res://Assets/Medkit.png")
			health += 1
			if last_powerup == "Jump" and not sprite_name in AL.JUMPERS:
				can_jump = false
		last_powerup = powerup

func _ready():
	if name.ends_with("A"):
		pnum = 1
	else:
		pnum = 2
	
	set_sprite()
	
	if name.ends_with("A"):
		plr = get_node("../Character B")
	else:
		plr = get_node("../Character A")
	
	set_process(true)

func _process(delta):
	if $"Sprite".texture.get_width() == 32:
		$"Sprite".scale = Vector2(0.5, 0.5)
		set_process(false)

func check_pos(pos):
	if pos.x < 0 or pos.x > AL.FAR_CORNER.x - 8 or pos.y < 0 or pos.y > AL.FAR_CORNER.y - 8:
		return false
	
	if not test:
		for child in get_parent().get_children():
			if child.position == pos:
				return false
	
		for child in get_parent().get_parent().get_node("Map").get_children():
			if child.position == pos and child.jump and not can_jump:
				return false
			elif child.position == pos and child.is_powerup:
				child.take_crate(pnum)
				update_powerup()
	
	if turn:
		return true
	
	return false

func move_up():
	new_pos = Vector2(position.x, position.y - 16)
	get_node("Sprite").rotation_degrees = 0
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
		turn = false
		plr.turn = true
	
	return check

func move_down():
	new_pos = Vector2(position.x, position.y + 16)
	get_node("Sprite").rotation_degrees = 180
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
		turn = false
		plr.turn = true
	
	return check

func move_left():
	new_pos = Vector2(position.x - 16, position.y)
	get_node("Sprite").rotation_degrees = -90
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
		turn = false
		plr.turn = true
	
	return check

func move_right():
	new_pos = Vector2(position.x + 16, position.y)
	get_node("Sprite").rotation_degrees = 90
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
		turn = false
		plr.turn = true
	
	return check

func attack():
	for vec in vectors:
		for child in $"../../Map".get_children():
			if position + vec == child.position and child.is_powerup and turn:
				if name == "Character A":
					child.take_crate(1)
				else:
					child.take_crate(2)
				update_powerup()
				
				turn = false
				plr.turn = true
		
		for child in $"..".get_children():
			if position + vec == child.position and name != child.name and turn:
				child.attacked(powerup, damage)
				
				turn = false
				plr.turn = true

func attacked(p, d):
	if powerup == "Medkit":
		has_powerup = false
		powerup = null
	
	health = health - d
	
	update_powerup()