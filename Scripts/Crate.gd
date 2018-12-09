extends Node2D

const is_powerup = true
const jump = false

export(String) var type = "Jump"

var plr

func _ready():
	pass

func take_crate(player):
	if player == 1:
		plr = $"../../Characters/Character A"
	else:
		plr = $"../../Characters/Character B"
	
	plr.has_powerup = true
	if type == "Random":
		plr.powerup = AL.choose_powerup()
	else:
		plr.powerup = type
	plr.update_powerup()
	queue_free()