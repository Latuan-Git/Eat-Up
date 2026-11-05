extends CharacterBody2D
class_name Entity

var font = preload("res://Scenes/point_font.tres")
var bite = preload("res://Sounds/explosion.wav")
var score = preload("res://Sounds/pickupCoin.wav")

@export var sprite: AnimatedSprite2D
@export var spot_area: Area2D
@export var spot_collision: CollisionShape2D
@export var res_array: Array[EntityResource]
@export var col: CollisionShape2D
@export var bite_sound: AudioStreamPlayer
@export var point_sound: AudioStreamPlayer
@export var death_anim: AnimatedSprite2D
var target_point: Vector2 = Vector2.ZERO
var point_reached: bool = true
var spotted: bool = false
var res: EntityResource

func _ready() -> void:
	res = res_array[randi_range(0, 1)]
	target_point = global_position
	sprite.sprite_frames = res.textures
	sprite.play("default")
	var spot_shape: CircleShape2D = spot_collision.shape
	spot_shape.radius = res.spot_radius
	spot_area.body_entered.connect(on_spotted)

func roam() -> void:
	while(global_position.distance_to(target_point) <= res.roam_min_radius):
		target_point = Vector2(
			randf_range(-res.roam_max_radius, res.roam_max_radius) + global_position.x, 
			randf_range(-res.roam_max_radius, res.roam_max_radius) + global_position.y
			)
	
	point_reached = false


func roam_movement() -> void:
	if !point_reached:
		var direction: Vector2 = global_position.direction_to(target_point)
		velocity = res.roam_speed * direction
		if (global_position.distance_to(target_point) < res.end_point_lenience):
			point_reached = true
			velocity = Vector2.ZERO
			await get_tree().create_timer(randf_range(res.roam_min_cooldown, res.roam_max_cooldown)).timeout
			if point_reached:
				roam()

func on_spotted(_body: Node2D) -> void:
	pass

func spotted_movement(_body: Node2D) -> void:
	pass

func action() -> void:
	pass

func on_hit() -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = bite
	sound.autoplay = true
	add_child(sound)
	res.health = res.health - 1
	if res.health <= 0:
		on_death()

func on_death() -> void:
	death_anim.visible = true
	death_anim.play("default")
	col.disabled = true
	await death_anim.animation_finished
	death_anim.visible = false
	var sound = AudioStreamPlayer.new()
	sound.stream = score
	sound.autoplay = true
	add_child(sound)
	signals.add_level_points.emit(res.experience_value)
	sprite.visible = false
	signals.add_time.emit(res.time_value)
	var score_label = Label.new()
	score_label.text = str(res.experience_value)
	score_label.label_settings = font
	score_label.scale = Vector2(3, 3)
	col.disabled = true
	set_physics_process(false)
	add_child(score_label)
	var tween := score_label.create_tween()
	tween.tween_property(score_label, "position", Vector2(score_label.position.x, score_label.position.y - 100), 1)
	tween.parallel().tween_property(score_label, "modulate", Color.TRANSPARENT, 1)
	await tween.finished
	queue_free()
