extends Node2D

func lar(path):
	get_parent().add_child(load(path).instance())
	queue_free()

func _ready():
	pass

func _on_Play_pressed():
	lar("res://Scenes/Play.tscn")