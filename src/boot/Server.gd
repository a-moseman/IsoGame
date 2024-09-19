class_name Server extends Object

func run(root: Node, port: int) -> void:
	print("Starting server on port {0}".format([port]))
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	root.multiplayer.multiplayer_peer = peer
