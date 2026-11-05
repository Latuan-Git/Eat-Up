extends Node
class_name Level

@export var res: LevelResource
@export var timer: Timer
@export var spawn_points: Array[Marker2D]
@export var player: Player

var points: int = 0:
	set(value):
		points = value
		signals.points_changed.emit(points)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signals.add_level_points.connect(add_points)
	timer.timeout.connect(time_end)
	timer.wait_time = res.time
	timer.start()

	while true:
		var closest_point: Marker2D = spawn_points[0]
		for point in spawn_points:
			if point.global_position.distance_to(player.global_position) < closest_point.global_position.distance_to(player.global_position):
				closest_point = point
		
		for point in spawn_points:
			if point != closest_point:
				var new_entity: Entity = res.entity_types[randi_range(0, len(res.entity_types) -1)].instantiate()
				new_entity.global_position = point.global_position
				add_child(new_entity)
		
		await get_tree().create_timer(5).timeout
		
func add_points(amount: int) -> void:
	points = points + amount
	if points >= res.points_required:
		level_complete()

func time_end() -> void:
	get_tree().paused = true
	scenes.quick_switch_scene("levellostui", "ui")

func level_complete() -> void:
	print("Level Complete")
	signals.level_complete.emit(self)
	get_tree().paused = true
	scenes.quick_switch_scene("levelcompleteui", "ui")
