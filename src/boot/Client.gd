class_name Client extends Object

func run(root: Node3D, port: int, address: String) -> void:
	print("Starting client with server at {0}:{1}".format([address, port]))
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	root.multiplayer.multiplayer_peer = peer
