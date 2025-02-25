extends Control
class_name EditorTab


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if name == "MainTab":
			return
		
		queue_free()
