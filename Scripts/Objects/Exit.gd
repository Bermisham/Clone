extends Node2D

@export var locked := false

@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal scene_complete

var playerInside := false

func _ready() -> void:
	GlobalHandler.SetExit(self)
	
	if locked: animated_sprite_2d.play("door_closed")
	else: animated_sprite_2d.play("door_opend")
	
	area_2d.body_entered.connect(_TogglePlayerInside)
	area_2d.body_exited.connect(_TogglePlayerInside)

func Toggle() -> void:
	if locked: animated_sprite_2d.play("opening_door")
	else: animated_sprite_2d.play("closing_door")
	locked = !locked

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action("interact") and !locked and playerInside:
		scene_complete.emit()

func _TogglePlayerInside(body : Node2D) -> void:
	if body is CharacterBody2D:
		playerInside = !playerInside
