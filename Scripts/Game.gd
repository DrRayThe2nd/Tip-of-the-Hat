extends Node2D

const win_a = preload("res://Assets/Winner A.png")
const win_b = preload("res://Assets/Winner B.png")
const win_c = preload("res://Assets/Winner C.png")
const win_d = preload("res://Assets/Winner D.png")

var add
var pos
var obstacles = []
var players = 2
var plrs

onready var p1 = $"Characters/Character A"
onready var p2 = $"Characters/Character B"
var p3
var p4
onready var winner = $Controls/Winner
onready var game_over = $"Controls/Game Over"
onready var c1 = $Map/Crate
onready var c2 = $Map/Crate2
onready var c3 = $Map/Crate3

func update_characters(ca, cb, cc, cd):
	p1.sprite_name = ca
	p2.sprite_name = cb
	
	if cc != null and cd != null:
		p3.sprite_name = cc
		p4.sprite_name = cd
	
	p1.set_sprite()
	p2.set_sprite()
	
	if cc != null and cd != null:
		p3.set_sprite()
		p4.set_sprite()
	
	
	for p in plrs:
		if p.sprite_name in AL.HEALTH:
			p.health += 1
	
	for p in plrs:
		if p.sprite_name in AL.ATTACKERS:
			p.damage += 1
	
	p1.turn = true

func _ready():
	plrs = [p1, p2]
	if name.begins_with("Four"):
		p3 = $"Characters/Character C"
		p4 = $"Characters/Character D"
		plrs.append(p3)
		plrs.append(p4)
	
	if name.begins_with("Four"):
		players = 4
		AL.FAR_CORNER = Vector2((AL.FAR_CORNER.x - 8) * 2, AL.FAR_CORNER.y * 2)
		for p in plrs:
			p.players = 4
			p._ready()
	
	for child in $Map.get_children():
		if child.name.begins_with("Obs"):
			obstacles.append(child)
	
	randomize()
	
	for c in $Map.get_children():
		pos = Vector2((randi() % int(AL.FAR_CORNER.x / 16)) * 16, randi() % int(AL.FAR_CORNER.y / 16) * 16)
		c.position = pos
	
	for o in obstacles:
		o.sprite_name = AL.choose(["Snow", "Dirt", "Sand"])
		o.set_sprite()
	
	p1.turn = true
	
	set_process(true)

func _process(delta):
	for p in plrs:
		if p.health <= 0:
			plrs.erase(p)
			p.queue_free()
			if len(plrs) == 1:
				print("-==========-")
				print(" Game over! ")
				print("-==========-")
				set_process(false)
				$Controls.set_process(false)
				
				for child in $Controls.get_children():
					child.hide()
				
				if plrs[0] == p1:
					winner.texture = win_a
				elif plrs[0] == p2:
					winner.texture = win_b
				elif plrs[0] == p3:
					winner.texture = win_c
				else:
					winner.texture = win_d
				
				winner.show()
				game_over.texture_normal = load("res://Assets/Game Over.png")
				game_over.texture_hover = load("res://Assets/Game Over Pressed.png")
				game_over.texture_pressed = load("res://Assets/Game Over Pressed.png")
				game_over.rect_position.x -= 8

func end_game():
	get_parent().add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()