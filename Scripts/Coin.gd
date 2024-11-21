extends Node2D

func _ready():
	set_z_index(50)

func loot():
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		GameManager.collectedCoin()
		queue_free()
