extends Sprite

export(String) var type = "White"

func _ready():
	set_process(true)

func _process(delta):
	if get_parent().pressed or get_parent().is_hovered() or get_parent().disabled:
		texture = load("res://Assets/" + type + " Horse Pressed.png")
	else:
		texture = load("res://Assets/" + type + " Horse.png")