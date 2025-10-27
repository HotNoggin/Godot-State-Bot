@warning_ignore("missing_tool")
extends SimpleState

@export var airborne_speed: float = 150
@export var airborne_acceleration: float = 8

@onready var state_bot: StateBot = get_bot()
@onready var player: ExamplePlayer = get_bot().puppet
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D


## Called once automatically when this state is entered.
func _enter_state(last_state: SimpleState) -> void:
	handle_animations()


## Called once automatically when this state is exited.
func _exit_state(new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
func _state_process(delta: float) -> void:
	pass


## Called every physics tick while this state is active.
func _state_physics_process(delta: float) -> void:
	handle_movement()
	handle_animations()
	handle_floor()
	
	if player.is_on_wall_only():
		state_bot.switch_to_state("WallJump")
	
	player.apply_gravity(delta)
	player.move_and_slide()

func handle_movement():
	var input_vector: float = Input.get_axis("ui_left", "ui_right")
	
	if input_vector:
		player.velocity.x = move_toward(player.velocity.x, airborne_speed * input_vector, airborne_acceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, airborne_acceleration)

func handle_animations():
	if player.velocity.y > 0:
		animated_sprite.play("fall")
	else:
		animated_sprite.play("jump")
	
	if player.velocity.x < 0:
		animated_sprite.flip_h = true
	elif player.velocity.x > 0:
		animated_sprite.flip_h = false

func handle_floor():
	if player.is_on_floor():
		if player.velocity.x:
			state_bot.switch_to_state("Running")
		else:
			state_bot.switch_to_state("Idle")
