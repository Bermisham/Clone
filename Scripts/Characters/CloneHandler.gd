extends CharacterBody2D

@onready var color_rect: ColorRect = $ColorRect

var MOVE_SPEED : float
var JUMP_VELOCITY : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var movementArray : Array
var movementStep := 0

var paused := false

# Initiate Clone Values
func SetCloneValues(mvSpeed : float, jpVelocity : float, moveArr : Array, visual : bool) -> void:
	MOVE_SPEED = mvSpeed
	JUMP_VELOCITY = jpVelocity
	movementArray = moveArr
	GlobalHandler.pause_changed.connect(func(state:bool): paused = state)
	
	if visual:
		color_rect.color = Color("#ffbfff", 0.65)
		set_collision_mask_value(3, true)
		set_collision_mask_value(2, false)
	else:
		color_rect.color = Color("#ffbfff")
		set_collision_layer_value(4, true)

func _physics_process(delta: float) -> void:
	if !paused:
		if movementStep < movementArray[0].size():
			# Get current steps values
			var direction = movementArray[0][movementStep]
			var jump = movementArray[1][movementStep]
			#var interact = movementArray[2][movementStep]
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
