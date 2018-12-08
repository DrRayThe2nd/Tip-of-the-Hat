extends Control

func des(keep):
	for child in get_children():
		child.pressed = false
	
	get_node(keep).pressed = true
	if name.ends_with("2"):
		$"../..".cb = keep
	else:
		$"../..".ca = keep
	
	print($"../..".ca)
	print($"../..".cb)
	print(" ")

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