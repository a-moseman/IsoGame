## Represents a collection of items.
class_name ItemCollection extends Object

#imports
const BoundedInt = preload("res://src/model/Item.gd")

var _size: int
var _items: Array[Item]

## Instantiate an item collection.
## [param size]: the constant size of the collection.
func _init(size: int):
	self._size = size
	self._items = []
	for i in range(0, size): self._items.append(null) # we're pretending it's not a list

## Insert an item into the collection.
## [param item]: the item to insert.
## [param index]: the index insert the item at.
func insert(item: Item, index: int) -> bool:
	self._assert_in_bounds(index)
	if self._items[index] != null:
		return false
	self._items[index] = item
	return true

## Remove an item from the collection.
## Returns the item that was removed, or null if none was at the index.
## [param index]: the index
func remove(index: int) -> Item:
	self._assert_in_bounds(index)
	var item: Item = self._items[index]
	self._items[index] = null
	return item
	
## Move an item from one index to another.
## Returns false if no item is at the from index, or if it would result in a replace.
## [param from]: the index to move from.
## [param to]: the index to move to.
func move(from: int, to: int) -> bool:
	self._assert_in_bounds(from)
	self._assert_in_bounds(to)
	var item: Item = self._items[from]
	if item == null:
		return false
	if self._items[to] != null:
		return false
	self._items[to] = item
	self._items[from] = null
	return true
	
## Get the item at the index.
## [param index]: the index of the item.
func item_at(index: int) -> Item:
	self._assert_in_bounds(index)
	return self._items[index]

## Get the size of the item collection.
func size() -> int:
	return self._size

## Assert that the index is within the range [0, size).
func _assert_in_bounds(index: int) -> void:
	assert(index >= 0 && index < self._size)
