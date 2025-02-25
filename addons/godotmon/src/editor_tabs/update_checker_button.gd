@tool
extends Button


@onready var http_request: HTTPRequest = $HTTPRequest


var current_major_version : int
var current_minor_version : int
var current_patch_version : int


func _on_pressed() -> void:
	_get_current_version_numbers()
	


func _get_current_version_numbers() -> void:
	current_major_version = int(GodotmonPlugin.current_version.get_slice(".", 0))
	current_minor_version = int(GodotmonPlugin.current_version.get_slice(".", 1))
	current_patch_version = int(GodotmonPlugin.current_version.get_slice(".", 2))
