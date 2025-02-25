@tool
extends EditorPlugin
class_name GodotmonPlugin


const MAIN_TAB : PackedScene = preload("res://addons/godotmon/assets/templates/editor_tabs/main_tab.tscn")
#TODO: Replace the placeholder icon with a proper one.
const ICON : Texture2D = preload("res://addons/godotmon/assets/graphics/icons/tab_icon.svg")
const PLUGIN_NAME : String = "Godotmon"


var main_tab_instance : EditorTab

#Used by the update checker.
static var current_version : String


func _enter_tree() -> void:
	main_tab_instance = MAIN_TAB.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_tab_instance)
	_make_visible(false)
	
	current_version = get_plugin_version()


func _exit_tree() -> void:
	if main_tab_instance:
		main_tab_instance.queue_free()


func _make_visible(visible: bool) -> void:
	if main_tab_instance:
		main_tab_instance.visible = visible


func _has_main_screen() -> bool:
	return true


func _get_plugin_name() -> String:
	return PLUGIN_NAME


func _get_plugin_icon() -> Texture2D:
	return ICON
