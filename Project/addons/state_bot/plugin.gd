@tool
extends EditorPlugin


func _enter_tree():
	print_rich("[color=medium_purple]--- You're using the StateBot addon! Good luck! ---")
	print_rich("[color=medium_purple]--- Be sure to read the documentation! ---")


func _exit_tree():
	remove_custom_type("StateBot")
	remove_custom_type("SimpleState")
	remove_custom_type("Bonuses")
	print_rich("[color=medium_purple]You've deactivated the StateBot addon.")
