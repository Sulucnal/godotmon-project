extends Control
class_name DialogBox


const LINES_IN_BOX : int = 3
const MAX_CHARACTER_PER_CHUNK : int = 150


@onready var portrait_texture: TextureRect = %PortraitTexture
@onready var name_label: RichTextLabel = %NameLabel
@onready var dialog_label: RichTextLabel = %DialogLabel
@onready var arrow_panel: Panel = %ArrowPanel


var _message : String
var text_chunks : PackedStringArray


func populate_box(message : String, talker_name : String, talker_image_path : String) -> void:
	_message = message
	
	if talker_name != "":
		name_label.text = talker_name
		name_label.show()
	
	if talker_image_path != "":
		portrait_texture.texture = load(talker_image_path)
		portrait_texture.show()
	
	_divide_message()


#TODO: Find a way to make it handle BBCode properly.
func _divide_message() -> void:
	#var raw_message : String = _strip_bbcode(_message)
	#var raw_message_array : PackedStringArray = raw_message.split(" ")
	var message_array : PackedStringArray = _message.split(" ")
	var string_section : String = ""
	for entry in message_array:
		if (string_section + entry).length() > MAX_CHARACTER_PER_CHUNK:
			text_chunks.append(string_section)
			string_section = (entry + " ")
		else:
			string_section += (entry + " ")
	
	text_chunks.append(string_section)


func _strip_bbcode(source:String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.+?\\]")
	return regex.sub(source, "", true)


func handle_message_display() -> void:
	arrow_panel.hide()
	dialog_label.text = text_chunks[0]
	while dialog_label.visible_ratio != 1:
		dialog_label.visible_characters += 1
		await get_tree().create_timer(GlobalVar.miliseconds_per_char).timeout


func _process(_delta: float) -> void: #I don't like the way it's done but I'm too tired to solve it right now.
	if dialog_label.visible_ratio == 1:
		arrow_panel.show()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_accept"):
		return
	
	if dialog_label.visible_ratio == 1:
		text_chunks.remove_at(0)
		
		if text_chunks.is_empty():
			_on_message_finished()
		else:
			dialog_label.visible_ratio = 0
			handle_message_display()
	else:
		dialog_label.visible_ratio = 1


func _on_message_finished() -> void:
	ScenesManager.remove_scene(name, ScenesManager.SceneType.UI)
	get_tree().paused = false
	Observer.message_closed.emit()
