extends Node

const JUMPERS = ["White Horse", "Zombie Horse", "Black Widow", "Brown Recluse"]
const ATTACKERS = ["Joe", "Zombie"]
const POISON = ["Black Widow", "Brown Recluse"]
const HEALTH = ["Blue Sheep", "Pink Sheep"]
const RANGE = ["Skunk"]
const POWERUPS = ["Jump", "Medkit", "Sword"]#, "TNT"]
const VECTORS = [Vector2(-16, -16), Vector2(  0, -16), Vector2( 16, -16),
				 Vector2(-16,   0), Vector2(  0,   0), Vector2( 16,   0),
				 Vector2(-16,  16), Vector2(  0,  16), Vector2( 16,  16)]
const VECTORS2  =  [Vector2(-32, -32), Vector2(-16, -32), Vector2(  0, -32), Vector2( 16, -32), Vector2( 32, -32),
					Vector2(-32, -16), Vector2( 32, -16),
					Vector2(-32,   0), Vector2( 32,   0),
					Vector2(-32,  16), Vector2( 32,  16),
					Vector2(-32,  32), Vector2(-16,  32), Vector2(  0,  32), Vector2( 16,  32), Vector2( 32,  32)]

var FAR_CORNER = Vector2(240, 144 - 48)

func choose(from):
	if typeof(from) != typeof([]):
		return []
	
	randomize()
	
	return from[randi() % len(from)]

func choose_powerup():
	randomize()
	
	return POWERUPS[randi() % len(POWERUPS)]