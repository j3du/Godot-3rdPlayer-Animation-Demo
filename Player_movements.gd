extends KinematicBody

# MOVEMENTS
var speed = 14
var fall_acceleration = 75
var velocity = Vector3.ZERO
# JUMP
var jump_impulse = 30
# FOR TOGGLE CROUCHING
var pose = STAND
const STAND = 1
const CROUCH = 0


func _ready():
# SPEED UP ALL ANIMATIONS
	$AnimationPlayer.playback_speed = 2
	
func _physics_process(delta):
	
	# MOVEMENTS
	var direction = Vector3.ZERO
	var runSpeed = 1
	
	if is_on_floor():

		if Input.is_action_pressed("forward") && Input.is_action_pressed("run"):
			direction.z += 1
			runSpeed = 3
			$AnimationPlayer.play("run-loop")
		elif Input.is_action_pressed("forward"):
			direction.z += 1
			$AnimationPlayer.play("walk-loop")

		if Input.is_action_pressed("left") && Input.is_action_pressed("run"):
			direction.x += 1
			runSpeed = 3
			$AnimationPlayer.play("run-loop")
		elif Input.is_action_pressed("left"):
			direction.x += 1
			$AnimationPlayer.play("walk-loop")
			
		if Input.is_action_pressed("right") && Input.is_action_pressed("run"):
			direction.x -= 1
			runSpeed = 3
			$AnimationPlayer.play("run-loop")
		elif Input.is_action_pressed("right"):
			direction.x -= 1
			$AnimationPlayer.play("walk-loop")
		
		if Input.is_action_pressed("backward") && Input.is_action_pressed("run"):
			direction.z -= 1
			runSpeed = 3
			$AnimationPlayer.play("run-loop")
		elif Input.is_action_pressed("backward"):
			direction.z -= 1
			$AnimationPlayer.play("walk-loop")
			
		if Input.is_action_just_pressed("attack"):
			$AnimationPlayer.play("attack")
			
# FOR TOGGLE CROUCHING
		if Input.is_action_pressed("crouch"):
			if pose == STAND:
				$AnimationPlayer.play("crouch")
			else:
				$AnimationPlayer.play_backwards("crouch")
			
		velocity.x = direction.x * speed * runSpeed
		velocity.z = direction.z * speed * runSpeed

# MOVEMENTS ROTATION
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	


# JUMP
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
		$AnimationPlayer.play("jump")
		
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	
# BACK TO IDLE
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "walk-loop":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "run-loop":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "left":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "right":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "jump":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "attack":
		$AnimationPlayer.play("idle-loop")
	if anim_name == "crouch":
		if pose == STAND:
			pose = CROUCH
		else:
			pose = STAND
			$AnimationPlayer.play("idle-loop")
