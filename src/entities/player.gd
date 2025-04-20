extends AnimatedEntity
class_name Player


##The player scene and all of the logic behind it.
##
## @tutorial: TODO


## Deadzone used when determining the vector used for player movements.
const INPUT_DEADZONE : float = 0.5

var player_state : AnimatedEntityState = AnimatedEntityState.IDLE

var controller : PlayerController

@onready var ray : RayCast2D = $RayCast2D

#-------------------------------------------------------------------------------

func _physics_process(delta: float) -> void:
	if player_state == AnimatedEntityState.TURNING:
		return
	# Moving, so continue the move
	var was_moving = false
	if is_moving:
		controller.update_move(delta)
		was_moving = true
	# Standing still or a step just ended, so check for input to move the player
	if is_moving == false:
		process_player_input(was_moving)


func process_player_input(moved_last_update: bool = false) -> void:
	# If no directional input, idle
	if controller.input_direction.is_zero_approx():
		set_state(AnimatedEntityState.IDLE)
		return
	controller.input_direction = controller.input_direction.normalized()
	# Apply directional input
	if !moved_last_update && need_to_turn(controller.input_direction):
		set_state(AnimatedEntityState.TURNING)
		turn(controller.input_direction)
	elif can_move_in_direction(controller.input_direction):
		set_state(AnimatedEntityState.WALKING)
		turn(controller.input_direction)
		move(controller.input_direction)
	else:
		set_state(AnimatedEntityState.IDLE)

#-------------------------------------------------------------------------------

func need_to_turn(new_direction: Vector2) -> bool:
	var new_facing_direction = VECTOR_TO_DIRECTION[new_direction.sign()]
	return new_facing_direction != facing_direction


func turn(direction: Vector2) -> void:
	facing_direction = VECTOR_TO_DIRECTION[direction.sign()]
	animation_tree.set("parameters/StateMachine/Idle/blend_position", direction)
	animation_tree.set("parameters/StateMachine/Turn/blend_position", direction)
	animation_tree.set("parameters/StateMachine/Walk/blend_position", direction)
	animation_tree.set("parameters/StateMachine/Run/blend_position", direction)


# Called by turning animations to return to the idle charset
func finished_turning() -> void:
	set_state(AnimatedEntityState.IDLE)

#-------------------------------------------------------------------------------

func can_move_in_direction(direction: Vector2) -> bool:
	# Debug "walk through anything" mode
	if OS.is_debug_build() && Input.is_action_pressed("ui_control"):
		return true
	# Collision checks
	ray.target_position = direction * Constants.TILE_SIZE
	ray.force_raycast_update()
	if ray.is_colliding():
		percent_moved_to_next_tile = 0.0
		move_direction = Vector2.ZERO
		return false
	return true


func move(direction: Vector2) -> void:
	move_start_position = position
	move_direction = direction
	set_speed_modifier()
	is_moving = true


func should_run() -> bool:
	return Input.is_action_pressed("ui_shift")


func set_speed_modifier(reset: bool = false) -> void:
	move_speed_multiplier = 1.0
	if !reset:
		if should_run():
			move_speed_multiplier = Constants.RUN_SPEED_MULTIPLIER
			set_state(AnimatedEntityState.RUNNING)
	animation_tree.set("parameters/TimeScale/scale", Constants.WALK_SPEED * move_speed_multiplier)
