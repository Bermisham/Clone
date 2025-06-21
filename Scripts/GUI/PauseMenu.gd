extends Control

func _on_resume() -> void:
	GlobalHandler.ChangePause(false)

func _on_levels() -> void:
	SceneLoader.setScene("res://Scenes/Menus/LevelSelect.tscn")

func _on_quit() -> void:
	get_tree().quit()

func _on_title() -> void:
	SceneLoader.setScene("res://Scenes/Menus/Title.tscn")

func _on_restart() -> void:
	SceneLoader.setScene(get_tree().current_scene.scene_file_path)
