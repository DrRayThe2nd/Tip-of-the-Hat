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
var plrs = []
var last_powerup
var temp
var pnum
var checks = []
var players = 2
var names = ["Joe", "Zombie", "Blue Sheep", "Pink Sheep", "White Horse", "Zombie Horse", "Black Widow", "Brown Recluse"]

func update_turns():
	turn = false
	
	if players == 2:
		plr.turn = true
	elif players == 4:
		if name.ends_with("A"):
			plrs[1].turn = true
		elif name.ends_with("B"):
			plrs[2].turn = true
		elif name.ends_with("C"):
			plrs[3].turn = true
		else:
			plrs[0].turn = true

func set_sprite():
	if sprite_name != "Random":
		sprite_path = "res://Assets/" + sprite_name + ".png"
	else:
		randomize()
		sprite_name = AL.choose(names)
		sprite_path = "res://Assets/" + sprite_name + ".png"
		if sprite_name in AL.HEALTH:
			health += 1
		elif sprite_name in AL.ATTACKERS:
			damage += 1
	get_node("Sprite").texture = load(sprite_path)
	if sprite_name in AL.JUMPERS:
		can_jump = true
	
	if name.ends_with("A"):
		$Team.color = Color(255, 0, 0)
	elif name.ends_with("B"):
		$Team.color = Color(0, 0, 255)
	elif name.ends_with("C"):
		$Team.color = Color(255, 255, 0)
	elif name.ends_with("D"):
		$Team.color = Color(255, 0, 255)

func update_powerup():
	if players == 2:
		if name.ends_with("A"):
			pwr = $"../../Controls/Player A/Powerup"
		elif name.ends_with("B"):
			pwr = $"../../Controls/Player B/Powerup"
	elif players == 4:
		pwr = $"../../Controls/All Controls/Powerup"
	
	if has_powerup and powerup != last_powerup:
		if powerup == "Jump":
			pwr.texture = load("res://Assets/Jump.png")
			can_jump = true
			if last_powerup == "Medkit":
				health -= 1
			elif not sprite_name in AL.ATTACKERS:
				damage -= 1
		elif powerup == "Medkit":
			pwr.texture = load("res://Assets/Medkit.png")
			health += 1
			if last_powerup == "Jump" and not sprite_name in AL.JUMPERS:
				can_jump = false
			elif not sprite_name in AL.ATTACKERS:
				damage -= 1
		else:
			pwr.texture = load("res://Assets/Sword.png")
			damage += 1
			if last_powerup == "Medkit":
				health -= 1
			elif not sprite_name in AL.JUMPERS:
				can_jump = false
		last_powerup = powerup

func _ready():
	if name.ends_with("A"):
		pnum = 1
	elif name.ends_with("B"):
		pnum = 2
	elif name.ends_with("C"):
		pnum = 3
	elif name.ends_with("D"):
		pnum = 4
	
	set_sprite()
	
	if name.ends_with("A"):
		plr = get_node("../Character B")
	elif name.ends_with("B"):
		plr = get_node("../Character A")
	
	if players != 2:
		plr = null
		
		for child in get_parent().get_children():
			plrs.append(child)
	
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
			if child.position == pos and child != self:
				return false
	
		for child in get_parent().get_parent().get_node("Map").get_children():
			if child.position == pos and child.jump and not can_jump:
				return false
	
	if turn:
		return true
	
	return false

func move_up():
	if turn or players == 2:
		new_pos = Vector2(position.x, position.y - 16)
		get_node("Sprite").rotation_degrees = 0
		
		check = check_pos(new_pos)
		
		if check or not check_pos(position):
			position = new_pos
			update_turns()
		
		return check

func move_down():
	if turn or players == 2:
		new_pos = Vector2(position.x, position.y + 16)
		get_node("Sprite").rotation_degrees = 180
		
		check = check_pos(new_pos)
		
		checks = []
		for vec in [vectors[1] + position, vectors[3] + position, vectors[5] + position, vectors[7] + position]:
			checks.append(check_pos(vec))
		if not true in checks:
			check = true
		
		if check or not check_pos(position):
			position = new_pos
			update_turns()
		
		return check

func move_left():
	if turn or players == 2:
		new_pos = Vector2(position.x - 16, position.y)
		get_node("Sprite").rotation_degrees = -90
		
		check = check_pos(new_pos)
		
		if check or not check_pos(position):
			position = new_pos
			update_turns()
		
		return check

func move_right():
	if turn or players == 2:
		new_pos = Vector2(position.x + 16, position.y)
		get_node("Sprite").rotation_degrees = 90
		
		check = check_pos(new_pos)
		
		if check or not check_pos(position):
			position = new_pos
			update_turns()
		
		return check

func attack():
	if turn or players == 2:
		for vec in vectors:
			for child in $"../../Map".get_children():
				if position + vec == child.position and child.is_powerup and turn:
					if name.ends_with("A"):
						child.take_crate(1)
					elif name.ends_with("B"):
						child.take_crate(2)
					elif name.ends_with("C"):
						child.take_crate(3)
					elif name.ends_with("D"):
						child.take_crate(4)
					update_powerup()
					
					update_turns()
			
			for child in get_parent().get_children():
				if position + vec == child.position and child != self and turn:
					child.attacked(powerup, damage)
					
					update_turns()

func attacked(p, d):
	if powerup == "Medkit":
		has_powerup = false
		powerup = null
	
	health -= d
	if players == 2:
		if plr.sprite_name in AL.POISON:
			randomize()
			health -= randi() % 2
	else:
		for child in get_parent().get_children():
			if child.turn and child.sprite_name in AL.POISON:
				randomize()
				health -= randi() % 2
	
	update_powerup()