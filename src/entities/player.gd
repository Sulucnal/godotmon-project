extends AnimatedEntity
class_name Player

##The player scene and all of the logic behind it.
##
## @tutorial: TODO

@onready var controller: PlayerController = $Controller
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var entity_mover: EntityMover = $EntityMover

var player_state: AnimatedEntityState = AnimatedEntityState.IDLE

func _physics_process(delta: float) -> void:
	if (_can_player_move_entity(delta)):
		_handle_player_control()

	if (entity_mover.is_moving()):
		entity_mover.move(self, delta)

func _get_speed(using_controller: bool) -> float:
	var speed = move_speed_multiplier * Constants.WALK_SPEED
	if (!using_controller):
			return speed
	if (controller.running_requested):
		return speed * 2
	
	return speed;

## Function responsive of verifying that the player playing the game can move this entity.
##
## TODO: add cases when the player entity has move_routes to follow
func _can_player_move_entity(delta: float) -> bool:
	return !entity_mover.is_moving() || entity_mover.will_stop_moving(self, delta)

func _handle_player_control() -> void:
	controller.update()
	collision_shape.disabled = controller.ghost_movement_requested
	entity_mover.compute_move(controller.current_direction * Constants.TILE_SIZE, self, _get_speed(true))
	if (!entity_mover.is_moving()):
		collision_shape.disabled = false
