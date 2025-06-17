extends CanvasLayer

@onready var pause_screen: Control = $PauseScreen

var paused := false

func _ready() -> void:
	GlobalHandler.pause_changed.connect(_pause)

func _pause(state : bool) -> void:
	paused = state
	if paused:
		pause_screen.show()
	else:
		pause_screen.hide()
