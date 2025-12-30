extends Node2D

@export var gravity := 1200.0
@export var jump_force := -500
@export var side_speed := 200
@export var rotation_speed := 0.0

var velocity = Vector2.ZERO
func _ready() -> void:
	randomize()
	velocity.y = jump_force
	var direction = 1
	if randf() < 0.5:
		direction = -1
	velocity.x = side_speed * direction
	
	rotation_speed = randf_range(-6.0, 6.0)

func _process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation += rotation_speed * delta
	
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
		
