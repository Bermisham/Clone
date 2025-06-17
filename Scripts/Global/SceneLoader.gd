extends Node

var currentScene = null

func _ready() -> void:
	currentScene = get_tree().root.get_child(-1)
	
func setScene(path : String):
	_deferredSetScene.call_deferred(path)

func _deferredSetScene(path : String):
	currentScene.free()
	
	var s = ResourceLoader.load(path)
	currentScene = s.instantiate()
	
	get_tree().root.add_child(currentScene)
	get_tree().current_scene = currentScene
