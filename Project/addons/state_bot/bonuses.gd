@icon("res://addons/state_bot/bonuses.png")
class_name Bonuses
## A bonus class with useful bonus things that you can use from anywhere in the project.
extends RefCounted


## Returns all of the children of [param node].
## You can include more children by setting [param array].
## This returns the children in order from top to bottom.
static func get_all_children(node: Node, array: Array = []) -> Array[Node]:
	array.push_back(node)
	for child in node.get_children():
		array = get_all_children(child, array)
	var nodes: Array[Node]
	nodes.assign(array)
	return nodes
