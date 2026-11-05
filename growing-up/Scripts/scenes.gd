extends Node
class_name Scenes

var root_2d_scene
var root_ui_scene

var scenes: Dictionary = {
	# MENUS
	"mainscene": "res://Scenes/Levels/level_1.tscn",
	"titlescreen": "res://Scenes/title_screen.tscn",
	# UI
	"levelui": "res://Scenes/Levels/level_ui.tscn",
	"levellostui": "res://Scenes/level_lost_ui.tscn",
	"levelcompleteui": "res://Scenes/level_complete_ui.tscn",
	"tutorialui": "res://Scenes/tutorial_ui.tscn",
	# LEVELS
	"level1": "res://Scenes/Levels/level_1.tscn",
	# ENTITIES
	"player": "res://Scenes/player.tscn",
	"preyentity": "res://Scenes/Entities/prey_entity.tscn",

}

var loaded_scenes: Dictionary = {

}

var active_scenes: Dictionary = {
	
}

func quick_switch_scene(scene_name: String, ui_or_2d: String = "2d") -> void:
	var scene

	if active_scenes.has(scene_name):
		scene = active_scenes[scene_name]

	elif loaded_scenes.has(scene_name):
		scene = loaded_scenes[scene_name]
	
	else:
		scene = load(scenes[scene_name])
		loaded_scenes[scene_name] = scene
	
	if scene is PackedScene:
		scene = scene.instantiate()
	
	if ui_or_2d == "2d":
		if root_2d_scene.get_child_count() > 0:
			root_2d_scene.get_child(0).queue_free()
		root_2d_scene.add_child(scene)
	elif ui_or_2d == "ui":
		if root_ui_scene.get_child_count() > 0:
			root_ui_scene.get_child(0).queue_free()
		root_ui_scene.add_child(scene)

func get_scene(scene_name: String) -> Node:
	var scene

	if active_scenes.has(scene_name):
		scene = active_scenes[scene_name]

	elif loaded_scenes.has(scene_name):
		scene = loaded_scenes[scene_name]
	
	else:
		scene = load(scenes[scene_name])
		loaded_scenes[scene_name] = scene
	
	if scene is PackedScene:
		scene = scene.instantiate()
	
	return scene

func switch_scene_to_node(scene: Node, ui_or_2d: String):
	if ui_or_2d == "2d":
		if root_2d_scene.get_child_count() > 0:
			root_2d_scene.get_child(0).queue_free()
		root_2d_scene.add_child(scene)
	elif ui_or_2d == "ui":
		if root_ui_scene.get_child_count() > 0:
			root_ui_scene.get_child(0).queue_free()
		root_ui_scene.add_child(scene)



func remove_scene(ui_or_2d: String = "2d") -> void:
	if ui_or_2d == "2d":
		if root_2d_scene.get_child_count() > 0:
			root_2d_scene.get_child(0).queue_free()
	elif ui_or_2d == "ui":
		if root_ui_scene.get_child_count() > 0:
			root_ui_scene.get_child(0).queue_free()
