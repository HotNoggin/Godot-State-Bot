@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("StateBot", "Node", load("res://addons/state_bot/state_bot.gd"),
		load("res://addons/state_bot/state_bot_icon.png"))
	add_custom_type("SimpleState", "Node", load("res://addons/state_bot/simple_state.gd"),
		load("res://addons/state_bot/simple_state_icon.png"))
	add_custom_type("Bonuses", "RefCounted", load("res://addons/state_bot/bonuses.gd"),
		load("res://addons/state_bot/bonuses.png"))
	
	print_rich("[color=medium_purple]--- You're using the StateBot addon! Good luck! ---")
	print_rich("[color=medium_purple]--- Be sure to read the documentation! ---")


func _exit_tree():
	remove_custom_type("StateBot")
	remove_custom_type("SimpleState")
	remove_custom_type("Bonuses")
	print_rich("[color=medium_purple]You've deactivated the StateBot addon.")
