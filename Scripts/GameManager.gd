extends Node

# Any function that will be related to the tracking of the player's score and does not have priority elsewhere
var score = 0

func collectedCoin():
	score += 1
	print("Gathered Coin. Score is ", score)

func getScore():
	return score

func reset():
	score = 0

func loseCoins():
	print("Oh no, I lost some coins")
	score -= randi_range(1,5)

# Functions that deal with level setup
var level = 1
var size = [20, 20]

func mapSize():
	match level:
		1,2,3,4,5:
			size = [20,20]
		6,7,8,9:
			size = [21,21]
		11,12,13,14,15:
			size = [22,22]
		16,17,18,19:
			size = [23,23]
		21,22,23,24,25:
			size = [24,24]
		26,27,28,29:
			size = [25,25]
		31,32,33,34,35:
			size = [26,26]
		36,37,38,39:
			size = [27,27]
		41,42,43,44,45:
			size = [28,28]
		46,47,48,49:
			size = [29,29]
		51,52,53,54,55:
			size = [30,30]
		56,57,58,59:
			size = [31,31]
		61,62,63,64,65:
			size = [32,32]
		66,67,68,69:
			size = [33,33]
		71,72,73,74,75:
			size = [34,34]
		76,77,78,79:
			size = [35,35]
		81,82,83,84,85:
			size = [36,36]
		86,87,88,89:
			size = [37,37]
		91,92,93,94,95:
			size = [38,38]
		96,97,98,99:
			size = [39,39]
	return size
