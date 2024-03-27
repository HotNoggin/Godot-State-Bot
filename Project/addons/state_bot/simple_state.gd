@tool
@icon("res://addons/state_bot/simple_state_icon.png")
class_name SimpleState
## Contains all of the methods needed to handle everything within the scope of a single state.
## Define what happens when a state is activated, deactivated, and while it is active.
## A [SimpleState] must have a [StateBot] ancestor.
extends Node

## The state to switch to when [method StateBot.next_state] is called.
@export var next_state: SimpleState

func _enter_tree():
	# Detach this script from the node and instead give the developer a new script to work in.
	var _simple_state_script: Script = load("res://addons/state_bot/simple_state.gd")
	if get_script() == _simple_state_script:
		var new_script: Script = load("res://addons/state_bot/simple_state_template.gd") as Script
		set_script(new_script.duplicate())


## Called once automatically when this state is entered.
## This function is meant to be overridden with the behavior that you want to occur once, 
## when the state is activated.
func _enter_state(_last_state: SimpleState) -> void:
	pass


## Called once automatically when this state is exited.
## This function is meant to be overridden with the behavior that you want to occur once, 
## when the state is deactivated.
func _exit_state(_new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
## This function is meant to be overridden with the behavior that you want to run constantly, 
## once every frame.
func _state_process(_delta: float) -> void:
	pass


## Called every physics tick while this state is active.
## This function is meant to be overridden with the behavior that you want to run constantly, 
## once every physics tick.
func _state_physics_process(_delta: float) -> void:
	pass


## Returns the first ancestor of this [SimpleState] that is a [StateBot].
## The bot that this returns is the [StateBot] that manages this [SimpleState].
func get_bot() -> StateBot:
	var last_checked: Node = self
	var state_bot: StateBot = null
	
	## Search up the tree until a StateBot is found, then return it
	while not is_instance_valid(state_bot):
		last_checked = last_checked.get_parent()
		if last_checked is StateBot:
			state_bot = last_checked
			return state_bot
	
	return null


## Switches the [member StateBot.current_state] to [member next_state].
## If no [member next_state] is defined, it deactivates the [StateBot].
## If a [SimpleState] is passed to the [param next] parameter, 
## the state changes to that state, and [member next_state] is also set to that state.
func switch_to_next(next: SimpleState = next_state) -> void:
	next_state = next
	if is_instance_valid(get_bot()):
		get_bot().current_state = next
