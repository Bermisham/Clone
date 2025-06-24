extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Label = $Timer

var MOVE_SPEED : float
var JUMP_VELOCITY : float
var coyoteTime : float = 0.1

var canJump := true
var airTime : float = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var movementArray : Array
var movementStep := 0

var paused := false

var time := 0.0

# Initiate Clone Values
func SetCloneValues(mvSpeed : float, jpVelocity : float, moveArr : Array, visual : bool) -> void:
	MOVE_SPEED = mvSpeed
	JUMP_VELOCITY = jpVelocity
	movementArray = moveArr
	GlobalHandler.pause_changed.connect(func(state:bool): paused = state)
	
	if visual:
		sprite_2d.frame = 5
		timer.add_theme_color_override("font_color", Color("cba6f7"))
		set_collision_mask_value(3, true)
		set_collision_mask_value(2, false)
	else:
		set_collision_layer_value(4, true)

func _process(delta: float) -> void:
	if !paused:
		time += delta
		timer.text = str("%0.1f" % time)

func _physics_process(delta: float) -> void:
	if !paused:
		if movementStep < movementArray[0].size():
			# Get current steps values
			var direction = movementArray[0][movementStep]
			var jump = movementArray[1][movementStep]
			# var interact = movementArray[2][movementStep]
			movementStep += 1
			
			if !is_on_floor():
				velocity.y += gravity * delta
				if canJump and airTime < coyoteTime:
					airTime += delta
				elif canJump:
					airTime = 0
					canJump = false
			else:
				canJump = true
			
			if jump == 1 and canJump:
				velocity.y = JUMP_VELOCITY
	
			if direction:
				velocity.x = direction * MOVE_SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
	
			move_and_slide()
		else:
			queue_free()
