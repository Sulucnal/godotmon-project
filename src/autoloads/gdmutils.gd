extends Node


##A collection of functions with a wide range of effects. Meant to be used in combination with events.


const DIALOG_BOX : PackedScene = preload("res://assets/graphics/ui/dialog/dialog_box/dialog_box.tscn")


##@experimental
##Shows a dialog box with the specified [param message]. Supports [url=https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html]BBCode[/url].
func show_message(message : String, talker_name : String = "", talker_image_path : String = "") -> void:
	get_tree().paused = true
	ScenesManager.add_scene("res://assets/graphics/ui/dialog/dialog_box/dialog_box.tscn", ScenesManager.SceneType.UI)
	var dialog_box : DialogBox = ScenesManager.last_scene_added
	dialog_box.populate_box(message, talker_name, talker_image_path)
	#dialog_box.show()
	dialog_box.handle_message_display()
