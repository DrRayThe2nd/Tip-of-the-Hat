extends Node2D

func _ready():
	pass

func back():
	get_parent().add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()