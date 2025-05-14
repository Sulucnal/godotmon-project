extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {WORLD, ENTITY, UI}


@onready var main : Main = get_tree().root.get_child(-1)


## Adds a scene to the main one.
func add_scene(scene_path : String, scene_type : SceneType, coordinates : Vector2i = Vector2i.ZERO) -> void:
	var final_position : Vector2i = coordinates * Constants.TILE_SIZE
	
	match scene_type:
		SceneType.WORLD:
			print(main)
			var scene : Node2D = load(scene_path).instantiate()
			scene.global_position = final_position
			main.world_parent.add_child(scene)
		SceneType.ENTITY:
			var scene : Node2D = load(scene_path).instantiate()
			#final_position.x += Constants.TILE_SIZE / 2		#May need to be readded later when trying out stuff with y-sorting.
			#final_position.y += Constants.TILE_SIZE / 2
			scene.global_position = final_position
			main.world_parent.add_child(scene)
		SceneType.UI:
			var scene : Control = load(scene_path).instantiate()
			scene.global_position = coordinates
			main.ui_parent.add_child(scene)


## Removes a scene from the main one.
func remove_scene(scene_name : String, scene_type : SceneType) -> void:
	match scene_type:
		SceneType.WORLD:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		SceneType.ENTITY:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		SceneType.UI:
			var node_to_remove : Control = get_node(str(main.ui_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
