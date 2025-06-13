extends CanvasLayer

@onready var mode_label: Label = $ModeLabel
@onready var save_label: Label = $SaveLabel

enum Modes {NORMAL, INSERT, VISUAL}

var recordingTimes : Array
var isRecording := false
var recordingSave : int
var recordingTime : float
var saveTextA : String
var saveTextB : String

func _ready() -> void:
	GlobalHandler.sceneHandler.get_child(0).mode_change.connect(_ChangeMode)
	_ChangeMode(GlobalHandler.sceneHandler.get_child(0).currentMode) 
	
	GlobalHandler.sceneHandler.get_child(1).save_change.connect(_UpdateSave)
	var saveAmt = GlobalHandler.sceneHandler.get_child(1).amtSaves
	var currSave = GlobalHandler.sceneHandler.get_child(1).currentSave
	_UpdateSave(currSave, saveAmt, false)
	
## Change Mode text
func _ChangeMode(mode : Modes) -> void:
	match mode:
		Modes.NORMAL:
			mode_label.text = "[NORMAL]"
		Modes.INSERT:
			mode_label.text = "[INSERT]"
		Modes.VISUAL:
			mode_label.text = "[VISUAL]"

## Updating saves text with recording time
func _process(delta: float) -> void:
	if isRecording:
		recordingTime += delta
		save_label.text = saveTextA + str("%0.1f" % recordingTime) + saveTextB

## Creating updated saves text
func _UpdateSave(save : int, amt : int, recording : bool):
	if recordingTimes.size() > amt:
		recordingTimes.resize(amt)

	while recordingTimes.size() < amt:
		recordingTimes.append("")
	
	if recording:
		isRecording = recording
		recordingSave = save
		recordingTime = 0
	elif isRecording:
		isRecording = recording
		recordingTimes[save] = str("%0.1f" % recordingTime)
	
	# Build save text prior to selected
	var count = 1
	saveTextA = ""
	while count < save + 1:
		saveTextA += "SAVE " + str(count) + "  " + recordingTimes[count - 1] + "\n"
		count += 1
	
	# Build selected save text
	saveTextA += "[SAVE " + str(count) + "]"
	if recording:
		saveTextA += " Recording "
	else:
		saveTextA += "  " + recordingTimes[count - 1]
	count += 1
	
	# Build save text following selected
	saveTextB = "\n"
	while count < amt + 1:
		saveTextB += "SAVE " + str(count) + "  " + recordingTimes[count - 1] + "\n"
		count += 1
		
	save_label.text = saveTextA + saveTextB
