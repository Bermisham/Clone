extends CanvasLayer

@onready var pause_screen: Control = $PauseScreen
@onready var complete_screen: Control = $CompleteScreen
@onready var time: Label = $CompleteScreen/CenterContainer/Border/CenterContainer/ColorRect2/CenterContainer/VBoxContainer/Time
@onready var timer: Label = $HUD/Timer

var paused := false
var sceneComplete := false
var gameTime : float = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	call_deferred("_connect")

func _connect() -> void:
	GlobalHandler.pause_changed.connect(_pause)
	GlobalHandler.exit.scene_complete.connect(_SceneComplete)

func _process(delta: float) -> void:
	if !paused: 
		gameTime += delta
		timer.text = str("%0.2f" % gameTime)

func _pause(state : bool) -> void:
	paused = state
	if paused: 
		timer.add_theme_color_override("font_color", Color("74c7ec"))
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else: 
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		timer.add_theme_color_override("font_color", Color("a6e3a1"))
	
	if !sceneComplete:
		if paused:
			pause_screen.show()
		else:
			pause_screen.hide()

func _SceneComplete() -> void:
	time.text = "TIME [" + str("%0.2f" % gameTime) + "]"
	sceneComplete = true
	complete_screen.show()
	GlobalHandler.ChangePause(true)
