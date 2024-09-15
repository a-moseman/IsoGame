extends Node3D

const NO_INSTANCE_TYPE_MESSAGE: String = "no instance type provided"
const NO_PORT_MESSAGE: String = "no ip port provided"
const NO_IP_ADDRESS_MESSAGE: String = "no ip address provided"
const INVALID_IP_ADDRESS_OCTET_COUNT_MESSAGE: String = "invalid number of ip address octets"
const INVALID_IP_ADDRESS_OCTET_MESSAGE: String = "ip address octets must be integers"
const INVALID_PORT_FORMAT: String = "invalid port of %s"
const INVALID_INSTANCE_TYPE_FORMAT: String = "invalid instance type of %s attempted"
const CLIENT_INSTANCE: String = "CLIENT"
const SERVER_INSTANCE: String = "SERVER"

# Called when the node enters the scene tree for the first time.
func _ready():
	var args: Array = OS.get_cmdline_args()
	assert(len(args) > 0, self.NO_INSTANCE_TYPE_MESSAGE)
	var instance_type: String = args[0]
	instance_type = instance_type.to_upper()
	assert(is_valid_instance_type(instance_type), self.INVALID_INSTANCE_TYPE_FORMAT % instance_type)
	
	assert(len(args) > 1, self.NO_PORT_MESSAGE)
	var port_string: String = args[1]
	assert(port_string.is_valid_int(), INVALID_PORT_FORMAT % port_string)
	var port: int = port_string.to_int()
	
	if instance_type == self.CLIENT_INSTANCE:
		assert(len(args) == 3, self.NO_IP_ADDRESS_MESSAGE)
		var address: String = args[2]
		assert_valid_ip_address(address)
		run_as_client(port, address)
	if instance_type == self.SERVER_INSTANCE:
		run_as_server(port)
		
## Assert that the ip address is valid.
func assert_valid_ip_address(address: String):
	var octets: Array = address.split(".")
	assert(len(octets) == 4, self.INVALID_IP_ADDRESS_OCTET_COUNT_MESSAGE)
	for octet: String in octets:
		assert(octet.is_valid_int(), self.INVALID_IP_ADDRESS_OCTET_MESSAGE)
	
## Check if the provided instance type is valid.
func is_valid_instance_type(instance_type: String) -> bool:
	return instance_type == self.CLIENT_INSTANCE || instance_type == self.SERVER_INSTANCE
			
## Run as a client.	
func run_as_client(port: int, address: String) -> void:
	print("running as client")
	
## Run as a server.
func run_as_server(port: int) -> void:
	print("running as server")
