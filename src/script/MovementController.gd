extends MultiplayerSynchronizer

var movement_input: Vector2 = Vector2.ZERO
var movement_scale: float = 0
@export var movement_vector: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Input.get_vector("move-left", "move-right", "move-up", "move-down")
	movement_vector = dir
	_clamp(movement_vector)

## Clamp the x and y values of the provided vector to be between -1 and 1, both inclusive.
func _clamp(v: Vector2):
	if v.x > 1:
		v.x = 1
	if v.x < -1:
		v.x = -1
	if v.y > 1:
		v.y = 1
	if v.y < 1:
		v.y = -1
