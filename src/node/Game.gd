class_name Game extends Node3D

const Bootstrap = preload("res://src/boot/Bootstrap.gd")
const InstanceType = Bootstrap.InstanceType

# Called when the node enters the scene tree for the first time.
func _ready():
	var args: Array = OS.get_cmdline_args()
	var instance_type: InstanceType = Bootstrap.new().run(args, self)
	
	multiplayer.connected_to_server.connect(_on_client_connect)
	
@rpc("any_peer")
func client_connected():
	print(multiplayer.get_remote_sender_id())
	
func _on_client_connect():
	client_connected.rpc()
