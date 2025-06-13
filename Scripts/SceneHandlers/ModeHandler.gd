extends Node

signal mode_change(mode : Modes) 

enum Modes {NORMAL, INSERT, VISUAL, PAUSED}
var currentMode : Modes
var lastMode : Modes

func _ready() -> void:
	currentMode = Modes.NORMAL
	lastMode = Modes.NORMAL
	GlobalHandler.pause_changed.connect(_ChangePause)

## Handle mode switching inputs
func _unhandled_key_input(event: InputEvent) -> void:
	if currentMode != Modes.PAUSED:
		if event.is_action_pressed("normal_mode") and currentMode != Modes.NORMAL:
			currentMode = Modes.NORMAL
			mode_change.emit(Modes.NORMAL)
			
		elif event.is_action_pressed("insert_mode") and currentMode != Modes.INSERT:
			currentMode = Modes.INSERT
			mode_change.emit(Modes.INSERT)
			
		elif event.is_action_pressed("visual_mode") and currentMode != Modes.VISUAL:
			currentMode = Modes.VISUAL
			mode_change.emit(Modes.VISUAL)
			
		elif event.is_action_pressed("finish_recording") and currentMode == Modes.INSERT:
			currentMode = Modes.NORMAL
			mode_change.emit(Modes.NORMAL)

func _ChangePause(state : bool) -> void:
	if state == false:
		currentMode = lastMode
	else:
		lastMode = currentMode
		currentMode = Modes.PAUSED
