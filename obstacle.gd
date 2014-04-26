
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)
	

func _fixed_process(delta):
	var stopped = move(Vector2(0,-3)).length() > 3
	if (stopped):
		var lol = "lol"
	
	

