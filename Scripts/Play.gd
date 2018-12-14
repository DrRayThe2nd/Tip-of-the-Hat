extends Node2D

var ca = "Joe"
var cb = "Joe"

func _ready():
	pass

func _on_Back_pressed():
	$"..".add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()

func _on_Play_pressed():
	$"..".add_child(load("res://Scenes/Game.tscn").instance())
	$"../Game".update_characters(ca, cb, null, null)
	queue_free()