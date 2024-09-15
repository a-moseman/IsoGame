## For bootstrapping the client or server.
class_name Bootstrap extends Object

const NO_INSTANCE_TYPE_MESSAGE: String = "no instance type provided"
const NO_PORT_MESSAGE: String = "no ip port provided"
const NO_IP_ADDRESS_MESSAGE: String = "no ip address provided"
const INVALID_IP_ADDRESS_OCTET_COUNT_MESSAGE: String = "invalid number of ip address octets"
const INVALID_IP_ADDRESS_OCTET_MESSAGE: String = "ip address octets must be integers"
const INVALID_PORT_FORMAT: String = "invalid port of {0}"
const INVALID_INSTANCE_TYPE_FORMAT: String = "invalid instance type of {0} attempted"
const CLIENT_INSTANCE: String = "CLIENT"
const SERVER_INSTANCE: String = "SERVER"

## Run the bootstrap.
func run(args: Array, root: Node3D):
	assert(len(args) > 0, self.NO_INSTANCE_TYPE_MESSAGE)
	var instance_type: String = args[0]
	instance_type = instance_type.to_upper()
	assert(is_valid_instance_type(instance_type), self.INVALID_INSTANCE_TYPE_FORMAT.format([instance_type]))
	
	assert(len(args) > 1, self.NO_PORT_MESSAGE)
	var port_string: String = args[1]
	assert(port_string.is_valid_int(), INVALID_PORT_FORMAT.format([port_string]))
	var port: int = port_string.to_int()
	
	if instance_type == self.CLIENT_INSTANCE:
		assert(len(args) == 3, self.NO_IP_ADDRESS_MESSAGE)
		var address: String = args[2]
		assert_valid_ip_address(address)
		Client.new().run(root, port, address)
	if instance_type == self.SERVER_INSTANCE:
		Server.new().run(root, port)

## Assert that the ip address is valid.
func assert_valid_ip_address(address: String):
	var octets: Array = address.split(".")
	assert(len(octets) == 4, self.INVALID_IP_ADDRESS_OCTET_COUNT_MESSAGE)
	for octet: String in octets:
		assert(octet.is_valid_int(), self.INVALID_IP_ADDRESS_OCTET_MESSAGE)
	
## Check if the provided instance type is valid.
func is_valid_instance_type(instance_type: String) -> bool:
	return instance_type == self.CLIENT_INSTANCE || instance_type == self.SERVER_INSTANCE
