@warning_ignore("missing_tool")
extends SimpleState

@export var wall_jump_velocity: Vector2 = Vector2(125, -350)

@onready var state_bot: StateBot = get_bot()
@onready var player: ExamplePlayer = get_bot().puppet
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

var wall_normal: float

## Called once automatically when this state is entered.
func _enter_state(last_state: SimpleState) -> void:
	animated_sprite.play("wall_jump")
	
	# Check if you hit the wall is on your left (1) or right (-1)
	wall_normal = player.get_last_slide_collision().get_normal().x
	
	if wall_normal > 0.5:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false


## Called once automatically when this state is exited.
func _exit_state(new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
func _state_process(delta: float) -> void:
	pass


## Called every physics tick while this state is active.
func _state_physics_process(delta: float) -> void:
	if player.is_on_floor():
		state_bot.switch_to_state("Idle")
	elif !player.is_on_wall():
		state_bot.switch_to_state("Airborne")
	
	if Input.is_action_just_pressed("ui_up"):
		player.velocity.y = wall_jump_velocity.y
		player.velocity.x = wall_jump_velocity.x * wall_normal
	
	player.apply_gravity(delta)
	player.move_and_slide()
