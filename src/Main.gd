extends Node

func _ready():
	$Player.position = $Position2D.position

func _process(_delta):
	# Handle closing the game
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_pressed("reset"):
		$Player.position = $Position2D.position
