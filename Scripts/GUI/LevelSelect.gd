extends Control

@onready var v_box_container: VBoxContainer = $LevelList/ScrollContainer/VBoxContainer

var levelBtn = preload("res://Scenes/Menus/level_button.tscn")

func _ready() -> void:
	var dir = DirAccess.open("res://Scenes/Levels")
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			var newBtn = levelBtn.instantiate()
			newBtn.InitButton(fileName, self)
			v_box_container.add_child(newBtn)
			fileName = dir.get_next()

func LoadScene(scene : String) -> void:
	SceneLoader.setScene("res://Scenes/Levels/" + scene)

func _on_title() -> void:
	SceneLoader.setScene("res://Scenes/Menus/Title.tscn")
