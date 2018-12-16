extends Sprite

const zero = preload("res://Assets/Zero.png")
const zero_plus = preload("res://Assets/Plus.png")
const one = preload("res://Assets/One.png")
const one_plus = preload("res://Assets/One Plus.png")
const two = preload("res://Assets/Two.png")
const two_plus = preload("res://Assets/Two Plus.png")
const three = preload("res://Assets/Three.png")
const three_plus = preload("res://Assets/Three Plus.png")
const four = preload("res://Assets/Four.png")
const four_plus = preload("res://Assets/Four Plus.png")

var plr

func _ready():
	if $"..".name.ends_with("A") and $"../../..".players == 2:
		plr = get_parent().get_parent().get_parent().get_node("Characters/Character A")
	elif $"..".name.ends_with("B") and $"../../..".players == 2:
		plr = get_parent().get_parent().get_parent().get_node("Characters/Character B")
	else:
		plr = get_parent().get_parent().get_parent().get_node("Characters/Character A")
	
	set_process(true)

func _process(delta):
	if plr:
		if plr.powerup == "Medkit":
			if plr.health == 1:
				texture = zero_plus
			elif plr.health == 2:
				texture = one_plus
			elif plr.health == 3:
				texture = two_plus
			elif plr.health == 4:
				texture = three_plus
			else:
				texture = four_plus
		else:
			if plr.health == 0:
				texture = zero
			elif plr.health == 1:
				texture = one
			elif plr.health == 2:
				texture = two
			elif plr.health == 3:
				texture = three
			else:
				texture = four