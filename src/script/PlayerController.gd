extends CharacterBody2D

const MOVE_SPEED: float = 64.0

@export var multiplayer_id := 1 :
	set(id):
		multiplayer_id = id
		$MovementInput.set_multiplayer_authority(id)

@onready var movement_input = $MovementInput

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		if movement_input.movement_vector.length() > 0:
			var movement_vector: Vector2 = movement_input.movement_vector.normalized()
			var motion = movement_vector * MOVE_SPEED
			velocity = motion
			move_and_slide()
