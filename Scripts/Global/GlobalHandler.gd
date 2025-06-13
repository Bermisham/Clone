extends Node

signal pause_changed(state : bool)

var sceneHandler : Node = null
var player : CharacterBody2D = null
var cloner : Node2D = null

func SetSceneHandler(handler : Node):
	sceneHandler = handler
	
func SetPlayer(ply : CharacterBody2D):
	player = ply

func SetCloner(cln : Node2D):
	cloner = cln
	
func ChangePause(state : bool) -> void:
	pause_changed.emit(state)
	
