extends Node2D

# Maze dimensions (number of tiles)
var width = 20
var height = 15

# Tile size (112 pixels per tile)
var tile_size = 112

# Reference to the TileMap node
@onready var tilemap = $DungeonLayout

# Tile IDs (based on your tile set with walls already included)
var TILE_CROSS_SECTION = 1  # Example: Tile ID for cross-section (+)
var TILE_T_HORIZONTAL_S = 2
var TILE_T_HORIZONTAL_N = 3
var TILE_DEADEND_N = 4
var TILE_T_VERTICAL_W = 5
var TILE_T_VERTICAL_E = 6
var TILE_CORNER_NW = 7
var TILE_HORIZONTAL = 8
var TILE_CORNER_SW = 9
var TILE_CORNER_SE = 10
var TILE_CORNER_NE = 11
var TILE_VERTICAL = 12
var TILE_DEADEND_W = 13
var TILE_DEADEND_S = 14
var TILE_DEADEND_E = 15

# Directions for movement (north, south, west, east)
var directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]

# Maze grid (2D array initialized with walls)
var maze = []

# Random loop count between 5 and 20
var loop_min = 5
var loop_max = 20
var loop_count = 0

func _ready():
	# Initialize maze with all walls
	maze.resize(width)
	for x in range(width):
		maze[x] = []
		for y in range(height):
			maze[x].append(TILE_CROSS_SECTION)  # Fill the maze with cross-section tiles initially
	
	# Generate the maze starting from position (1, 1)
	generate_maze(Vector2(1, 1))

	# Randomize the number of loops to create
	loop_count = randi_range(loop_min, loop_max)
	print("Loop count: ", loop_count)

	# Add loops to the maze to create alternative paths
	create_loops()

	# Draw the maze on the TileMap
	draw_maze()

# Recursive function to generate maze using depth-first search (DFS)
func generate_maze(pos: Vector2):
	# Mark the current position as a floor tile
	maze[pos.x][pos.y] = TILE_HORIZONTAL  # Or use a suitable tile based on your design

	# Shuffle the directions for randomness
	var shuffled_directions = directions.duplicate()
	shuffled_directions.shuffle()

	for direction in shuffled_directions:
		var new_pos = pos + direction * 2
		
		# Check if the new position is within bounds and is a wall
		if is_in_bounds(new_pos) and maze[new_pos.x][new_pos.y] == TILE_CROSS_SECTION:
			# Carve a passage between the current and new position
			maze[pos.x + direction.x][pos.y + direction.y] = TILE_HORIZONTAL  # Or another appropriate tile
			generate_maze(new_pos)  # Recurse into the new position

# Helper function to check if the position is within maze boundaries
func is_in_bounds(pos: Vector2) -> bool:
	return pos.x > 0 and pos.x < width - 1 and pos.y > 0 and pos.y < height - 1

# Function to create loops in the maze (by opening walls randomly)
func create_loops():
	for a in range(loop_count):
		# Randomly choose a position to modify
		var x = randi() % (width - 2) + 1
		var y = randi() % (height - 2) + 1
		
		# Ensure we are not overwriting existing paths
		if maze[x][y] == TILE_CROSS_SECTION:
			maze[x][y] = TILE_HORIZONTAL  # Change this as needed for your loop creation

# Function to draw the maze using the TileMap
func draw_maze():
	for x in range(width):
		for y in range(height):
			# Debugging output to check tile placement
			print("Placing tile at: (", x, ",", y, ") with ID: ", maze[x][y])
			tilemap.set_cell(0, Vector2i(x, y), maze[x][y])
