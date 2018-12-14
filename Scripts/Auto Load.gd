extends Node

const JUMPERS = ["White Horse", "Zombie Horse", "Black Widow", "Brown Recluse"]
const ATTACKERS = ["Joe", "Zombie"]
const POISON = ["Black Widow", "Brown Recluse"]
const HEALTH = ["Blue Sheep", "Pink Sheep"]
const POWERUPS = ["Jump", "Medkit", "Sword"]#, "TNT"]
const VECTORS = [Vector2(-16, -16), Vector2(  0, -16), Vector2( 16, -16),
				 Vector2(-16,   0), Vector2(  0,   0), Vector2( 16,   0),
				 Vector2(-16,  16), Vector2(  0,  16), Vector2( 16,  16)]

var FAR_CORNER = Vector2(240, 144 - 48)

func choose(from):
	if typeof(from) != typeof([]):
		return []
	
	var l = len(from)
	
	randomize()
	
	return from[randi() % l]

func choose_powerup():
	randomize()
	
	return POWERUPS[randi() % len(POWERUPS)]