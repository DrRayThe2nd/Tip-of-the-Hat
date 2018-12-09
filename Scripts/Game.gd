extends Node2D

const win_a = preload("res://Assets/Winner A.png")
const win_b = preload("res://Assets/Winner B.png")

var add

onready var p1 = $"Characters/Character A"
onready var p2 = $"Characters/Character B"
onready var winner = $Controls/Winner
onready var game_over = $"Controls/Game Over"
onready var c1 = $Map/Crate
onready var c2 = $Map/Crate2
onready var c3 = $Map/Crate3

func update_characters(ca, cb):
	p1.sprite_name = ca
	p2.sprite_name = cb
	
	p1.set_sprite()
	p2.set_sprite()
	
	if p1.sprite_name.ends_with("Sheep"):
		p1.health += 1
	if p2.sprite_name.ends_with("Sheep"):
		p2.health += 1
	
	for p in [p1, p2]:
		if p.sprite_name in ["Joe", "Zombie", "Black Widow", "Brown Recluse"]:
			p.damage = 2
	
	p1.turn = true

func _ready():
	for c in [c1, c2, c3]:
		randomize()
		c.position = Vector2((randi() % (240 / 16)) * 16, randi() % ((144 - 48) / 16) * 16)
	
	p1.turn = true
	
	set_process(true)

func _process(delta):
	if p1.health <= 0 or p2.health <= 0:
		print("-==========-")
		print(" Game over! ")
		print("-==========-")
		set_process(false)
		
		for child in $Controls.get_children():
			child.hide()
		
		if p1.health <= 0:
			winner.texture = win_b
		else:
			winner.texture = win_a
		
		winner.show()
		game_over.show()
		game_over.disabled = false

func end_game():
	get_parent().add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()