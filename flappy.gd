
extends Node2D
var screen_size
var pipeSpeed = 2
var pipeArray = [["pipe_bottom","pipe_top"],["pipe2_bottom","pipe2_top"],["pipe3_bottom","pipe3_top"]]
 
var flappy_pos
var dead = false
var score = 0
var lastPipeScored = 10


func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")
	start()
	
	
func _on_button_pressed():
	start()
	
func start():
	get_node("Button").set_disabled(true)
	get_node("Button").set_opacity(0)
	screen_size = get_viewport_rect().size
	set_process(true)
	reset_pipe(0,0)
	reset_pipe(1,120)
	reset_pipe(2,240)
	score = 0
	lastPipeScored = 10
	dead = false
	pipeSpeed = 2
	
func calc_offset():
	return rand_range(-50, 50)
	
func reset_pipe(pipe,backoff):
	var offset = calc_offset()
	var bottom_pos = get_node(pipeArray[pipe][0]).get_pos()
	var top_pos = get_node(pipeArray[pipe][1]).get_pos()
	bottom_pos.x = screen_size.x + backoff
	bottom_pos.y = 350 + offset
	top_pos.x = bottom_pos.x
	top_pos.y = 50 + offset
	get_node(pipeArray[pipe][0]).set_pos(bottom_pos)
	get_node(pipeArray[pipe][1]).set_pos(top_pos)
	
	
func flappy_crashed():
	get_node("score").set_text("POP!!")
	dead = true
	get_node("Button").set_disabled(false)
	get_node("Button").set_opacity(1)
	
func _process(delta):
	if !dead:
		if score > 5:
			pipeSpeed = 2
		if score > 15:
			pipeSpeed = 3
		if score > 25:
			pipeSpeed = 4
		if score > 40:
			pipeSpeed = 5
			
		get_node("score").set_text(str(score))
		flappy_pos = get_node("bird").get_pos()
		if Input.is_action_pressed("jump"):
			flappy_pos.y = flappy_pos.y+4
		else:
			flappy_pos.y = flappy_pos.y-2
		get_node("bird").set_pos(flappy_pos)
		
		var pipeID = 0;
		for pipe in pipeArray:
			var pipe_bot_pos = get_node(pipe[0]).get_pos()
			var pipe_top_pos = get_node(pipe[1]).get_pos()
			pipe_bot_pos.x = pipe_bot_pos.x - pipeSpeed
			pipe_top_pos.x = pipe_bot_pos.x
			get_node(pipe[0]).set_pos(pipe_bot_pos)
			get_node(pipe[1]).set_pos(pipe_top_pos)	
		
			if (pipe_bot_pos.x-22 < flappy_pos.x+10) && (pipe_bot_pos.x+22 > flappy_pos.x-10):
				if flappy_pos.y > pipe_bot_pos.y - 115:
					flappy_crashed()
				if flappy_pos.y < pipe_top_pos.y + 115:
					flappy_crashed()
			
			if pipe_bot_pos.x < 20 :
				if lastPipeScored != pipeID:
					score = score + 1
					lastPipeScored = pipeID
		
			if pipe_bot_pos.x < -20:
				reset_pipe(pipeID,40)
			pipeID = pipeID + 1;