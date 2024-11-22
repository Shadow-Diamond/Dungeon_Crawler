extends CharacterBody2D

const SPEED = 100
var current_dir = "none"
var numCoinsMentioned = false

func _ready():
	$AnimatedSprite2D.play("FrontIdle")
	set_z_index(100)

func _physics_process(_delta):
	player_movement()

func player_movement():
	if Input.is_action_pressed("up") and Input.is_action_pressed("left"):
		current_dir = "up"
		play_anim(1)
		velocity.x = -SPEED/2
		velocity.y = -SPEED/2
	elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
		current_dir = "up"
		play_anim(1)
		velocity.x = SPEED/2
		velocity.y = -SPEED/2
	elif Input.is_action_pressed("down") and Input.is_action_pressed("left"):
		current_dir = "down"
		play_anim(1)
		velocity.x = -SPEED/2
		velocity.y = SPEED/2
	elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
		current_dir = "down"
		play_anim(1)
		velocity.x = SPEED/2
		velocity.y = SPEED/2
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("Sideways")
		elif movement == 0:
			anim.play("SideIdle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("Sideways")
		elif movement == 0:
			anim.play("SideIdle")
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("Upward")
		elif movement == 0:
			anim.play("BackIdle")
	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("Downward")
		elif movement == 0:
			anim.play("FrontIdle")

func player():
	pass
