extends Node2D

# Define the size of the grid
var grid_width = 100
var grid_height = 100
# Define the grid
var grid = []

# Define the maximum radiation level
var max_radiation_level = 99

# Define the font for displaying numbers
var font = preload("res://connection_ii/ConnectionII.otf")

# Define the size of each cell (in pixels)
var cell_size = 128

# Define a variable to toggle the visibility of the grid
var show_grid = true

# Define a variable to toggle between square and circular grid
var use_circular_grid = true

func _ready():
	# Initialize the grid with zeros
	for x in range(grid_width):
		grid.append([])
		for y in range(grid_height):
			grid[x].append(0)
	
	# Call the function to generate radiation levels
	generate_radiation_levels()
	
	# Print the grid to the console for debugging
	for row in grid:
		print(row)

# Function to generate radiation levels
func generate_radiation_levels():
	for x in range(grid_width):
		for y in range(grid_height):
			# Generate a random radiation level between 0 and max_radiation_level
			grid[x][y] = randi() % (max_radiation_level + 1)

# Function to visualize the grid (for debugging purposes)
func _draw():
	if show_grid:
		# Calculate the offset to center the grid
		var offset_x = -grid_width * cell_size / 2
		var offset_y = -grid_height * cell_size / 2
		
		for x in range(grid_width):
			for y in range(grid_height):
				if use_circular_grid:
					# Calculate the distance from the center of the grid
					var center_x = grid_width / 2
					var center_y = grid_height / 2
					var distance = sqrt(pow(x - center_x, 2) + pow(y - center_y, 2))
					
					# Skip cells outside the circular grid
					if distance > grid_width / 2:
						continue
				
				var radiation_level = grid[x][y]
				
				# Draw the radiation level as text
				var text_position = Vector2(x * cell_size + cell_size / 2 + offset_x, y * cell_size + cell_size / 2 + offset_y)
				var text = str(radiation_level)
				var text_size = font.get_string_size(text)
				var text_offset = Vector2(text_size.x / 2, -text_size.y / 2)
				draw_string(font, text_position - text_offset, text)
