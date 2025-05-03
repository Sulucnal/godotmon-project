extends CharacterBody2D
class_name Entity


## The basic node used to create moving entities.
##
## Let you create entities that can go to specific coordinates, or move relatively to their current position.[br]
## If you want your entity to be animated, use [AnimatedEntity] instead.
##
## @tutorial: TODO


enum State {IDLE, MOVING}

var state: State = State.IDLE
# var move_start_position: Vector2 = Vector2.ZERO
var move_direction: Vector2 = Vector2.ZERO
var move_speed_multiplier: float = 1.0
@onready var target_position: Vector2 = position
# var percent_moved_to_next_tile: float = 0.0
