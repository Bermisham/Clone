extends Node

@onready var input_save: Node = $InputSave
@onready var mode: Node = $Mode

@export var amtSaves : int = 3

signal clone_made()
var amtClones : int = 0

var paused := false
var sceneEnd := false

func _ready() -> void:
	GlobalHandler.SetSceneHandler(self)
	GlobalHandler.pause_changed.connect(_pauseChange)
	mode.mode_change.connect(_on_mode_change)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		togglePause()
	elif !paused and event.is_action_pressed("make_clone") and input_save.currentState != 1:
		GlobalHandler.cloner.CreateClone(input_save.GetCurrentInputSave(), mode.IsVisual())
		amtClones += 1
		clone_made.emit()

func endScene() -> void:
	sceneEnd = true

func togglePause() -> void:
	if !sceneEnd:
		paused = !paused
		GlobalHandler.ChangePause(paused)
	
func _pauseChange(state : bool) -> void:
	paused = state

func _on_mode_change(modeSet: int) -> void:
	input_save.ModeChange(modeSet)
