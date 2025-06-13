extends Node

@onready var input_save: Node = $InputSave

var paused := false

func _ready() -> void:
	GlobalHandler.SetSceneHandler(self)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		togglePause()
	elif !paused and event.is_action_pressed("make_clone") and input_save.currentState != 1:
		if input_save.currentSave:
			GlobalHandler.cloner.CreateClone(input_save.GetCurrentInputSave())

func togglePause() -> void:
	paused = !paused
	GlobalHandler.ChangePause(paused)

func _on_mode_change(mode: int) -> void:
	input_save.ModeChange(mode)
