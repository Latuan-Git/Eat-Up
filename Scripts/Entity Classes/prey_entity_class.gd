extends Entity
class_name Prey_Entity

var player: Player
	
func _ready() -> void:
	super()
	roam()

func _physics_process(_delta: float) -> void:
	if spotted:
		spotted_movement(player)
	else:
		roam_movement()
	
	if velocity.length() > 0:
		sprite.play("run")
	else:
		sprite.play("default")

	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()

func on_spotted(body: Node2D) -> void:
	if body is Player:
		spotted = true
		player = body
		point_reached = true

func spotted_movement(body: Node2D) -> void:
	if !point_reached:
		velocity = res.speed * global_position.direction_to(target_point)

		if (global_position.distance_to(target_point) < res.end_point_lenience):
			point_reached = true

			if spot_area.overlaps_body(body):
				print("Still inside")

			else:
				print("Back to romaing")
				spotted = false
				target_point = global_position
				roam()
	else:
		var dir = body.global_position - global_position

		dir = -dir.normalized()

		var angle_offset = deg_to_rad(randf_range(-30, 30))
		dir = dir.rotated(angle_offset)

		var distance = randf_range(res.roam_min_radius/2, res.roam_max_radius/2)

		target_point = global_position + dir * distance
		print("Finding new point")
		point_reached = false
