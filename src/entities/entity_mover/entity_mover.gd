extends Node
class_name EntityMover

var target_position: Vector2 = Vector2.ZERO
var move_direction: Vector2 = Vector2.ZERO


func compute_move(direction: Vector2, entity: Entity, speed: float) -> void:
	if (is_moving() && !will_stop_moving(entity, 0)):
		return
	if (direction.is_zero_approx()):
		move_direction = direction
		return
	
	var collision = entity.move_and_collide(direction, true, 0)
	if (!collision):
		target_position = direction + entity.position
		move_direction = direction * speed

func move(entity: Entity, delta: float) -> void:
	if (will_stop_moving(entity, delta)):
		move_direction = Vector2.ZERO
		entity.position = target_position
		return

	var collision = entity.move_and_collide(move_direction * delta, false, 0)
	if (collision):
		move_direction = Vector2.ZERO

func is_moving() -> bool:
	return !move_direction.is_zero_approx()

func will_stop_moving(entity: Entity, delta: float) -> bool:
	if (!is_moving()):
		return false
	if (target_position.is_equal_approx(entity.position)):
		return true

	var target_angle = (target_position - entity.position - (move_direction * delta)).angle()
	return target_angle != move_direction.angle()
