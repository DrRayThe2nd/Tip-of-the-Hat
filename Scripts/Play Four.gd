extends Node2D

var selecting = 1
var ca = "Joe"
var cb = "Joe"
var cc = "Joe"
var cd = "Joe"

func _ready():
	pass

func _on_Back_pressed():
	$"..".add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()

func _on_Play_pressed():
	selecting += 1
	$"UI/Character Options".des("Joe")
	
	if selecting > 4:
		# Something doesn't work here!
		# Please fix!
		$"..".add_child(load("res://Scenes/Four Player Game.tscn").instance())
		$"../Four Player Game".update_characters(ca, cb, cc, cd)
		queue_free()