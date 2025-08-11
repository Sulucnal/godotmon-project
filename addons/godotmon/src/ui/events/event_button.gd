@tool
extends Button
class_name EventButton


@export var _event_node_uid : String


@onready var edit_event_window : EditEventWindow = owner.edit_event_window


func _on_pressed() -> void:
	if _event_node_uid == "":
		push_error("The \"%s\" event button doesn't have a node associated to it." % text)
		return
	
	_create_event_node()
	
	owner.queue_free()


func _create_event_node() -> void:
	var event_node_scene : PackedScene = load(_event_node_uid)
	var event_node := event_node_scene.instantiate()
	event_node.position_offset = (edit_event_window.node_spawning_position + edit_event_window.graph_edit.scroll_offset) / edit_event_window.graph_edit.zoom
	edit_event_window.graph_edit.add_child(event_node)
	event_node.node_selected.connect(edit_event_window.on_event_node_selected.bind(event_node))
	event_node.node_deselected.connect(edit_event_window.on_event_node_deselected)
