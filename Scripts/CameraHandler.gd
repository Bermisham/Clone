extends Camera2D

@export var smoothing : bool
@export_range(0, 5) var smoothing_dist : int = 0

var player : CharacterBody2D

var weight : float

func _ready() -> void:
	weight = float(16 - smoothing_dist) / 100
	call_deferred("_connect")

func _connect() -> void:
	player = GlobalHandler.player

func _physics_process(_delta: float) -> void:
	if player != null:
		var cameraPos : Vector2
		
		if smoothing: cameraPos = lerp(global_position, player.global_position, weight)
		else: cameraPos = player.global_position
		
		global_position = cameraPos.floor()
