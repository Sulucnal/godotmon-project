@tool
extends Button
class_name EditorSceneButton


@export var scene : PackedScene


func _on_pressed() -> void:
	if scene == null:
		push_error("This functionality hasn't been implemented yet.")
		return
	
	var scene_instance : Control = scene.instantiate()
	owner.add_child(scene_instance)
