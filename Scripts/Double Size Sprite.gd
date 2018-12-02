extends Sprite

func _ready():
	set_process(true)

func _process(delta):
	if get_parent().pressed:
		texture = load("res://Assets/White_HorseSelected.png")
	else:
		texture = load("res://Assets/White_Horse.png")