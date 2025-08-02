extends Resource
class_name WorldMeta


## The meta about a world, i.e. a collection of multiple maps.
##
## @tutorial: https://github.com/Maruno17/godotmon-project/wiki/Data-types#worldmeta


## ID of the world
@export var id : StringName
## All the maps the world contains
@export var maps : Array[MapMeta]
## All the flags related to gameplay (eg. CAN_USE_FLY, CAN_USE_DIG, etc...)
@export var flags : Array[StringName]
