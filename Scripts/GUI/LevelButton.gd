extends Button

var scene : String = ""
var handler : Control = null

func _ready() -> void:
	pressed.connect(_ButtonPressed)

func InitButton(scn : String, hd : Control) -> void:
	scene = scn
	handler = hd
	text = scene.split(".")[0].replace("_", " ")

func _ButtonPressed() -> void:
	handler.LoadScene(scene)
