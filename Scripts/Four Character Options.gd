extends Control

onready var root = $"../.."

func des(keep):
	for child in get_children():
		child.pressed = false
	
	get_node(keep).pressed = true
	if root.selecting == 1:
		root.ca = keep
	elif root.selecting == 2:
		root.cb = keep
	elif root.selecting == 3:
		root.cc = keep
	else:
		root.cd = keep

func _ready():
	des("Joe")

func _on_Joe_pressed():
	des("Joe")

func _on_Zombie_pressed():
	des("Zombie")

func _on_Blue_Sheep_pressed():
	des("Blue Sheep")

func _on_Pink_Sheep_pressed():
	des("Pink Sheep")

func _on_Horse_pressed():
	des("White Horse")

func _on_Zombie_Horse_pressed():
	des("Zombie Horse")

func _on_Brown_Recluse_pressed():
	des("Brown Recluse")

func _on_Black_Widow_pressed():
	des("Black Widow")