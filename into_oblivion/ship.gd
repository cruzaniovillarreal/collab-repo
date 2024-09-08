
extends Node2D

var target_position = Vector2()
var is_following_mouse = false

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
	
	var direction = (target_position - position).normalized()
	var speed = 100  # Adjust the speed as needed
	position += direction * speed * delta
	
	# Debugging: Print direction and position
	print("Direction: ", direction)
	print("Position: ", position)
	
	# Update the sprite based on the direction
	var sprite_node = $Sprite  # Using the $ shorthand to get the Sprite node
	if sprite_node:
		print("Sprite node found")
		sprite_node.update_sprite(direction)
	else:
		print("Error: Sprite node not found")

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

func print_node_hierarchy():
	print("Node hierarchy:")
	for child in get_children():
		print(child.name)
