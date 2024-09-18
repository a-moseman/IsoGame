extends RigidBody3D

@export var move_speed: float

var movement_input: Vector2 = Vector2.ZERO
var movement_scale: float = 0
var movement_vector: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement_scale > 0:
		var motion: Vector3 = Vector3(movement_vector.x, 0, -movement_vector.y) * move_speed
		move_and_collide(motion * delta)
	
func _input(event):
	if event.is_action_pressed("move-up"):
		movement_input.y += 1
	if event.is_action_pressed("move-down"):
		movement_input.y -= 1
	if event.is_action_pressed("move-right"):
		movement_input.x += 1
	if event.is_action_pressed("move-left"):
		movement_input.x -= 1
	
	if event.is_action_released("move-up"):
		movement_input.y -= 1
	if event.is_action_released("move-down"):
		movement_input.y += 1
	if event.is_action_released("move-right"):
		movement_input.x -= 1
	if event.is_action_released("move-left"):
		movement_input.x += 1
	
	_clamp(movement_input)
	movement_scale = movement_input.length()
	if movement_scale < 0:
		movement_vector = Vector2.ZERO
	else:
		movement_vector = movement_input / movement_scale
		
func _clamp(v: Vector2):
	if v.x > 1:
		v.x = 1
	if v.x < -1:
		v.x = -1
	if v.y > 1:
		v.y = 1
	if v.y < 1:
		v.y = -1
