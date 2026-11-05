extends Resource
class_name EntityResource

@export var entity_name: String = "Error"
@export_category("Stats")
@export_range(0, 500) var speed: float = 250.0
@export var health: int = 1
@export var experience_value: int = 500
@export var time_value: float = 5.0
@export_subgroup("Roam Stats")
@export var roam_speed: float = 200.0
@export var spot_radius: float = 150.0
@export_range(0, 500) var roam_max_radius: float = 250.0
@export_range(0, 500) var roam_min_radius: float = 100.0
@export_range(0, 30) var roam_max_cooldown: float = 5.0
@export_range(0, 30) var roam_min_cooldown: float = 2.0
@export_range(0, 10) var end_point_lenience: float = 5.0
@export_category("Data")
@export var textures: SpriteFrames