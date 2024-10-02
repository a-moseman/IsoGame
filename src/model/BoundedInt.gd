## Represents an integer clamped to a range with configured minimum and maximum bounds.
class_name BoundedInt extends Object

## The value that resides in the range.
var _value: int
## The inclusive minimum value of the range.
var _min: int
## The inclusive maximum value of the range.
var _max: int
## Used to determine if value hits either bound of the range.
var _previous_value: int

## A signal that is emmited when the value changes.
signal changed(difference: int)
## A signal that is emitted when the value reaches the maximum bound of the range.
signal reached_max(value: int, max: int)
## A signal that is emitted when the value reaches the minimum bound of the range.
signal reached_min(value: int, min: int)

## Instantiate a bounded integer.
func _init(value: int = 0, min: int = 0, max: int = 0):
	self._value = value
	self._min = min
	self._max = max
	self._clamp()
	# emit ignoring previous value
	if self._value == self._min: reached_min.emit()
	if self._value == self._max: reached_max.emit()

## Clamp the value to the range.
func _clamp() -> void:
	self._value = min(self._value, self._max)
	self._value = max(self._value, self._min)
	self._previous_value = self._value

## Clamp the value to the range and emit a signal if it reaches either of the bounds.
func _clamp_with_signal() -> void:
	# clamp to max
	if self._value >= self._max:
		self._value = self._max
		# emit signal if reaching max
		if self._previous_value < self._max:
			reached_max.emit(self._value, self._max)
	# clamp to min
	if self._value <= self._min:
		self._value = self._min
		# emit signal if reaching min
		if self._previous_value > self._min:
			reached_min.emit(self._value, self._min)
	# emit signal if value changes
	if self._value != self._previous_value:
		changed.emit(self._value - self._previous_value)
	self._previous_value = self._value
	
## Add to the value.
## Emits a signal if the value reaches the bounds of the range.
func add(amount: int) -> void:
	self._value += amount
	self._clamp_with_signal()
	
## Add to the value.
## Emits a signal if the value reaches the bounds of the range.
func add_bounded(amount: BoundedInt) -> void:
	self.add(amount.value())
	
## Subtract from the value.
## Emits a signal if the value reaches the bounds of the range.
func sub(amount: int) -> void:
	self._value -= amount
	self._clamp_with_signal()

## Subtract from the value.
## Emits a signal if the value reaches the bounds of the range.
func sub_bounded(amount: BoundedInt) -> void:
	self.sub(amount.value())
	
## Multiply the value.
## Emits a signal if the value reaches the bounds of the range.
func mul(amount: int) -> void:
	self._value *= amount
	self._clamp_with_signal()
	
## Multiply the value.
## Emits a signal if the value reaches the bounds of the range.
func mul_bounded(amount: BoundedInt) -> void:
	self.mul(amount.value())

## Divide the value.
## Emits a signal if the value reaches the bounds of the range.
func div(amount: int) -> void:
	self._value /= amount
	self._clamp_with_signal()

## Divide the value.
## Emits a signal if the value reaches the bounds of the range.
func div_bounded(amount: BoundedInt) -> void:
	self.div(amount.value())

## Set the value.
## Emits a signal if the value reaches the bounds of the range.
func set_value(value: int) -> void:
	self._value = value
	self._clamp_with_signal()
	
## Set the minimum bound of the range.
## Emits a signal if the value reaches the bounds of the range.
func set_min(min: int) -> void:
	self._min = min
	self._clamp_with_signal()

## Set the maximum bound of the range.
## Emits a signal if the value reaches the bounds of the range.
func set_max(max: int) -> void:
	self._max = max
	self._clamp_with_signal()

## Get the value.
func value() -> int:
	return self._value
	
## Get the minimum bound of the range.
func min() -> int:
	return self._min

## Get the maximum bound of the range.
func max() -> int:
	return self._max
	
