extends Area2D

@onready var sprite = $Sprite
@onready var timer = $Timer

func _ready() -> void:
	body_entered.connect(collect_coin)
	sprite.animation_finished.connect(idle)
	timer.timeout.connect(shine)

func idle():
	sprite.play("default")

func shine():
	sprite.play("shine")

func collect_coin(_body: Node2D):
	GameManager.coins += 1
	queue_free()