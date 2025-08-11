@tool
extends Window
class_name EventListWindow


@export var events_to_tab : Dictionary[EditEventWindow.EventTypes, MarginContainer]


@onready var tabs_container: PanelContainer = $VBoxContainer/TabsContainer


var edit_event_window : EditEventWindow


func _on_tab_bar_tab_changed(tab: int) -> void:
	for child in tabs_container.get_children():
		child.hide()
	
	#@warning_ignore("int_as_enum_without_cast")
	events_to_tab[tab].show()


func _on_close_requested() -> void:
	queue_free()
