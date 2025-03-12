extends Node



func _ready() -> void:
	get_tree().node_added.connect(on_node_added)
	disable_button_focus(get_tree().get_root())


func on_node_added(node: Node):
	if node is Button:
		node.focus_mode= Control.FOCUS_NONE


func disable_button_focus(node):
	if node is Button:
		node.focus_mode = Control.FOCUS_NONE
	for child in node.get_children():
		disable_button_focus(child)
