extends Node

const JUMPERS = ["White Horse", "Zombie Horse", "Black Widow", "Brown Recluse"]
const ATTACKERS = ["Joe", "Zombie"]
const POISON = ["Black Widow", "Brown Recluse"]
const HEALTH = ["Blue Sheep", "Pink Sheep"]

var FAR_CORNER = Vector2(240, 144 - 48)

func choose(from):
	if typeof(from) != typeof([]):
		return []
	
	var l = len(from)
	
	randomize()
	
	return from[randi() % l]

func choose_powerup():
	randomize()
	
	var temp = randi() % 3
	
	if temp == 0:
		return "Jump"
	elif temp == 1:
		return "Medkit"
	else:
		return "Sword"