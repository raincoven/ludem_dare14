extends Node2D
var screen_size
var pipeSpeed = 1
#var pipeArray = [["pipe_bottom","pipe_top"],["pipe2_bottom","pipe2_top"],["pipe3_bottom","pipe3_top"]]

var Obstacle = "pipe_top"

var GGPOS
var GGSCALE

var poppy_pos
var dead = false
var score = 0
var lastPipeScored = 10

func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
	start()
	
func start():
	get_node("Button").set_disabled(true)
	get_node("Button").set_opacity(0)
	#get_node("splash").set_opacity(0)
	screen_size = get_viewport_rect().size
	set_process(true)
	reset_pipe(0,0)
	reset_pipe(1,120)
	reset_pipe(2,240)
	score = 0
	lastPipeScored = 10
	dead = false
	pipeSpeed = 2
	var baloonPos = get_node("poppy").get_pos()
	baloonPos.y = 200
	get_node("poppy").set_pos(baloonPos)
	
func calc_offset():
	return rand_range(50, 250)
	
func reset_pipe(pipe,backoff):
	var offset = calc_offset()
	var bottom_pos = get_node(Obstacle).get_pos()
	bottom_pos.x = offset
	bottom_pos.y = 400
	get_node(Obstacle).set_pos(bottom_pos)
	
func poppy_crashed():
	get_node("score").set_text("POP!!")
	dead = true
	get_node("Button").set_disabled(false)
	get_node("Button").set_opacity(1)
	
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
		get_node("score").set_text(str(score))
		poppy_pos = get_node("poppy").get_pos()
		if Input.is_action_pressed("arrow_left"):
			if(poppy_pos.x>50):
				poppy_pos.x = poppy_pos.x-1

		if Input.is_action_pressed("arrow_right"):
			if(poppy_pos.x<250):
				poppy_pos.x = poppy_pos.x+1
		
		get_node("poppy").set_pos(poppy_pos)

		var pipe_bot_pos = get_node(Obstacle).get_pos()
		pipe_bot_pos.y = pipe_bot_pos.y - pipeSpeed
		get_node(Obstacle).set_pos(pipe_bot_pos)
		
		if (check_intersect(get_node("poppy"), get_node(Obstacle))):
		#	poppy_crashed()
			pass
		
		if pipe_bot_pos.y < -10:
			reset_pipe("LOL",40)