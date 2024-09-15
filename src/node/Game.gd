class_name Game extends Node3D

const Bootstrap = preload("res://src/boot/Bootstrap.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var args: Array = OS.get_cmdline_args()
	Bootstrap.new().run(args, self)
