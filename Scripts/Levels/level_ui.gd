extends Control
class_name LevelUI

var level: Level
@onready var level_timer = level.timer
@export var time_bar: ProgressBar
@export var xp_bar: ProgressBar

var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_bar.max_value = level_timer.wait_time
	time_bar.value = level_timer.time_left
	signals.points_changed.connect(on_experience_change)
	xp_bar.max_value = level.res.points_required
	xp_bar.value = level.points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time_bar.value = level_timer.time_left


func on_experience_change(new_value: float) -> void:
	var tween := create_tween()
	tween.tween_property(xp_bar, "value", new_value, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		if paused:
			get_tree().paused = false
