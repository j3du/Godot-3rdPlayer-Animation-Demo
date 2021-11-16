extends KinematicBody

# MOVEMENTS
var speed = 14
var fall_acceleration = 75
var velocity = Vector3.ZERO
# JUMP
var jump_impulse = 30
# FOR TOGGLE CROUCHING
var crouching = false



func _ready():
	pass
	
func _physics_process(delta):
	
# MOVEMENTS
	var direction = Vector3.ZERO
	var runSpeed = 1
	
	if is_on_floor():

		if Input.is_action_pressed("forward") && Input.is_action_pressed("run"):
			direction.z += 1
			runSpeed = 3
			$AnimationTree.set("parameters/iwr/blend_amount", 1)
		elif Input.is_action_pressed("forward"):
			direction.z += 1
			$AnimationTree.set("parameters/iwr/blend_amount", -1)
		else:
			$AnimationTree.set("parameters/iwr/blend_amount", 0)
			

		if Input.is_action_pressed("left") && Input.is_action_pressed("run"):
			direction.x += 1
			runSpeed = 3
			$AnimationTree.set("parameters/iwr/blend_amount", 1)
		elif Input.is_action_pressed("left"):
			direction.x += 1
			$AnimationTree.set("parameters/iwr/blend_amount", -1)
			
			
		if Input.is_action_pressed("right") && Input.is_action_pressed("run"):
			direction.x -= 1
			runSpeed = 3
			$AnimationTree.set("parameters/iwr/blend_amount", 1)
		elif Input.is_action_pressed("right"):
			direction.x -= 1
			$AnimationTree.set("parameters/iwr/blend_amount", -1)
		
		
		if Input.is_action_pressed("backward") && Input.is_action_pressed("run"):
			direction.z -= 1
			runSpeed = 3
			$AnimationTree.set("parameters/iwr/blend_amount", 1)
		elif Input.is_action_pressed("backward"):
			direction.z -= 1
			$AnimationTree.set("parameters/iwr/blend_amount", -1)
			
		# JUMP
		if Input.is_action_just_pressed("jump"):
			velocity.y += jump_impulse
			$AnimationTree.set("parameters/jumpshot/active", true)
		
		# ATTACK
		if Input.is_action_just_pressed("attack"):
			$AnimationTree.set("parameters/attackshot/active", true)
			
			
		# FOR TOGGLE CROUCHING
		if Input.is_action_just_pressed("crouch"):
			crouching = !crouching
		if (crouching):
			$AnimationTree.set("parameters/standcrouch/current", 1)
		else:
			$AnimationTree.set("parameters/standcrouch/current", 0)
		
# MOVEMENTS SPEED
		velocity.x = direction.x * speed * runSpeed
		velocity.z = direction.z * speed * runSpeed
		
# MOVEMENTS ROTATION
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
# MOVEMENTS FALLING
	velocity.y -= fall_acceleration * delta

# MOVEMENTS MOVE_AND_SLIDE
	velocity = move_and_slide(velocity, Vector3.UP)
	
func _stopMoving():
	set_physics_process(false)
func _startMoving():
	set_physics_process(true)



