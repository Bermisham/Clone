extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

@export var connections : Array[Node]

var bodiesInside : int = 0

func _ready() -> void:
	area_2d.body_entered.connect(_BodyEntered)
	area_2d.body_exited.connect(_BodyExited)
	sprite_2d.frame = 0

func _BodyEntered(_body : Node2D) -> void:
	if bodiesInside == 0:
		sprite_2d.frame = 1
		_ToggleConnections()
	bodiesInside += 1

func _BodyExited(_body : Node2D) -> void:
	bodiesInside -= 1
	if bodiesInside == 0:
		sprite_2d.frame = 0
		_ToggleConnections()

func _ToggleConnections() -> void:
	if !connections.is_empty():
		for connection in connections:
			connection.Toggle()
