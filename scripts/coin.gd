extends Area2D

func _ready() -> void:
	body_entered.connect(collect_coin)

func collect_coin(_body: Node2D):
	GameManager.coins += 1
	queue_free()