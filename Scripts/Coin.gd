extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		#GameManager.collectedCoin()
		queue_free()
	if body.has_method("loot"):
		queue_free()

func loot():
	pass
