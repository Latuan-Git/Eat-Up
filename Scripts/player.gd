extends CharacterBody2D
class_name Player

@export var bite_check: Node2D
@export var camera: PlayerCamera
@export var sprite: AnimatedSprite2D
@export var highlight: AnimatedSprite2D

var bite_check_array: Array[RayCast2D]
var highlighting: Entity = null

const SPEED = 300.0

var ent = preload("res://Scenes/Entities/prey_entity.tscn")

func _ready() -> void:
	for child: RayCast2D in bite_check.get_children():
		bite_check_array.append(child)

func _process(_delta: float) -> void:
	if highlighting != null:
		highlight.visible = true
		highlight.global_position = highlighting.global_position


func _physics_process(_delta: float) -> void:
	var highlighted: bool = false
	for check: RayCast2D in bite_check_array:
		if check.get_collider() is Entity:
			highlighting = check.get_collider()
			highlighted = true
			break
	if !highlighted:
		highlighting = null
		highlight.visible = false


	var input_dir: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if input_dir.x > 0:
		sprite.flip_h = false
	elif input_dir.x < 0:
		sprite.flip_h = true

	if input_dir.length() > 1:
		input_dir = input_dir.normalized()
	
	if input_dir != Vector2.ZERO:
		velocity = input_dir * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if velocity.length() > 0:
		sprite.play("run")
	else:
		sprite.play("default")

	move_and_slide()

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#for loop in range(10):
		#	var ins_ent = ent.instantiate()
		#	get_tree().root.add_child(ins_ent)
	
	if event.is_action_pressed("Click"):
		print("Click")
		for check: RayCast2D in bite_check_array:
			if check.get_collider() is Entity:
				check.get_collider().on_hit()
				break
		
	if event is InputEventMouseMotion:
		bite_check.rotation = bite_check.global_position.direction_to(get_global_mouse_position()).angle()
