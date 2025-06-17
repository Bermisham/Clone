extends Node

signal save_change(save : int, amt : int, recording : bool)

enum State {PAUSED, RECORDING, NORMAL}
var currentState : State = State.NORMAL
var lastState : State = State.NORMAL

@export var amtSaves : int = 1
var inputSaves : Array = []
var currentSave : int = 0

func _ready() -> void:
	SetSaveAmount(amtSaves)
	
	# Pause Handling
	GlobalHandler.pause_changed.connect(func(state:bool):
		if state == false:
			currentState = lastState as State
		else:
			lastState = currentState as State
			currentState = State.PAUSED
		)

## Handle save related inputs
func _unhandled_key_input(event: InputEvent) -> void:
	match currentState:
		State.NORMAL:
			if event.is_action_pressed("next_save"):
				if currentSave + 1 == inputSaves.size():
					currentSave = 0
				else:
					currentSave += 1
				save_change.emit(currentSave, amtSaves, false)

## Records movement inputs for save
func _physics_process(_delta: float) -> void:
	if currentState == State.RECORDING:
		var direction = Input.get_axis("input_left", "input_right")
		var jump = 0
		if Input.is_action_just_pressed("input_up"): jump = 1
		var interact = 0
		if Input.is_action_just_pressed("interact"): interact = 1
		inputSaves[currentSave][0].append(direction)
		inputSaves[currentSave][1].append(jump)
		inputSaves[currentSave][2].append(interact)

## Create empty arrays or trim arrays to size
func SetSaveAmount(amt : int) -> void:
	if inputSaves.size() < amt:
		var count = amt
		while count > 0:
			inputSaves.append([[],[],[]])
			count -= 1
	elif inputSaves.size() > amt:
		inputSaves.resize(amt)
		if currentSave > amt:
			currentSave = amt

## Clears existing saved data and sets state to recording
func StartRecording() -> void:
	inputSaves[currentSave] = [[],[],[]]
	currentState = State.RECORDING
	save_change.emit(currentSave, amtSaves, true)

## Handle save fetching
func GetCurrentInputSave() -> Array:
	return inputSaves[currentSave]
func GetAllInputSaves() -> Array:
	return inputSaves

## Handle recording states for mode changes
func ModeChange(mode):
	if currentState == State.RECORDING:
		currentState = State.NORMAL
		save_change.emit(currentSave, amtSaves, false)
	elif mode == 1:
		StartRecording()
