extends Node

signal pause_changed(state : bool)

var sceneHandler : Node = null
var player : CharacterBody2D = null
var cloner : Node2D = null
var exit : Node2D = null

var levels = [
	"res://Scenes/Levels/Level_1.tscn",
	"res://Scenes/Levels/Level_2.tscn",
	"res://Scenes/Levels/Level_3.tscn",
	"res://Scenes/Levels/Level_4.tscn",
	"res://Scenes/Levels/Level_5.tscn",
	"res://Scenes/Levels/Level_6.tscn",
	"res://Scenes/Levels/Level_7.tscn",
]

func SetSceneHandler(handler : Node) -> void:
	sceneHandler = handler
	
func SetPlayer(ply : CharacterBody2D) -> void:
	player = ply

func SetCloner(cln : Node2D) -> void:
	cloner = cln
	
func SetExit(ext : Node2D) -> void:
	exit = ext
	
func ChangePause(state : bool) -> void:
	pause_changed.emit(state)
	
