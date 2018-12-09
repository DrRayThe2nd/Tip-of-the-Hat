extends Node2D

const is_powerup = false

export(String) var sprite_name = "Dirt"
export(bool) var jump = true

var sprite_path = ""

func set_sprite():
	sprite_path = "res://Assets/" + sprite_name + ".png"
	$"Sprite".texture = load(sprite_path)

func _ready():
	set_sprite()