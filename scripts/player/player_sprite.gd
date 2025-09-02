extends AnimatedSprite2D

const animations = {
	PlayerState.State.IDLE: "idle",
	PlayerState.State.MOVEMENT: "walk",
	PlayerState.State.JUMP: "jump",
	PlayerState.State.FALL: "fall",
	PlayerState.State.LAND: "land",
	PlayerState.State.ATTACK: "attack",
}

func flip_sprite(direction: int):
	if direction != 0:
		flip_h = direction < 0

func play_animation(state: PlayerState.State):
	play(animations[state])

func _physics_process(delta: float) -> void:
	scale.x = move_toward(scale.x, 1, 1 * delta)
	scale.y = move_toward(scale.y, 1, 1 * delta)

func squash_and_stretch(state: PlayerState.State):
	match state:
		PlayerState.State.JUMP:
			stretch()
		PlayerState.State.FALL:
			stretch()
		PlayerState.State.LAND:
			squash()

func stretch():
	scale = Vector2(0.8, 1.3)
	
func squash():
	scale = Vector2(1.3, 0.8)
