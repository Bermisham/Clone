extends Control

func _on_play() -> void:
	SceneLoader.setScene("res://Scenes/Levels/Test_Scene.tscn")

func _on_levels() -> void:
	SceneLoader.setScene("res://Scenes/Menus/LevelSelect.tscn")

func _on_settings() -> void:
	pass # Replace with function body.

func _on_quit() -> void:
	get_tree().quit()
