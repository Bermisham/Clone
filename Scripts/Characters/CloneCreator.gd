extends Node2D

var clone = preload("res://Scenes/Clone.tscn")

func _ready() -> void:
	GlobalHandler.SetCloner(self)

func CreateClone(moveArray : Array) -> void:
	var player = GlobalHandler.player
	var newClone = clone.instantiate()
	get_tree().get_root().add_child(newClone)
	newClone.global_position = player.global_position
	newClone.SetCloneValues(player.MOVE_SPEED, player.JUMP_VELOCITY, moveArray)
