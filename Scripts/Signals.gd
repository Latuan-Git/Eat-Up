extends Node
class_name SignalBus

signal add_level_points(amount: int)
signal points_changed(new_value: int)
signal level_complete(level: Level)
signal add_time(time: float)
signal play_score()