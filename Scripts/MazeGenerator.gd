extends Node2D

# Dimensions of the maze (width and height in terms of tiles)
var width = 10
var height = 10

# Reference to the TileMap node
@onready var tilemap = $TwoColoredTileMap

# Tile IDs (assuming 0 is a wall and 1 is a floor)
var TILE_WALL = 0
var TILE_FLOOR = 1

# Directions (for moving north, south, east, west)
var directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]

# Maze grid (2D array initialized with walls)
var maze = []

func _ready():
	# Initialize maze with all walls
	maze.resize(width)
	for x in range(width):
		maze[x] = []
		for y in range(height):
			maze[x].append(TILE_WALL)
	
	# Generate the maze
	generate_maze(Vector2(1, 1))

	# Draw the maze
	draw_maze()

# Recursive depth-first search maze generator
func generate_maze(pos: Vector2):
	maze[pos.x][pos.y] = TILE_FLOOR  # Carve out a floor tile at the current position
	
	var shuffled_directions = directions.duplicate()
	shuffled_directions.shuffle()  # Randomize directions to ensure different maze paths

	for direction in shuffled_directions:
		var new_pos = pos + direction * 2
		
		# Check if the new position is within bounds and surrounded by walls
		if is_in_bounds(new_pos) and maze[new_pos.x][new_pos.y] == TILE_WALL:
			maze[pos.x + direction.x][pos.y + direction.y] = TILE_FLOOR  # Carve passage
			generate_maze(new_pos)  # Recursively generate maze from the new position

# Helper function to check if a position is within the bounds of the maze
func is_in_bounds(pos: Vector2) -> bool:
	return pos.x > 0 and pos.x < width - 1 and pos.y > 0 and pos.y < height - 1

# Function to draw the maze on the TileMap
func draw_maze():
	for x in range(width):
		for y in range(height):
			tilemap.set_cell(0, Vector2i(x, y), maze[x][y])
	for x in range(width):
		var line = ""
		for y in range(height):
			line += str(maze[x][y])
		print(line)
		
