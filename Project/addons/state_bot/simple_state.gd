@tool
@icon("res://addons/state_bot/simple_state_icon.png")
class_name SimpleState
## Contains all of the methods needed to handle everything within the scope of a single state.
## Define what happens when a state is activated, deactivated, and while it is active.
extends Node

"
IMPORTANT NOTE
==============
You are not meant to use this script (simple_state.gd) to define individual states.
Changing something in this script will affect EVERY state in your game.
If that is not what you want, use a new script that extends SimpleState instead.
When you add a new SimpleState to a scene, a new script will be created for you.
"

func _enter_tree():
	# Detach this script from the node and instead give the developer a new script to work in.
	var _simple_state_script: Script = load("res://addons/state_bot/simple_state.gd")
	if get_script() == _simple_state_script:
		var new_script: Script = load("res://addons/state_bot/simple_state_template.gd") as Script
		set_script(new_script.duplicate())


## Called once automatically when this state is entered.
func _enter_state(_last_state: SimpleState) -> void:
	pass


## Called once automatically when this state is exited.
func _exit_state(_new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
func _state_process(_delta: float) -> void:
	pass


## Called every physics tick while this state is active.
func _state_physics_process(_delta: float) -> void:
	pass
