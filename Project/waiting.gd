extends SimpleState
## This is a brand new SimpleState! You can use the functions below to create some new behavior.
## If you would like to reuse this state elsewhere, use the "Save As" option in the script "File" tab.
## If you don't save your script, it will be LOST if it's removed from the node or the node is deleted.
## If you meant to use an existing state, simply set this node's script to that state instead.


## Called once automatically when this state is entered.
func _enter_state(last_state: SimpleState) -> void:
	pass


## Called once automatically when this state is exited.
func _exit_state(new_state: SimpleState) -> void:
	pass


## Called every frame while this state is active.
func _state_process(delta: float) -> void:
	pass


## Called every physics tick while this state is active.
func _state_physics_process(delta: float) -> void:
	pass
