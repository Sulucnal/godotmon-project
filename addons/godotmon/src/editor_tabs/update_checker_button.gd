@tool
extends Button


const GITHUB_PROJECT_VERSION_URL : String = "https://raw.githubusercontent.com/Sulucnal/godotmon-project/refs/heads/godotmon-addon/addons/godotmon/plugin.cfg"
const GITHUB_PROJECT_CHANGELOG_URL : String = "https://raw.githubusercontent.com/Sulucnal/godotmon-project/refs/heads/godotmon-addon/addons/godotmon/changelog.txt"


signal online_version_assigned
signal changelog_gotten


@onready var version_http_request: HTTPRequest = $VersionHTTPRequest
@onready var changelog_http_request: HTTPRequest = $ChangelogHTTPRequest
@onready var content_http_request: HTTPRequest = $ContentHTTPRequest

@onready var version_comparison_label: RichTextLabel = %VersionComparisonLabel
@onready var confirmation_dialog: ConfirmationDialog = %ConfirmationDialog
@onready var changelog_label: RichTextLabel = %ChangelogLabel


var current_version : Array[String]
var online_version_string : String
var online_version : Array[String]


func _on_pressed() -> void:
	current_version.append_array(GodotmonPlugin.current_version.split("."))
	version_http_request.request(GITHUB_PROJECT_VERSION_URL)
	await online_version_assigned
	if not _is_online_version_higher():
		push_warning("You are currently using the newest version of Godotmon.")
	else:
		_dialog_setup()
		confirmation_dialog.show()


func _on_version_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var page_body : String = body.get_string_from_ascii()
	var cfg : ConfigFile = ConfigFile.new()
	cfg.parse(page_body)

	online_version_string = cfg.get_value("plugin", "version")
	online_version.append_array(online_version_string.split("."))
	
	online_version_assigned.emit()


func _is_online_version_higher() -> bool:
	if current_version.size() < online_version.size():
		online_version.resize(current_version.size())
	elif current_version.size() > online_version.size():
		current_version.resize(online_version.size())
	
	for version in current_version.size():
		if current_version[version] < online_version[version]:
			return true
	
	return false


func _dialog_setup() -> void:
	version_comparison_label.append_text("[center][b][color=red]%s[/color][/b] -> [b][color=green]%s[/color][/b][/center]" % [GodotmonPlugin.current_version, online_version_string])
	changelog_http_request.request(GITHUB_PROJECT_CHANGELOG_URL)
	await changelog_gotten
	
	confirmation_dialog.size = DisplayServer.screen_get_size() / 2
	confirmation_dialog.position = DisplayServer.screen_get_size() / 4


func _on_changelog_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	changelog_label.append_text(body.get_string_from_ascii())
	changelog_gotten.emit()


func _on_confirmation_dialog_canceled() -> void:
	confirmation_dialog.hide()
	version_comparison_label.clear()
	changelog_label.clear()


func _on_confirmation_dialog_confirmed() -> void:
	pass


func _on_confirmation_dialog_close_requested() -> void:
	_on_confirmation_dialog_canceled()
