extends Node2D

func update_characters(ca, cb):
	$Characters/"Character A".sprite_name = ca
	$Characters/"Character B".sprite_name = cb
	
	$"Characters/Character A".set_sprite()
	$"Characters/Character B".set_sprite()

func _ready():
	pass