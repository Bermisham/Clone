extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var MOVE_SPEED : float
@export var JUMP_VELOCITY : float
@export var coyoteTime : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canJump := true
var airTime : float = 0

var paused := false
var isCloneSprite := false
var cloneSpriteTime := 0.2
var tillCloneTime := 0.0
var lastFrame : int 

func _ready() -> void:
	GlobalHandler.SetPlayer(self)
	call_deferred("_connect")

	# Pause Handling
	GlobalHandler.pause_changed.connect(func(state:bool): paused = state)           

func _connect() -> void:
	GlobalHandler.sceneHandler.get_child(0).mode_change.connect(_SpriteChange)
	GlobalHandler.sceneHandler.clone_made.connect(_CloneMade)

func _SpriteChange(state : int) -> void:
	if !isCloneSprite:
		match state:
			0: sprite_2d.frame = 0
			1: sprite_2d.frame = 2
			2: sprite_2d.frame = 1

func _CloneMade() -> void:
	if sprite_2d.frame != 3:
		lastFrame = sprite_2d.frame
	sprite_2d.frame = 3
	tillCloneTime = 0.0
	isCloneSprite = true

func _physics_process(delta: float) -> void:
	
	if isCloneSprite:
		if tillCloneTime < cloneSpriteTime:
			tillCloneTime += delta
		else:
			isCloneSprite = false
			sprite_2d.frame = lastFrame
	
	if !paused:
		if !is_on_floor():
			velocity.y += gravity * delta
			if canJump and airTime < coyoteTime:
				airTime += delta
			elif canJump:
				airTime = 0
				canJump = false
		else:
			canJump = true
			
		if Input.is_action_just_pressed("input_up") and canJump:
			velocity.y = JUMP_VELOCITY
	
		var direction = Input.get_axis("input_left", "input_right")
		if direction:
			velocity.x = direction * MOVE_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
	
		move_and_slide()
