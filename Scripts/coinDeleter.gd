extends Area2D

func _process(delta: float) -> void:
	if has_overlapping_areas():
		var overlap = get_overlapping_areas()
		for area in overlap:
			var parent = area.get_parent()
			if parent.has_method("loot"):
				print("Deleted overlap")
				parent.queue_free()
			if parent.has_method("player"):
				GameManager.collectedCoin()
				self.get_parent().queue_free()
