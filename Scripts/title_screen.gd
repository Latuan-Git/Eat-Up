extends Control

@export var volume: HSlider
@export var text: Label

func _ready() -> void:
	get_tree().paused = false
	volume.value = db_to_linear(AudioServer.get_bus_volume_db(0))

func _on_play_button_down() -> void:
	scenes.quick_switch_scene("tutorialui", "ui")



func _on_settings_button_down() -> void:
	pass # Replace with function body.

func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db((value)))
	text.text = "Volume: " + str(value*100)