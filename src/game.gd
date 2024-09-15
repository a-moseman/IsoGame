extends Node3D

const NO_INSTANCE_TYPE_MESSAGE = "no instance type provided"
const INVALID_INSTANCE_TYPE_FORMAT = "invalid instance type of %s attempted"
const CLIENT_INSTANCE = "CLIENT"
const SERVER_INSTANCE = "SERVER"

# Called when the node enters the scene tree for the first time.
func _ready():
	var args: Array = OS.get_cmdline_args()
	assert(len(args) > 0, NO_INSTANCE_TYPE_MESSAGE)
	var instance_type: String = args[0]
	instance_type = instance_type.to_upper()
	assert (is_valid_instance_type(instance_type), self.INVALID_INSTANCE_TYPE_FORMAT % instance_type)
	run(instance_type)
	
## Check if the provided instance type is valid.
func is_valid_instance_type(instance_type: String) -> bool:
	return instance_type == self.CLIENT || instance_type == self.SERVER

## Run as either a client or server.
func run(instance_type: String) -> void:
		if instance_type == self.CLIENT:
			run_as_client()
		if instance_type == self.SERVER:
			run_as_server()
			
## Run as a client.	
func run_as_client() -> void:
	print("running as client")
	
## Run as a server.
func run_as_server() -> void:
	print("running as server")
