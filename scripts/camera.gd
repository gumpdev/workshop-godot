extends Camera2D

@export var follow: Node2D
@export var dead_area: float
@export var camera_limit_min: float
@export var camera_limit_max: float

func get_follow_position():
	var pos = follow.position
	pos.x = clampf(pos.x, camera_limit_min, camera_limit_max)
	return pos

func _process(delta: float) -> void:
	var follow_pos = get_follow_position()
	if position.distance_to(follow_pos) > dead_area:
		position.x = lerp(position.x, follow_pos.x, 2 * delta)
