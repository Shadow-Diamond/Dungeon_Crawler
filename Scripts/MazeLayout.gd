# MazeLayout.gd
extends Node2D

class_name MazeLayout

const WIDTH_DEFAULT = 20
const HEIGHT_DEFAULT = 20
const PADDING_DEFAULT = 1

var m_width: int
var m_height: int
var m_padding: int
var m_entrance: Vector2i
var m_exit: Vector2i

# 2D array to store the layout of the maze (0 = empty, 1 = wall, 2 = start, 3 = end)
var tile_layout = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	m_width = WIDTH_DEFAULT
	m_height = HEIGHT_DEFAULT
	m_padding = PADDING_DEFAULT
	m_entrance = Vector2i(0, 0)
	m_exit = Vector2i(0, 0)

	generate_layout()
	print_layout()

enum TileType {
	FLOOR = 0,
	WALL = 1,
	START = 2,
	END = 3
}

enum Direction {
	NORTH = 0,
	EAST = 1,
	SOUTH = 2,
	WEST = 3
}

func generate_layout(width: int = WIDTH_DEFAULT, height: int = HEIGHT_DEFAULT, rseed: int = -1, padding: int = 1, entrance_direction = Direction.WEST, exit_direction = Direction.EAST) -> void:
	var path_found = false

	# Set up the random number generator
	var rng = RandomNumberGenerator.new()
	if rseed != -1:
		rng.seed = rseed

	m_width = width
	m_height = height
	m_padding = padding

	while not path_found:
		# Create a new layout
		tile_layout = []
		if (width <= 0):
			width = WIDTH_DEFAULT
		if (height <= 0):
			height = HEIGHT_DEFAULT
		
		# Initialize the layout with walls
		for x in range(width):
			var row = []
			for y in range(height):
				row.append(TileType.WALL)
			tile_layout.append(row)
		
		var min_x = padding
		var max_x = width - padding - 1
		var min_y = padding
		var max_y = height - padding - 1

		# Randomly fill the layout with floors
		for x in range(min_x, max_x):
			for y in range(min_y, max_y):
				if rng.randf() < 0.5:
					tile_layout[x][y] = TileType.FLOOR
		
		# Set the entrance and exit
		if entrance_direction == Direction.NORTH:
			m_entrance = Vector2i(rng.randi_range(min_x, max_x), min_y)
			tile_layout[m_entrance.x][m_entrance.y] = TileType.START
		elif entrance_direction == Direction.EAST:
			m_entrance = Vector2i(max_x, rng.randi_range(min_y, max_y))
			tile_layout[m_entrance.x][m_entrance.y] = TileType.START
		elif entrance_direction == Direction.SOUTH:
			m_entrance = Vector2i(rng.randi_range(min_x, max_x), max_y)
			tile_layout[m_entrance.x][m_entrance.y] = TileType.START
		elif entrance_direction == Direction.WEST:
			m_entrance = Vector2i(min_x, rng.randi_range(min_y, max_y))
			tile_layout[m_entrance.x][m_entrance.y] = TileType.START
		
		if exit_direction == Direction.NORTH:
			m_exit = Vector2i(rng.randi_range(min_x, max_x), min_y)
			tile_layout[m_exit.x][m_exit.y] = TileType.END
		elif exit_direction == Direction.EAST:
			m_exit = Vector2i(max_x, rng.randi_range(min_y, max_y))
			tile_layout[m_exit.x][m_exit.y] = TileType.END
		elif exit_direction == Direction.SOUTH:
			m_exit = Vector2i(rng.randi_range(min_x, max_x), max_y)
			tile_layout[m_exit.x][m_exit.y] = TileType.END
		elif exit_direction == Direction.WEST:
			m_exit = Vector2i(min_x, rng.randi_range(min_y, max_y))
			tile_layout[m_exit.x][m_exit.y] = TileType.END
		
		# Make sure valid paths exist from entrance to exit
		path_found = is_valid_path(m_entrance, m_exit)

		if not path_found:
			rseed += 1
			rng.seed = rseed
	

func is_valid_path(start: Vector2i, end: Vector2i) -> bool:
	var width = m_width
	var height = m_height

	# Create a 2D array to keep track of visited positions
	var visited = []
	for x in range(width):
		var row = []
		for y in range(height):
			row.append(false)
		visited.append(row)

	# Queue for BFS
	var queue = []
	queue.append(start)
	visited[start.x][start.y] = true

	# Possible movements: up, right, down, left
	var directions = [
		Vector2i(0, -1),  # Up
		Vector2i(1, 0),   # Right
		Vector2i(0, 1),   # Down
		Vector2i(-1, 0)   # Left
	]

	while queue.size() > 0:
		var current = queue.pop_front()

		# Check if we've reached the end
		if current == end:
				return true

		for dir in directions:
			var neighbor = current + dir

			# Check bounds
			if neighbor.x >= 0 and neighbor.x < width and neighbor.y >= 0 and neighbor.y < height:
				# Avoid walls and already visited tiles
				if not visited[neighbor.x][neighbor.y]:
					var tile = tile_layout[neighbor.x][neighbor.y]
					if tile == TileType.FLOOR or tile == TileType.END:
						visited[neighbor.x][neighbor.y] = true
						queue.append(neighbor)

	# No path found
	return false


func print_layout() -> void:
	for y in range(m_height):
		var row_str = ""
		for x in range(m_width):
			var tile = tile_layout[x][y]
			if tile == TileType.WALL:
				row_str += "#"
			elif tile == TileType.FLOOR:
				row_str += "."
			elif tile == TileType.START:
				row_str += "S"
			elif tile == TileType.END:
				row_str += "E"
		print(row_str)
