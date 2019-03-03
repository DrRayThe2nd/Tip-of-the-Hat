extends Control

const joe = 'Joe\nAbility: Attack\nHealth: 3\nDamage: 2'
const zombie = 'Zombie\nAbility: Attack\nHealth: 3\nDamage: 2'
const blue_sheep = 'Blue Sheep\nAbility: Health\nHealth: 4\nDamage: 1'
const pink_sheep = 'Pink Sheep\nAbility: Health\nHealth: 4\nDamage: 1'
const white_horse = 'White Horse\nAbility: Jump\nHealth: 3\nDamage: 1'
const zombie_horse = 'Zombie Horse\nAbility: Jump\nHealth: 3\nDamage: 1'
const brown_recluse = 'Brown Recluse\nAbility: Poison\nHealth: 3\nDamage: 1-3'
const black_widow = 'Black Widow\nAbility: Poison\nHealth: 3\nDamage: 1-3'
const skunk = 'Skunk\nAbility: Range\nHealth: 3\nDamage: 1'

onready var label = get_node("Label")
onready var root = $"../.."

func des(keep):
	for child in get_children():
		if child.name != 'Label':
			child.pressed = false
	
	get_node(keep).pressed = true
	if root.selecting == 1:
		root.ca = keep
	elif root.selecting == 2:
		root.cb = keep
	elif root.selecting == 3:
		root.cc = keep
	elif root.selecting == 4:
		root.cd = keep

func _ready():
	des("Joe")
	label.text = joe

func _on_Joe_pressed():
	des("Joe")
	label.text = joe

func _on_Zombie_pressed():
	des("Zombie")
	label.text = zombie

func _on_Blue_Sheep_pressed():
	des("Blue Sheep")
	label.text = blue_sheep

func _on_Pink_Sheep_pressed():
	des("Pink Sheep")
	label.text = pink_sheep

func _on_Horse_pressed():
	des("White Horse")
	label.text = white_horse

func _on_Zombie_Horse_pressed():
	des("Zombie Horse")
	label.text = zombie_horse

func _on_Brown_Recluse_pressed():
	des("Brown Recluse")
	label.text = brown_recluse

func _on_Black_Widow_pressed():
	des("Black Widow")
	label.text = black_widow

func _on_Skunk_pressed():
	des("Skunk")
	label.text = skunk