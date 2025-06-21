extends Control

func _on_nxt_lvl() -> void:
	SceneLoader.nextScene(get_tree().current_scene.scene_file_path)

func _on_retry() -> void:
	SceneLoader.setScene(get_tree().current_scene.scene_file_path)

func _on_levels() -> void:
	SceneLoader.setScene("res://Scenes/Menus/LevelSelect.tscn")

func _on_title() -> void:
	SceneLoader.setScene("res://Scenes/Menus/Title.tscn")

func _on_quit() -> void:
	get_tree().quit()
