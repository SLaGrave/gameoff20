extends KinematicBody2D

export (float) var shoot_cooldown = 0.25

export (int) var speed = 400
export (int) var jump_speed = -600

export (int) var gravity = 1500
export (int) var grav_vert = 1
export (int) var grav_hori = -1

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

var shoot_on_cooldown = false

func _ready():
	$ShootCooldown.wait_time = shoot_cooldown

func get_movement():
    var dir = 0
    if Input.is_action_pressed("walk_right"):
        dir += 1
    if Input.is_action_pressed("walk_left"):
        dir -= 1
    if dir != 0:
        velocity.x = lerp(velocity.x, dir * speed, acceleration)
    else:
        velocity.x = lerp(velocity.x, 0, friction)

func handle_shooting():
	if Input.is_action_just_pressed("fire") and not shoot_on_cooldown:
		# TODO: Shooting Logic
		shoot_on_cooldown = true
		$ShootCooldown.start()

func _physics_process(delta):
	get_movement()
	handle_shooting()
	velocity.y += gravity * grav_vert * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x += gravity * grav_hori * delta * 3
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = grav_vert * jump_speed


func _on_ShootCooldown_timeout():
	shoot_on_cooldown = false
