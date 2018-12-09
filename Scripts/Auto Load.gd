extends Node

var FAR_CORNER = Vector2(240, 144 - 48)
var JUMPERS = ["White Horse", "Zombie Horse", "Black Widow", "Brown Recluse"]

func choose_powerup():
	randomize()
	
	if randi() % 2 == 0:
		return "Jump"
	else:
		return "Medkit"