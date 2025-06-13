extends CharacterBody2D

@export var MOVE_SPEED : float
@export var JUMP_VELOCITY : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	GlobalHandler.SetPlayer(self)

func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("input_up"):
			velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = direction * MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
	
	move_and_slide()
