extends Node2D

var target_position = Vector2()
var is_following_mouse = false
var speed = 0  # Current speed of the ship
var max_speed = 1200 # Maximum speed of the ship
var acceleration = 2400  # Acceleration rate
var deceleration = 600  # Deceleration rate
var stop_threshold = 1.0  # Distance to target position to consider the ship stopped

func _ready():
	target_position = position
	print("Ready function called in Node2D")
	print_node_hierarchy()

	# Ensure the Sprite node's position is set to (0, 0) relative to Node2D
	var sprite_node = $Sprite
	if sprite_node:
		sprite_node.position = Vector2.ZERO
	else:
		print("Error: Sprite node not found")

func _process(delta):
	if is_following_mouse:
		target_position = get_global_mouse_position()
		update_sprite_direction(target_position - position)

	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_to(target_position)
	
	# Adjust speed based on acceleration or deceleration
	if is_following_mouse:
		speed = min(speed + acceleration * delta, max_speed)
	else:
		speed = max(speed - deceleration * delta, 0)

	# Gradually reduce speed as the ship approaches the target
	if distance_to_target < stop_threshold:
		speed = 0  # Stop the ship when it is very close to the target

	# Calculate the new position
	var new_position = position + direction * speed * delta

	# Snap the position to the nearest pixel grid
	position = new_position.snapped(Vector2(1, 1))

	# Debugging: Print direction and position
	#print("Direction: ", direction)
	#print("Position: ", position)
	#print("Speed: ", speed)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_following_mouse = true
				target_position = event.position
				print("Mouse pressed, following mouse")
			else:
				is_following_mouse = false
				print("Mouse released, not following mouse")

func update_sprite_direction(direction):
	var sprite_node = $Sprite  # Using the $ shorthand to get the Sprite node
	if sprite_node:
		sprite_node.update_sprite(direction)
	else:
		print("Error: Sprite node not found")

func print_node_hierarchy():
	print("Node hierarchy:")
	for child in get_children():
		print(child.name)
