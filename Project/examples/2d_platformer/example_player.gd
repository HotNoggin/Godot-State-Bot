extends CharacterBody2D
class_name ExamplePlayer

## Contains generic functions and variables used in player states

@export var jump_height: float = -400

func apply_gravity(delta: float) -> void:
	velocity.y += get_gravity().y * delta
