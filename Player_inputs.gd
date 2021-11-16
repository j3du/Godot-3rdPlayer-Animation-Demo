extends KinematicBody

# FOR TOGGLE CROUCHING
var pose = STAND
const STAND = 1
const CROUCH = 0

func _ready():
	$AnimationPlayer.playback_speed = 2

func _physics_process(delta):

	if Input.is_action_pressed("forward") && Input.is_action_pressed("run"):
		$AnimationPlayer.play("run-loop")
	elif Input.is_action_pressed("forward"):
		$AnimationPlayer.play("walk-loop")
		
	if Input.is_action_pressed("backward"):
		$AnimationPlayer.play("walk-loop")
	if Input.is_action_pressed("left"):
		$AnimationPlayer.play("left")
	if Input.is_action_pressed("right"):
		$AnimationPlayer.play("right")
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("attack")
	if Input.is_action_pressed("jump"):
		$AnimationPlayer.play("jump")
		
# FOR TOGGLE CROUCHING
	if Input.is_action_pressed("crouch"):
		if pose == STAND:
			$AnimationPlayer.play("crouch")
		else:
			$AnimationPlayer.play_backwards("crouch")
			

# FOR IDLE LOOP
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
