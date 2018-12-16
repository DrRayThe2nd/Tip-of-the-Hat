extends Node2D

func lar(path):
	get_parent().add_child(load(path).instance())
	queue_free()

func _ready():
	set_process(false)

func _on_Play_pressed():
	lar("res://Scenes/Play.tscn")

func _on_Play_4_pressed():
	lar("res://Scenes/Play Four.tscn")

func _on_Shop_pressed():
	lar("res://Scenes/Shop.tscn")