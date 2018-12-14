extends Camera2D

onready var root = get_parent()
onready var plrs = root.get_node("Characters").get_children()
onready var current_player = root.get_node("Characters/Character A")
onready var last_player = current_player
onready var up = $"All Controls/Up"
onready var down = $"All Controls/Down"
onready var left = $"All Controls/Left"
onready var right = $"All Controls/Right"
onready var attack = $"All Controls/Attack"

var timer

func timeout():
	# Error here:
	# No member "position" on object "previously freed instace
	# Caused by death of the next player in line
	position = Vector2(clamp(current_player.position.x - 120 + 8, 0, 240), clamp(current_player.position.y - 72 + 24, 0, 144 - 32))

func _ready():
	up.connect("button_up", current_player, "move_up")
	down.connect("button_up", current_player, "move_down")
	left.connect("button_up", current_player, "move_left")
	right.connect("button_up", current_player, "move_right")
	attack.connect("button_up", current_player, "attack")
	
	set_process(true)

func _process(delta):
	plrs = root.get_node("Characters").get_children() # Needed again for player death
	
	for plr in plrs:
		if plr.turn:
			current_player = plr
			$"All Controls/Health".plr = current_player
	
	if last_player != current_player:
		timer = Timer.new()
		timer.connect("timeout", self, "timeout")
		timer.set_wait_time(1)
		add_child(timer)
		timer.start()
	
	if current_player.has_powerup:
		$"All Controls/Powerup".texture = load("res://Assets/" + current_player.powerup + ".png")
	else:
		$"All Controls/Powerup".texture = preload("res://Assets/Blank.png")
	
	if current_player != last_player:
		up.disconnect("button_up", last_player, "move_up")
		up.connect("button_up", current_player, "move_up")
		
		down.disconnect("button_up", last_player, "move_down")
		down.connect("button_up", current_player, "move_down")
		
		left.disconnect("button_up", last_player, "move_left")
		left.connect("button_up", current_player, "move_left")
		
		right.disconnect("button_up", last_player, "move_right")
		right.connect("button_up", current_player, "move_right")
		
		attack.disconnect("button_up", last_player, "attack")
		attack.connect("button_up", current_player, "attack")
		
		last_player = current_player