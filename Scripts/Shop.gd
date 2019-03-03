extends Node2D

var ov = 0

func _ready():
	get_node("VScrollBar").max_value = len(get_node("Label").text) / 2.4

func back():
	get_parent().add_child(load("res://Scenes/Main Menu.tscn").instance())
	queue_free()

func _on_VScrollBar_scrolling():
	get_node("Label").rect_position.y -= get_node("VScrollBar").value - ov
	ov = get_node("VScrollBar").value