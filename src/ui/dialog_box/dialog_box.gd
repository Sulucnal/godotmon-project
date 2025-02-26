extends Control
class_name DialogBox


const LINES_IN_BOX : int = 3


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


func _divide_message() -> void:
	dialog_label.text = _message
	var characters : int = _message.length()
	show() #TEMPORARY
	for character in characters:
		await get_tree().process_frame
		dialog_label.visible_characters += 1
		print(dialog_label.get_visible_line_count())
		if dialog_label.get_visible_line_count() > LINES_IN_BOX:
			_message.right(dialog_label.visible_characters)
			text_chunks.append(dialog_label.text.left(dialog_label.visible_characters))
			dialog_label.visible_characters = 0
			dialog_label.clear()
			dialog_label.text = _message
			print(_message)
	
	print(text_chunks)


func handle_message_display(instantaneous : bool) -> void:
	#TEMPORARY
	await get_tree().create_timer(20).timeout
	_on_message_finished()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_accept"):
		return
	
	if dialog_label.visible_ratio == 1 and text_chunks.is_empty():
		_on_message_finished()


func _on_message_finished() -> void:
	ScenesManager.remove_scene(name, ScenesManager.SceneType.UI)
	get_tree().paused = false
