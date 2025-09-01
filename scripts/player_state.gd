class_name PlayerState extends Node

signal state_changed(state: State)

enum State {
	IDLE,
	MOVEMENT,
	JUMP,
	FALL,
	LAND,
	ATTACK
}
var state: State = State.IDLE: set = _set_state

var state_freezed = false
func _set_state(_state: State):
	if state_freezed: return
	if state != _state:
		state_changed.emit(_state)
	state = _state

func freeze_state(_state: State, _time: float):
	state = _state
	state_freezed = true
	await get_tree().create_timer(_time).timeout
	state_freezed = false
