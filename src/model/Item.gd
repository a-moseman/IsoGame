class_name Item extends Object

var _name: String
var _description: String

func _init(name: String, description: String):
	self._name = name
	self._description = description
	
## Get the name of the item.
func name() -> String:
	return self._name
	
func description() -> String:
	return self._description
