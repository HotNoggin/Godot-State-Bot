@tool
extends EditorPlugin


func _enter_tree():
	print("You're using the StateBot addon! Good luck!")
	print("Be sure to read the documentation and check out the tutorials.")


func _exit_tree():
	printerr("You've deactivated the StateBot addon.")
	printerr("If you had issues with it, please tell the creator, Hot Noggin Studios!")
