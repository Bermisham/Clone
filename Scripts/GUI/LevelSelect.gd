extends Control

@onready var v_box_container: VBoxContainer = $LevelList/ScrollContainer/VBoxContainer

var levelBtn = preload("res://Scenes/Menus/level_button.tscn")

func _ready() -> void:
	var levels = GlobalHandler.levels
	
	for level in levels:
		var newBtn = levelBtn.instantiate()
		newBtn.InitButton(level.split("/")[-1], self)
		v_box_container.add_child(newBtn)
	
	
	## cool idea... worked but not really ;-;
	#var dir = DirAccess.open("res://Scenes/Levels")
	#if dir:
		#dir.list_dir_begin()
		#var btnList : Array
		#var fileName = dir.get_next()
		#while fileName != "":
			#var newBtn = levelBtn.instantiate()
			#newBtn.InitButton(fileName, self)
			#btnList.push_front(newBtn)
			#fileName = dir.get_next()
		#for btn in btnList:
			#v_box_container.add_child(btn)

func LoadScene(scene : String) -> void:
	SceneLoader.setScene("res://Scenes/Levels/" + scene)

func _on_title() -> void:
	SceneLoader.setScene("res://Scenes/Menus/Title.tscn")
