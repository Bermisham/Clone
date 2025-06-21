extends Node2D

@onready var color_rect: ColorRect = $ColorRect
@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

@export_category("Values")
@export var locked := true
@export var length : int = 1

enum Dir {HORIZONTAL, VERTICAL}
@export var direction : Dir = Dir.VERTICAL

var TILE := 32.0

var activeColour = Color("f38ba8")
var inactiveColour = Color("a7e3a1a2")

func _ready() -> void:
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	
	match direction:
		Dir.VERTICAL:
			# set colour rect
			color_rect.set_size(Vector2(16, TILE*length))
			color_rect.position = Vector2(0, -TILE * length)
			#color_rect.global_position.y = global_position.y - ((TILE*length))

			# set collider
			collision_shape_2d.shape.size = Vector2(16, TILE*length)
			collision_shape_2d.position = Vector2(8, -TILE * length / 2)
			#collision_shape_2d.global_position.y = global_position.y - (TILE*(length - 1) - 16)
		Dir.HORIZONTAL:
			color_rect.set_size(Vector2(TILE*length, 16))
		
			collision_shape_2d.shape.size = Vector2(TILE*length, 16)
			collision_shape_2d.position = Vector2(TILE * length / 2, 8)
			#collision_shape_2d.global_position.x = global_position.x + ((TILE*(length - 1)) - 16)
	
	_SetState()

func Toggle() -> void:
	locked = !locked
	_SetState()

func _SetState() -> void:
	if locked: 
		color_rect.color = activeColour
		static_body_2d.set_collision_layer_value(1, true)
		static_body_2d.set_collision_layer_value(2, true)
	else: 
		color_rect.color = inactiveColour
		static_body_2d.set_collision_layer_value(1, false)
		static_body_2d.set_collision_layer_value(2, false)
