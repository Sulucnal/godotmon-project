extends PlayerControllerBase
class_name Grid4Controller

func _get_direction(input: Vector2) -> Vector2:
	if (input.is_zero_approx()):
		return Vector2.ZERO

	var max_axis = input.abs().max_axis_index()
	if (max_axis == Vector2.Axis.AXIS_X):
		return Vector2(sign(input.x), 0)
	else:
		return Vector2(0, sign(input.y))
