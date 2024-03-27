@tool
@icon("res://addons/state_bot/state_bot_icon.png")
class_name StateBot
## Holds a number of [SimpleState]s as children and manages which one is active.
## It has a number of functions to handle state switching and management.
extends Node

## Emitted when the state is changed.
## The [param old_state] and [param new_state] are passed as parameters.
signal state_changed(old_state: SimpleState, new_state: SimpleState)
## Emitted when the state is set to [code]null[/code], either directly or through a method.
signal deactivated()

## Press "Create" to make a new [SimpleState].
## Only useful in the editor's inspector, not through code.
@export_flags("Create") var _create_new_simple_state : int = 0:
	set(_value):
		if not Engine.is_editor_hint():
			return
		
		# FIXME NOT ADDING TO THE TREE
		var new_state: SimpleState = SimpleState.new()
		new_state.name = "SimpleState"
		add_child(new_state, true)
		new_state.set_owner(get_tree().edited_scene_root)

## If [member debug_mode] is on, debug messages will be printed to the console when states change.
@export var debug_mode: bool = false

## A single [SimpleState] that is set to be automatically entered on ready, 
## and when [method restart] is called.
## This can be changed while the game is runnning to change what state is entered on [method restart].
@export var starting_state: SimpleState = null

## The [SimpleState] that is currently active. It must be a child node of the [StateBot].
## Changing this directly will trigger a state switch.
var current_state: SimpleState = null: 
	set(new_state):
		# If in the editor, change the value without switching states.
		if Engine.is_editor_hint():
			current_state = new_state
			return
			
		# Do nothing if the current and new states are the same.
		if current_state == new_state:
			return
		
		# Exit the old state and enter the new state.
		# The variable is set after exit and before enter.
		var old_state: SimpleState = current_state
		if is_instance_valid(current_state):
			current_state._exit_state(new_state)
		current_state = new_state
		if is_instance_valid(new_state):
			new_state._enter_state(old_state)
		
		# Emit signals, send a debug message if debug mode is enabeled.
		state_changed.emit(old_state, new_state)
		if new_state == null:
			if debug_mode:
				print("The StateBot named " + str(name) + " was deactivated.")
			deactivated.emit()
			return
		
		# Send a debug message if debug mode is enabled.
		if debug_mode:
			print("The state of " + name + " was changed from " + str(old_state) + " to " + 
			str(new_state))


func _ready():
	if Engine.is_editor_hint():
		return
	restart()


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


## Triggers a switch to a [SimpleState] with the name [param state_name]
## The state must be a descendent of the [StateBot].
## The first state with the matching name will be used, So if a child and parent share a name, 
## The parent will be used. This function also returns the [SimpleState]. Aside from that, 
## this is the same as setting [member current_state] to [code]get_state("state_name")[/code].
func switch_to_state(state_name: String = "") -> SimpleState:
	var state: SimpleState = get_state(state_name)
	current_state = state
	return state


## Returns a [SimpleState] with the name [param state_name].
## The state must be a descendent of the [StateBot].
## The first state with the matching name will be returned, So if a child and parent share a name, 
## The parent will be returned.
func get_state(state_name: String = "") -> SimpleState:
	# Get all of the states for this StateBot.
	var states: Array[SimpleState] = get_all_states()
	# Find and return the first SimpleState with a matching name.
	states = states.filter(func(state):
		return state.name == state_name)
	if states.is_empty():
		return null
	return states.front()


## Returns all [SimpleState]s that are children, grandchildren, or descendents of this [StateBot].
func get_all_states() -> Array[SimpleState]:
	# Get all of the children of this StateBot.
	var states: Array[SimpleState] = []
	var children: Array[Node] = Bonuses.get_all_children(self)
	# Don't continue if there are no children.
	if children.is_empty():
		push_error("The StateBot has no children, but get_all_states() was called.")
		return []
	# Convert the Node array into a SimpleState array and return the entire array.
	states.assign(children.filter(func(child):
		return child is SimpleState))
	return states


## Triggers a switch to the [member starting_state].
## This is the same as setting [member current_state] to [member starting_state].
## If the [member starting_state] is invalid, [method deactivate] is called instead.
func restart() -> void:
	if is_instance_valid(starting_state):
		current_state = starting_state
	else:
		deactivate()
		push_error("The starting state is invalid. The StateBot has been deactivated.")


## Disables state processing on the [member current_state].
## This is the same as setting [member current_state] to [code]null[/code].
func deactivate() -> void:
	current_state = null
