extends Node
class_name MainScene

@export var root_2d_scene: Node2D
@export var root_ui_scene: Control
@export var click_sound: AudioStreamPlayer

var click_und = preload("res://Sounds/click.wav")

func _ready() -> void:
	scenes.root_2d_scene = root_2d_scene
	scenes.root_ui_scene = root_ui_scene
	AudioServer.set_bus_volume_linear(0, 0.5)
	scenes.quick_switch_scene("titlescreen", "ui")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		var sound = AudioStreamPlayer.new()
		sound.stream = click_und
		sound.autoplay = true
		sound.volume_db = -12
		add_child(sound)
		await sound.finished
		sound.queue_free()