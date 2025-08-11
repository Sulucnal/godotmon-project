@tool
extends GraphElement


@onready var background: Panel = $Background
@onready var text_edit: TextEdit = $Background/MarginContainer/HBoxContainer/TextEdit
@onready var h_box_container: HBoxContainer = $Background/MarginContainer/HBoxContainer


func _on_text_color_button_color_changed(color: Color) -> void:
	text_edit.modulate = color


func _on_background_color_button_color_changed(color: Color) -> void:
	background.self_modulate = color


func _on_h_box_container_resized() -> void:
	custom_minimum_size = h_box_container.size
