extends Node

signal on_attack()
signal on_jump()

func get_horizontal_input():
	return Input.get_axis("left", "right")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		on_attack.emit()

	if Input.is_action_just_pressed("up"):
		on_jump.emit()