class_name Character extends Object

# imports
const BoundedInt = preload("res://src/model/BoundedInt.gd")

## The name of the entity.
var _name: String
## The health of the entity.
var _health: BoundedInt

## Instantiate an entity.
func _init(name: String, health: BoundedInt):
	self._name = name
	self._health = health
	
## Get the name of the entity.
func name() -> String:
	return self._name
	
## Get the health of the entity.
func health() -> BoundedInt:
	return self._health
