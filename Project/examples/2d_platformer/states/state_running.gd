@warning_ignore("missing_tool")
extends SimpleState

@export var run_speed: float = 150
@export var run_acceleration: float = 15
@export var jump_height: float = -400

@onready var state_bot: StateBot = get_bot()
@onready var player: ExamplePlayer = get_bot().puppet
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

## Called once automatically when this state is entered.
func _enter_state(last_state: SimpleState) -> void:
	animated_sprite.play("running")


## Called once automatically when this state is exited.
func _exit_state(new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
func _state_process(delta: float) -> void:
	pass


## Called every physics tick while this state is active.
func _state_physics_process(delta: float) -> void:
	handle_movement()
	handle_jumping()
	
	player.apply_gravity(delta)
	player.move_and_slide()

func handle_movement():
	var input_vector: float = Input.get_axis("ui_left", "ui_right")
	
	if input_vector:
		player.velocity.x = move_toward(player.velocity.x, run_speed * input_vector, run_acceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, run_acceleration)
	
	if player.velocity.x == 0:
		state_bot.switch_to_state("Idle")
	else:
		if player.velocity.x < 0:
			animated_sprite.flip_h = true
		elif player.velocity.x > 0:
			animated_sprite.flip_h = false

func handle_jumping():
	if Input.is_action_just_pressed("ui_up"):
		player.velocity.y = jump_height
		state_bot.switch_to_state("Airborne")
	
	if not player.is_on_floor():
		state_bot.switch_to_state("Airborne")
