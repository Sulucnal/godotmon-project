extends RefCounted
class_name Constants


## The constants used all across your game.[br]
## If a constant isn't found their, then it may be script specific or handled differently (using
## resources for example). 


#region OVERWORLD

## Size of a tile in pixels. Assumes tiles are square.
const TILE_SIZE : int = 16

#endregion

#region MONSTERS

## The genders monsters can have. Affect their reproduction as well as the effects of some moves.
enum GENDER { MALE, FEMALE, GENDERLESS }
## The likeliness of a monster being male or female.[br]
enum GENDER_RATIO { ALWAYS_MALE, FEMALE_ONE_EIGHTH, FEMALE_25_PERENT, FEMALE_50_PERCENT, FEMALE_75_PERCENT, FEMALE_SEVEN_EIGHTHS, ALWAYS_FEMALE, GENDERLESS}

#endregion

#region MOVES

## The entity affected by a specific move.
enum MOVE_TARGET {
	## Every monster on the battlefield.
	ALL,
	## Every monster on the battlefield except for the user.
	ALL_ADJACENT,
	## Every monster on the opposing side of the battlefield.
	ALL_ADJACENT_FOES,
	## Every monster on the user's side of the battlefield.
	ALL_ALLIES,
	## Every monster in the user's party.
	ALLY_TEAM,
	## Affects the battlefield itself, on both side.
	FIELD,
	## Affects the battlefield on the opposing side.
	FOE_SIDE,
	## Affects the battlefield on the user's side.
	USER_SIDE,
	## A random monster close to the user.
	RANDOM_ADJACENT,
	## A monster close to the user.
	SINGLE_ADJACENT,
	## A monster close to the user and on its side.
	SINGLE_ADJACENT_ALLY,
	## A monster close to the user and on the opposing side.
	SINGLE_ADJACENT_FOE,
	## A monster on the user's side including the user itself.
	SINGLE_ALLY_OR_USER,
	## A monster that isn't the user.
	SINGLE_BUT_USER,
	## The user of the move.
	USER,
}

## Each move comes with one of the following categories. They are used in the damage calculation of
## an attack.
enum MOVE_CATEGORY {
	## Damaging moves where the user makes direct contact with the target like a punch or a bite.
	DIRECT,
	## Damaging moves where the user affects the target without being physically in contact with it
	## like with a projectile or a laser beam.
	INDIRECT,
	## Moves where the target doesn't take damage.
	OTHER,
}

#endregion
