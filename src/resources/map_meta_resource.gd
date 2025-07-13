extends Resource
class_name MapMeta


## All the meta about a specific map
##
## @tutorial: https://github.com/Maruno17/godotmon-project/wiki/Data-types#mapmeta


## Path to the scene to load when the map is active
@export_file("*.tscn") var scene : String
## Key used to retrieve the name of the map in the text data
@export var name_key : StringName
## Value used to guess which kind of map panel to show when player enters the map
@export var map_type : Constants.MapType
## Position of the map in the world it's in
@export var position : Vector2i
## List of encounter group the map shows when loaded an primary
#@export var encounter_table : Array[WildEncounterGroup]
