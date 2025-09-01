extends Node

signal on_attack()

func get_horizontal_input():
	return Input.get_axis("left", "right")

func is_jumping_input():
	return Input.is_action_just_pressed("up")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		on_attack.emit()