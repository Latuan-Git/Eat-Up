extends Control

func _on_button_button_down() -> void:
	var level = scenes.get_scene("level1")
	var ui: LevelUI = scenes.get_scene("levelui")
	ui.level = level
	scenes.switch_scene_to_node(level, "2d")
	scenes.switch_scene_to_node(ui, "ui")
