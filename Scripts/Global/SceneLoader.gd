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

## iterate through level files to find the next scene
func nextScene(scenePath: String) -> void:
	var levels = GlobalHandler.levels
	var index = 0
	
	while index < levels.size():
		if levels[index] == scenePath:
			if index + 1 != levels.size():
				setScene(levels[index + 1])
				break
		index += 1
	
	if index >= levels.size(): setScene("res://Scenes/Menus/EndScreen.tscn")
	
	#var sceneName = scenePath.split("/")[-1]
	#var dir = DirAccess.open("res://Scenes/Levels")
	#if dir:
		#dir.list_dir_begin()
		#var fileName = dir.get_next()
		#var handled := false
		#while fileName != "":
			#if fileName == sceneName:
				#fileName = dir.get_next()
				#if fileName != "": setScene("res://Scenes/Levels/" + fileName)
				#else: setScene("res://Scenes/Menus/EndScreen.tscn")
				#handled = true
				#break
			#else:
				#fileName = dir.get_next()
		#if !handled: print("Error loading next scene")
	
