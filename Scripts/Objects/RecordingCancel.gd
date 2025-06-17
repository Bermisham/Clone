extends Area2D

func _ready() -> void:
	body_entered.connect(_ToggleRecording)
	body_exited.connect(_ToggleRecording)

func _ToggleRecording(_body : Node2D) -> void:
	GlobalHandler.sceneHandler.get_child(0).ToggleRecording()
	
