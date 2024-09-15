class_name Client extends Object

func run(root: Node3D, port: int, address: String) -> void:
	print("Starting client with server at {0}:{1}".format([address, port]))
