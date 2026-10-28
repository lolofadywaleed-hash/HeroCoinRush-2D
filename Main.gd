extends Node2D

var player: ColorRect
var coin: ColorRect
var score_label: Label

var player_x := 100.0
var player_y := 900.0
var vel_y := 0.0
var on_ground := true
var score := 0

const GRAVITY := 1800.0
const JUMP := -700.0
const SPEED := 220.0
const GROUND_Y := 900.0

func _ready():
	player = $Player
	coin = $Coin
	score_label = $ScoreLabel
	_spawn_coin()

func _process(delta):
	# Auto-run horizontally
	player_x += SPEED * delta
	if player_x > 720:
		player_x = -80
	player.position.x = player_x

	# Gravity + jump
	vel_y += GRAVITY * delta
	player_y += vel_y * delta
	if player_y >= GROUND_Y:
		player_y = GROUND_Y
		vel_y = 0.0
		on_ground = true
	player.position.y = player_y

	# Collect coin
	if player.get_rect().intersects(coin.get_rect()):
		score += 1
		score_label.text = "Score: %d" % score
		_spawn_coin()

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		if on_ground:
			vel_y = JUMP
			on_ground = false
	elif event is InputEventMouseButton and event.pressed:
		if on_ground:
			vel_y = JUMP
			on_ground = false

func _spawn_coin():
	coin.position.x = randf_range(100, 620)
	coin.position.y = randf_range(200, 700)
