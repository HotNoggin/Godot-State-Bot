extends SimpleState
## This is a brand new SimpleState! You can use the functions below to create some new behavior.
## If you would like to reuse this state elsewhere, use the "Save As" option in the script "File" tab.
## If you meant to use an existing state, simply set this node's script to that state instead.

var time: float = 0

## Called once automatically when this state is entered.
func _enter_state(_last_state: SimpleState) -> void:
	print("Counting up")


## Called once automatically when this state is exited.
func _exit_state(_new_state: SimpleState) -> void:
	print("Not counting up")


## Called every frame while this state is active.
func _state_process(delta: float) -> void:
	time += delta
	if time > 10:
		switch_to_next()


## Called every physics tick while this state is active.
func _state_physics_process(_delta: float) -> void:
	pass
