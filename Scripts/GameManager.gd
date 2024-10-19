# Any function that will be related to the tracking of the player's score and does not have priority elsewhere
var score = 0

func collectedCoin():
	score += 1

func getScore():
	return score

func reset():
	score = 0

func loseCoins():
	score -= randi_range(1,5)
