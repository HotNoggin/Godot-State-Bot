@tool
@icon("res://addons/state_bot/state_bot_icon.png")
class_name StateBot
## Holds a number of states as children and manages which one is active.
## It has a number of functions to handle state switching and management.
extends Node

## Press "Create" to make a new SimpleState.
@export_flags("Create") var _create_new_simple_state : int = 0:
	set(_value):
		if not Engine.is_editor_hint():
			return
		
		# FIXME NOT ADDING TO THE TREE
		var new_state: SimpleState = SimpleState.new()
		new_state.name = "SimpleState"
		add_child(new_state, true)
		new_state.set_owner(self.owner)
		print(new_state.name)

@export var starting_state: SimpleState

var current_state: SimpleState: ## The state that is currently active. Must be a child node.
	set(new_state):
		# If in the editor, change the value without switching states.
		if Engine.is_editor_hint():
			current_state == new_state
			return
			
		# Do nothing if the current and new states are the same.
		if current_state == new_state:
			push_warning("The current and new states are the same. No switch was triggered.")
			return
		
		# Exit the old state and enter the new state.
		# The variable is set after exit and before enter.
		var old_state: SimpleState = current_state
		if is_instance_valid(current_state):
			current_state._exit_state(new_state)
		current_state = new_state
		if is_instance_valid(new_state):
			new_state._enter_state(old_state)


func _ready():
	if is_instance_valid(starting_state):
		current_state = starting_state


func _process(delta):
	if Engine.is_editor_hint():
		return
	
	# Run the current state's state process
	if is_instance_valid(current_state):
		current_state._state_process(delta)


func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	# Run the current state's physics process
	if is_instance_valid(current_state):
		current_state._state_physics_process(delta)
