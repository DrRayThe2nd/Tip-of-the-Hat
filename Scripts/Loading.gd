extends Node2D

export(String) var path = "res://Scenes/Main Menu.tscn"

func lar(path):
	get_parent().add_child(load(path).instance())
	queue_free()

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.set_wait_time(1)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	lar(path)