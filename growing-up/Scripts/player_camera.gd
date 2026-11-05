extends Camera2D
class_name PlayerCamera

@export var max_distance: float = 100.0 
@export var smooth_speed: float = 5.0     

func _process(delta: float) -> void:
    var player_pos = get_parent().global_position
    var mouse_pos = get_global_mouse_position()
    
    var direction = mouse_pos - player_pos
    
    if direction.length() > max_distance:
        direction = direction.normalized() * max_distance
    
    var target_position = player_pos + direction
    
    global_position = global_position.lerp(target_position, smooth_speed * delta)