@tool
extends AcceptDialog
class_name EditEventWindow


enum EventTypes{LOGIC, DIALOGUES, MOVEMENTS, OTHER}


const EVENT_LIST_WINDOW_UID : String = "uid://bo6awgy2euma"


@onready var graph_edit: GraphEdit = $GraphEdit


var node_selected : GraphNode
var node_spawning_position : Vector2 = Vector2.ZERO


func on_event_node_selected(event_node : EventNode) -> void:
	#Needed to make sure that a node_selected is assigned after another one gets deselected.
	await get_tree().create_timer(0.01).timeout
	node_selected = event_node


func on_event_node_deselected() -> void:
	node_selected = null


func _on_graph_edit_gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	event = event as InputEventMouseButton
	if not event.button_index == MOUSE_BUTTON_RIGHT:
		return
	
	if node_selected:
		node_selected.queue_free()
	else:
		node_spawning_position = graph_edit.get_local_mouse_position()
		var event_list_window_scene : PackedScene = load(EVENT_LIST_WINDOW_UID)
		var event_list_window : EventListWindow = event_list_window_scene.instantiate()
		event_list_window.edit_event_window = self
		get_tree().root.add_child(event_list_window)
