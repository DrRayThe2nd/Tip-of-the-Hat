extends Node2D

var health = 100
var new_pos = Vector2()
var check = false
export(bool) var test = true
export(String) var sprite_name = "Joe"
var sprite_path = ""

func _ready():
	sprite_path = "res://Assets/" + sprite_name + ".png"
	get_node("Sprite").texture = load(sprite_path)
	
	set_process(true)

func _process(delta):
	pass

func check_pos(pos):
	if pos.x < 0 or pos.x > AL.FAR_CORNER.x or pos.y < 0 or pos.y > AL.FAR_CORNER.y:
		return false
	
	if not test:
		for child in get_parent().get_children():
			if child.position == pos:
				return false
	
		for child in get_parent().get_parent().get_node("Map").get_children():
			if pos == child.position and child.jump:
				return false
	
	return true

func move_up():
	new_pos = Vector2(position.x, position.y - 16)
	get_node("Sprite").rotation_degrees = 0
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
	
	return check

func move_down():
	new_pos = Vector2(position.x, position.y + 16)
	get_node("Sprite").rotation_degrees = 180
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
	
	return check

func move_left():
	new_pos = Vector2(position.x - 16, position.y)
	get_node("Sprite").rotation_degrees = -90
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
	
	return check

func move_right():
	new_pos = Vector2(position.x + 16, position.y)
	get_node("Sprite").rotation_degrees = 90
	
	check = check_pos(new_pos)
	
	if check:
		position = new_pos
	
	return check