extends Resource
class_name SkillData


## Data entity describing a (passive or active) Skill
##
## @tutorial: https://github.com/Maruno17/godotmon-project/wiki/Data-types#skilldata


## ID of the skill
@export var id : StringName
## Class of the the effect to use (in battle or overworld)
@export var effect_class : StringName
## Data of the effect (so the class can work properly)
@export var effect_data : Dictionary
