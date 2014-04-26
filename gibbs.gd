
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func blow(gib):
	gib.apply_impulse(Vector2(rand_range(-360, 360),rand_range(-360, 360)),Vector2(rand_range(-360, 360),rand_range(-360, 360)))

func _ready():
	# Initalization here
	randomize()
	blow(get_node("arm_left"))
	blow(get_node("arm_right"))
	blow(get_node("leg_left"))
	blow(get_node("leg_right"))
	blow(get_node("body"))
	blow(get_node("lower_body"))
	pass


