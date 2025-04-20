extends Node
class_name PlayerController


var player : Player

var input_direction : Vector2


func _ready() -> void:
	if not owner is Player:
		push_error("The parent of this controller isn't a player.")
		return
	
	player = owner as Player
	player.controller = self


func _process(_delta: float) -> void:
	# Detect directional input
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down", player.INPUT_DEADZONE)
	_get_direction()


# Virtual function for classes that extend this one.
func _get_direction() -> Vector2:
	return Vector2.ZERO
