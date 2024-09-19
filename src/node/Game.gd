class_name Game extends Node

const Bootstrap = preload("res://src/boot/Bootstrap.gd")
const InstanceType = Bootstrap.InstanceType

@onready
var player_prefab = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var args: Array = OS.get_cmdline_args()
	var instance_type: InstanceType = Bootstrap.new().run(args, self)
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(add_player)
		# add already connected clients
		for id in multiplayer.get_peers():
			add_player(id)
	
func add_player(id: int):
	var player = player_prefab.instantiate()
	player.multiplayer_id = id
	player.name = "Player-{0}".format([id])
	$Players.add_child(player, true)
