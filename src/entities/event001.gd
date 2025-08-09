extends CharacterBody2D
class_name Event001


@export var _mover: EntityMoverComponent


const TIMER_DELAY : float = 0.25


func _ready() -> void:
	_move_init()

func _next_step_after_time(step: Callable) -> void:
	var timer: SceneTreeTimer = get_tree().create_timer(TIMER_DELAY)
	timer.timeout.connect(step, CONNECT_ONE_SHOT)

func _move_init() -> void:
	_next_step_after_time(_move_step1)

func _move_step1() -> void:
	if (_mover.can_move_in_direction(Vector2.DOWN)):
		_mover.move_completed.connect(_move_step2, CONNECT_ONE_SHOT)
		_mover.move_forced(Vector2.DOWN)
	else:
		_next_step_after_time(_move_step1)
		
func _move_step2() -> void:
	_next_step_after_time(_move_step3)

func _move_step3() -> void:
	if (_mover.can_move_in_direction(Vector2.UP)):
		_mover.move_completed.connect(_move_init, CONNECT_ONE_SHOT)
		_mover.move_forced(Vector2.UP)
	else:
		_next_step_after_time(_move_step3)
