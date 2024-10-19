extends Node2D

func _ready():
	var numCoins = randi_range(25, 150)
	var coin = preload("res://Assets/Coin.tscn")
	for i in numCoins:
		var coinInstance = coin.instantiate()
		add_child(coinInstance)
		coinInstance.position.x = randi_range(0,19) * 112
		coinInstance.position.y = randi_range(0,19) * 112
