extends RigidBody2D

# Variables for movement
var max_speed = 350
var acceleration = 200
var deceleration = 150
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var change_direction_timer = 0

# Player detection
var player = null
var detection_radius = 2500
var attack_radius = 500
var stop_distance = 360  # Distance at which the enemy stops moving towards the player

func _ready():
	randomize()
	# Get the player node
	player = get_parent().get_node("Player")

func _process(delta):
	if player:
		var distance_to_player = position.distance_to(player.position)
		if distance_to_player < attack_radius:
			attack_player(delta)
		elif distance_to_player < detection_radius:
			follow_player(delta)
		else:
			# Change direction at random intervals
			change_direction_timer -= delta
			if change_direction_timer <= 0:
				change_direction()
			
			# Move the enemy
			move_enemy(delta)

func change_direction():
	# Pick a random direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	# Set a random time for the next direction change
	change_direction_timer = randf_range(1, 3)

func follow_player(delta):
	# Move towards the player
	direction = (player.position - position).normalized()
	move_enemy(delta)

func move_enemy(delta):
	# Accelerate towards the target direction
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		# Decelerate to a stop
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	# Clamp the velocity to the maximum speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	# Apply the velocity to the RigidBody2D
	linear_velocity = velocity

func attack_player(delta):
	var distance_to_player = position.distance_to(player.position)
	if distance_to_player > stop_distance:
		# Move towards the player but slow down significantly
		direction = (player.position - position).normalized()
		velocity = velocity.move_toward(direction * (max_speed * 0.1), acceleration * delta)
	else:
		# Stop moving when within the stop distance
		velocity = Vector2.ZERO
	
	# Apply the velocity to the RigidBody2D
	linear_velocity = velocity
	
	# Print a message when attacking
	print("Attacking player!")
