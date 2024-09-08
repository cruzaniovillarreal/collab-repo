extends Sprite2D

# Dictionary to hold the angle to texture mapping
var angle_to_texture = {}

func _ready():
	# Load all the textures and map them to their respective angles
	for i in range(32):
		var angle = i * 11.25
		var texture_path = "res://sprites/%s.png" % angle
		angle_to_texture[angle] = load(texture_path)

	print("Textures loaded:", angle_to_texture.keys())

func update_sprite(direction):
	var angle = rad_to_deg(direction.angle())
	angle = -angle  # Invert the angle to correct the direction
	angle = fmod(angle + 360.0, 360.0)  # Normalize angle to be between 0 and 360

	var closest_angle = round(angle / 11.25) * 11.25
	if closest_angle == 360.0:
		closest_angle = 0.0  # Wrap around to 0 degrees

	# Debugging: Print direction angle and closest angle
	print("Direction angle:", angle, "Closest angle:", closest_angle)

	# Update the texture only if it has changed
	if texture != angle_to_texture[closest_angle]:
		texture = angle_to_texture[closest_angle]
		print("Texture updated to angle:", closest_angle)
