extends Sprite2D

# Textures for different directions
var texUP
var texDOWN
var texLEFT
var texRIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load textures
	texDOWN = load("res://ship_up.png")
	texUP = load("res://ship_down.png")
	texLEFT = load("res://ship_left.png")
	texRIGHT = load("res://ship_right.png")
	
	# Debugging: Print to confirm textures are loaded
	print("Textures loaded in Sprite")

# Update the sprite based on the direction of movement
func update_sprite(direction):
	if direction.length() == 0:
		return
	
	# Calculate the angle in degrees
	var angle = direction.angle() * 180 / PI
	if angle < 0:
		angle += 360
	
	# Debugging: Print the angle
	print("Angle: ", angle)
	
	# Determine the sprite texture based on the angle
	if angle > 45 and angle < 134:
		texture = texUP
		print("Setting texture to UP")
	elif angle >= 135 and angle < 224:
		texture = texLEFT
		print("Setting texture to LEFT")
	elif angle >= 225 and angle < 314:
		texture = texDOWN
		print("Setting texture to DOWN")
	elif angle >= 315 and angle <= 360:
		texture = texRIGHT
		print("Setting texture to RIGHT")
	elif angle >= 0 and angle <= 44:
		texture = texRIGHT
		print("Setting texture to RIGHT")
