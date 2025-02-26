extends Node


# A script used to run experiments without impacting the rest of the game's scripts.


func _ready() -> void:
	await get_tree().process_frame
	ScenesManager.add_scene("res://assets/maps/test map.tscn", ScenesManager.SceneType.WORLD)
	ScenesManager.add_scene("res://assets/templates/player.tscn", ScenesManager.SceneType.ENTITY, Vector2i(5, 5))
	
	await get_tree().create_timer(2).timeout
	GDMUtils.show_message("1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19\n20")
