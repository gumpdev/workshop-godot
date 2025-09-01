extends CharacterBody2D

@export var speed: float = 75
@export var acceleration: float = 1000
@export var jump_height: float = 250

@onready var sprite = $Sprite
@onready var state_manager = $StateManager
@onready var controller = $Controller
@onready var GRAVITY = ProjectSettings.get("physics/2d/default_gravity")

func _ready() -> void:
	state_manager.state_changed.connect(sprite.play_animation)
	state_manager.state_changed.connect(sprite.squash_and_stretch)
	controller.on_attack.connect(attack)

func get_state():
	if velocity.y >= 0 and not is_on_floor():
		return PlayerState.State.FALL
	if state_manager.state == PlayerState.State.FALL and is_on_floor():
		state_manager.freeze_state(PlayerState.State.LAND, 0.2)
		return PlayerState.State.LAND
	if velocity.y < 0 and not is_on_floor():
		return PlayerState.State.JUMP
	if velocity.x != 0 and is_on_floor():
		return PlayerState.State.MOVEMENT
	return PlayerState.State.IDLE

func movement(delta: float):
	var movement_input = controller.get_horizontal_input()
	velocity.x = move_toward(velocity.x, movement_input * speed, acceleration * delta)

func jump():
	if controller.is_jumping_input() and is_on_floor():
		velocity.y = - jump_height

func gravity(delta: float):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

func attack():
	state_manager.freeze_state(PlayerState.State.ATTACK, 0.3)

func _physics_process(delta: float) -> void:
	state_manager.state = get_state()
	movement(delta)
	gravity(delta)
	jump()
	sprite.flip_sprite(controller.get_horizontal_input())
	move_and_slide()
