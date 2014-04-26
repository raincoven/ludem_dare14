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
	
func start():
	get_node(play_button).set_disabled(true)
	get_node(play_button).set_opacity(0)
	screen_size = get_viewport_rect().size
	set_process(true)
	reset_obstacle(Obstacle,0)
	score = 0
	dead = false
	obsSpeed = 2
	var playerPos = get_node(player).get_pos()
	playerPos.y = 200
	get_node(player).set_pos(playerPos)
	
func calc_offset():
	return rand_range(50, 250)
	
func reset_obstacle(obstacle,backoff):
	var offset = calc_offset()
	var bottom_pos = get_node(obstacle).get_pos()
	bottom_pos.x = offset
	bottom_pos.y = 400
	get_node(obstacle).set_pos(bottom_pos)
	
func player_crashed():
	dead = true
	get_node(play_button).set_disabled(false)
	get_node(play_button).set_opacity(1)
	
func check_intersect(gg,obs):
	var X1 = gg.get_pos().x
	var Y1 = gg.get_pos().y
	var W1 = gg.get_scale().x
	var H1 = gg.get_scale().y
	var X2 = obs.get_pos().x
	var Y2 = obs.get_pos().y
	var W2 = obs.get_scale().x
	var H2 = obs.get_scale().y
	if (X1+W1<X2 || X2+W2<X1 || Y1+H1<Y2 || Y2+H2<Y1):
		return 1
	return 0
	
func _process(delta):
	if !dead:
		player_pos = get_node(player).get_pos()
		if Input.is_action_pressed("arrow_left"):
			if(player_pos.x>50):
				player_pos.x = player_pos.x-1

		if Input.is_action_pressed("arrow_right"):
			if(player_pos.x<250):
				player_pos.x = player_pos.x+1
		
		get_node(player).set_pos(player_pos)

		var obs_bot_pos = get_node(Obstacle).get_pos()
		obs_bot_pos.y = obs_bot_pos.y - obsSpeed
		get_node(Obstacle).set_pos(obs_bot_pos)
		
		if (check_intersect(get_node(player), get_node(Obstacle))):
		#	player_crashed()
			pass
		
		if obs_bot_pos.y < -10:
			reset_obstacle(Obstacle,40)