extends KinematicBody

# MOVEMENTS
var speed = 14
var fall_acceleration = 75
var velocity = Vector3.ZERO
# JUMP
var jump_impulse = 40
# FOR TOGGLE CROUCHING
var crouching = false

onready var statemachine = $AnimationTree.get("parameters/playback")

func _ready():
	statemachine.start("idle-loop")
	$AnimationTree.active = true
	
	
func _physics_process(delta):
	
# MOVEMENTS
	var direction = Vector3.ZERO
	var runSpeed = 1
	var current = statemachine.get_current_node()

	
	if is_on_floor():

		if Input.is_action_pressed("forward") && Input.is_action_pressed("run"):
			direction.z += 1
			runSpeed = 3
			statemachine.travel("run-loop")
		elif Input.is_action_pressed("forward"):
			direction.z += 1
			statemachine.travel("walk-loop")
		else:
			statemachine.travel("idle-loop")
			
			
		if Input.is_action_pressed("left") && Input.is_action_pressed("run"):
			direction.x += 1
			runSpeed = 3
			statemachine.travel("run-loop")
		elif Input.is_action_pressed("left"):
			direction.x += 1
			statemachine.travel("walk-loop")
			
			
		if Input.is_action_pressed("right") && Input.is_action_pressed("run"):
			direction.x -= 1
			runSpeed = 3
			statemachine.travel("run-loop")
		elif Input.is_action_pressed("right"):
			direction.x -= 1
			statemachine.travel("walk-loop")
			
			
		if Input.is_action_pressed("backward") && Input.is_action_pressed("run"):
			direction.z -= 1
			runSpeed = 3
			statemachine.travel("run-loop")
		elif Input.is_action_pressed("backward"):
			direction.z -= 1
			statemachine.travel("walk-loop")
			
		# JUMP
		if Input.is_action_just_pressed("jump"):
			velocity.y += jump_impulse
			statemachine.travel("jump")
		
		# ATTACK
		if Input.is_action_just_pressed("attack"):
			statemachine.travel("attack")
			
			
		# FOR TOGGLE CROUCHING
		if Input.is_action_just_pressed("crouch"):
			crouching = !crouching
		if (crouching):
			statemachine.travel("crouch")
			
			
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
	

