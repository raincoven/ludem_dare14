extends Node2D
var screen_size
var obsSpeed = 1

var Obstacle = "obstacle"
var play_button = "play_button"
var player = "player"

var GGPOS
var GGSCALE

var player_pos
var dead = false
var score = 0

func _ready():
	get_node(play_button).connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
	start()


func calc_offset():
	return rand_range(50, 250)
	
func reset_obstacle():
	var offset = calc_offset()
	var bottom_pos = get_node(Obstacle).get_pos()
	var player_pos = get_node(player).get_pos()
	bottom_pos.x = offset
	bottom_pos.y = player_pos.y+300
	get_node(Obstacle).set_pos(bottom_pos)


func start():
	set_fixed_process(true)
	get_node(play_button).set_disabled(true)
	get_node(play_button).set_opacity(0)
	screen_size = get_viewport_rect().size
	set_process(true)
	reset_obstacle()
	score = 0
	dead = false
	obsSpeed = 2
	var playerPos = get_node(player).get_pos()
	playerPos.y = 300
	get_node(player).set_pos(playerPos)

	
func player_crashed():
	dead = true
	get_node(play_button).set_disabled(false)
	get_node(play_button).set_opacity(1)
	
	
func _fixed_process(delta):
	if !dead:

		var obs_bot_pos = get_node(Obstacle).get_pos()
		var player_bot_pos = get_node(player).get_pos()
		
		#if (check_intersect(get_node(player), get_node(Obstacle))):
		#	player_crashed()
		
		if obs_bot_pos.y <= player_bot_pos.y-300:
			reset_obstacle()

func _on_Area2D_body_enter( body ):
	if (body extends preload("res://player.gd")):
		player_crashed()
