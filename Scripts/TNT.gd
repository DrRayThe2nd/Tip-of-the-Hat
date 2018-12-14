extends Node2D

const is_powerup = false
const jump = true

export(bool) var active = false
export(int, 1, 2) var rng = 1
export(int, 1, 3) var turns = 2

var player

func _ready():
	set_process(true)

func _process(delta):
	if active:
		if turns == 0:
			for child in $"../../Characters".get_children():
				for vec in AL.VECTORS:
					if (child.position == (position + vec) or child.position == (position + (rng * vec))) and child != player:
						child.attacked(null, 3)
			
			queue_free()