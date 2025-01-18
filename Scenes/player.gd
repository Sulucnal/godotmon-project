extends CharacterBody2D

@export var walk_speed = 4.0   # Tiles per second
const TILE_SIZE = 16

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var ray = $RayCast2D

enum PlayerState { IDLE, TURNING, WALKING }
enum FacingDirection { LEFT, RIGHT, UP, DOWN }

var player_state = PlayerState.IDLE
var facing_direction = FacingDirection.DOWN

var initial_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

#-------------------------------------------------------------------------------

func _ready() -> void:
	anim_tree.active = true
	anim_state.travel("Idle")
	initial_position = position

func _physics_process(delta: float) -> void:
	if player_state == PlayerState.TURNING:
		return
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		anim_state.travel("Walk")
		move(delta)
	else:
		is_moving = false
		process_player_input()
		if is_moving == false && player_state != PlayerState.TURNING:
			anim_state.travel("Idle")

func process_player_input() -> void:
	if input_direction.y == 0:
		input_direction.x = int(Input.get_action_strength("ui_right")) - int(Input.get_action_strength("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.get_action_strength("ui_down")) - int(Input.get_action_strength("ui_up"))

	if input_direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_direction)
		anim_tree.set("parameters/Walk/blend_position", input_direction)
		anim_tree.set("parameters/Turn/blend_position", input_direction)

		if need_to_turn():
			player_state = PlayerState.TURNING
			anim_state.travel("Turn")
		else:
			initial_position = position
			is_moving = true
	else:
		anim_state.travel("Idle")

func need_to_turn() -> bool:
	var new_facing_direction
	if input_direction.x < 0:   # Facing left
		new_facing_direction = FacingDirection.LEFT
	elif input_direction.x > 0:   # Facing right
		new_facing_direction = FacingDirection.RIGHT
	elif input_direction.y < 0:   # Facing up
		new_facing_direction = FacingDirection.UP
	elif input_direction.y > 0:   # Facing down
		new_facing_direction = FacingDirection.DOWN

	if new_facing_direction != facing_direction:
		facing_direction = new_facing_direction
		return true
	facing_direction = new_facing_direction
	return false

func finished_turning() -> void:
	player_state = PlayerState.IDLE

func move(delta: float) -> void:
	# Collision checks
	ray.target_position = input_direction * TILE_SIZE / 2
	ray.force_raycast_update()
	if ray.is_colliding():
		percent_moved_to_next_tile = 0.0
		input_direction = Vector2.ZERO
		is_moving = false
		return

	# Move forward
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.0:
		position = initial_position + (input_direction * TILE_SIZE)
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = initial_position + (input_direction * TILE_SIZE * percent_moved_to_next_tile)
