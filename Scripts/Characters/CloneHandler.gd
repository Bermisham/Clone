extends CharacterBody2D

var MOVE_SPEED : float
var JUMP_VELOCITY : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var movementArray : Array
var movementStep := 0

var paused := false

# Initiate Clone Values
func SetCloneValues(mvSpeed : float, jpVelocity : float, moveArr : Array):
	MOVE_SPEED = mvSpeed
	JUMP_VELOCITY = jpVelocity
	movementArray = moveArr
	GlobalHandler.pause_changed.connect(_PauseChange)

func _PauseChange(state : bool):
	paused = state

func _physics_process(delta: float) -> void:
	if movementStep < movementArray[0].size():
		# Get current steps values
		var direction = movementArray[0][movementStep]
		var jump = movementArray[1][movementStep]
		var interact = movementArray[2][movementStep]
		movementStep += 1
	
		# Use player movement script with step values
		if !is_on_floor():
			velocity.y += gravity * delta
		else:
			if jump == 1:
				velocity.y = JUMP_VELOCITY
	
		if direction:
			velocity.x = direction * MOVE_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
	
		move_and_slide()
	else:
		queue_free()
