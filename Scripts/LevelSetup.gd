extends Node2D

func _ready():
	coins(GameManager.mapSize())


func coins(mapSize):
	var tileX = mapSize[0]
	var tileY = mapSize[1]
	var numCoins = randi_range(25, 150)
	print("Spawning ", numCoins, " coins")
	var coin = preload("res://Assets/Coin.tscn")
	for i in numCoins:
		var coinInstance = coin.instantiate()
		add_child(coinInstance)
		coinInstance.position.x = randi_range(0,tileX-1) * 112
		coinInstance.position.y = randi_range(0,tileY-1) * 112
