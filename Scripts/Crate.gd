extends Node2D

const is_powerup = true
const jump = true

export(String) var type = "Jump"

var plr

func _ready():
	pass

func take_crate(player):
	if player == 1:
		plr = $"../../Characters/Character A"
	elif player == 2:
		plr = $"../../Characters/Character B"
	elif player == 3:
		plr = $"../../Characters/Character C"
	elif player == 4:
		plr = $"../../Characters/Character D"
	
	plr.has_powerup = true
	if type == "Random":
		plr.powerup = AL.choose_powerup()
	else:
		plr.powerup = type
	plr.update_powerup()
	queue_free()