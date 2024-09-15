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

enum InstanceType {
	NONE,
	CLIENT,
	SERVER
}

## Run the bootstrap.
func run(args: Array, root: Node3D) -> InstanceType:
	var instance_type: InstanceType = _get_instance_type(args)
	var port: int = _get_port(args)

	match instance_type:
		InstanceType.CLIENT:
			var address: String = _get_address(args)
			Client.new().run(root, port, address)
			return InstanceType.CLIENT
		InstanceType.SERVER:
			Server.new().run(root, port)
			return InstanceType.SERVER
		_:
			push_error("Invalid instance type")
			return InstanceType.NONE
			
func _get_instance_type(args: Array) -> InstanceType:
	assert(len(args) > 0, self.NO_INSTANCE_TYPE_MESSAGE)
	var instance_type_string: String = args[0].to_upper()
	var instance_type: InstanceType
	if InstanceType.has(instance_type_string):
		instance_type = InstanceType.get(instance_type_string)
	else:
		instance_type = InstanceType.NONE
	assert(instance_type != null, self.INVALID_INSTANCE_TYPE_FORMAT.format([instance_type_string]))
	return instance_type
	
func _get_port(args: Array) -> int:
	assert(len(args) > 1, self.NO_PORT_MESSAGE)
	var port_string: String = args[1]
	assert(port_string.is_valid_int(), INVALID_PORT_FORMAT.format([port_string]))
	var port: int = port_string.to_int()
	return port
	
func _get_address(args: Array) -> String:
	assert(len(args) > 2, self.NO_IP_ADDRESS_MESSAGE)
	var address: String = args[2]
	assert_valid_ip_address(address)
	return address

## Assert that the ip address is valid.
func assert_valid_ip_address(address: String):
	var octets: Array = address.split(".")
	assert(len(octets) == 4, self.INVALID_IP_ADDRESS_OCTET_COUNT_MESSAGE)
	for octet: String in octets:
		assert(octet.is_valid_int(), self.INVALID_IP_ADDRESS_OCTET_MESSAGE)
