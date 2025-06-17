extends Node

signal mode_change(mode : Modes) 

enum Modes {NORMAL, INSERT, VISUAL, PAUSED}
var currentMode : Modes
var lastMode : Modes

var recordingDisabled := false

func _ready() -> void:
	currentMode = Modes.NORMAL
	lastMode = Modes.NORMAL
	
	# Pause Handling
	GlobalHandler.pause_changed.connect(func(state:bool):
		if state == false:
			currentMode = lastMode
		else:
			lastMode = currentMode
			currentMode = Modes.PAUSED
		)

## Handle mode switching inputs
func _unhandled_key_input(event: InputEvent) -> void:
	if currentMode != Modes.PAUSED:
		if event.is_action_pressed("normal_mode"):
			currentMode = Modes.NORMAL
			mode_change.emit(Modes.NORMAL)
			
		elif event.is_action_pressed("insert_mode") and currentMode != Modes.INSERT and !recordingDisabled:
			currentMode = Modes.INSERT
			mode_change.emit(Modes.INSERT)
			
		elif event.is_action_pressed("visual_mode"):
			currentMode = Modes.VISUAL
			mode_change.emit(Modes.VISUAL)
			
		elif event.is_action_pressed("finish_recording") and currentMode == Modes.INSERT:
			currentMode = Modes.NORMAL
			mode_change.emit(Modes.NORMAL)
	
		
func ToggleRecording() -> void:
	if !recordingDisabled:
		currentMode = Modes.NORMAL
		mode_change.emit(Modes.NORMAL)
	recordingDisabled = !recordingDisabled

func IsVisual() -> bool:
	return currentMode == Modes.VISUAL
