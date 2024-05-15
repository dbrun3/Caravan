class_name Fog # This class represents one individual fog tile that takes up a single cell
extends Area2D

# Member variables
var id: String # an assigned ID given to the fog (just for identification purposes)
var location_covered: Location # the location that the fog tile covers (if any, if none then null)

# Constructor
func _init(id_num, xpos, ypos):  # x, y position of each tile passed in
	self.id = "fog" + str(id_num)
	
	# Set fog tile's position and z-index
	self.position.x = xpos
	self.position.y = ypos
	self.z_index = 4094 # Right below grid lines but above everything else
	
	# Set the collision box for the fog tile
	var collision_rect = CollisionShape2D.new()
	var collision_shape = RectangleShape2D.new()
	collision_shape.set_extents(Vector2(Global.cell_size.x/2 - 1, Global.cell_size.y/2 - 1))
	collision_rect.set_shape(collision_shape)
	self.add_child(collision_rect)
	# 1 = location, 2 = player, 3 = fog
	self.set_collision_mask_bit(1, true)
	self.set_collision_layer_bit(1, false)
	self.set_collision_mask_bit(2, true)
	self.set_collision_layer_bit(2, false)
	self.set_collision_mask_bit(3, false)
	self.set_collision_layer_bit(3, true)
	self.set_collision_mask_bit(4, true)
	
	# Create the fog tile
	self.generate_fog_tile()
	
	# Initially sets its location covered to null
	self.location_covered = null
	
	# Bind the signal handlers for when collisions are detected
	self.connect("body_entered", self, "_on_player_entered") # bind the body_entered signal of Area2D to the _on_player_entered handler function
	self.connect("area_entered", self, "_on_location_covered") # bind the area_entered signal of Area2D to the _on_location_covered handler function

# Fog ID getter
func get_id():
	return self.id

# Generate the fog tile's sprite (gray 256x256 image)
func generate_fog_tile():
	var fog_tile = Sprite.new()
	fog_tile.set_texture(load("res://assets/fog/fog.png"))
	#fog_tile.get_texture().get_data().resize(Global.cell_size.x, Global.cell_size.y) #not needed unless cell size gets changed for some reason
	self.add_child(fog_tile)

# Function called when player enters the fog tile
func _on_player_entered(_body): # _body is the Player object
	print("Player entered fog!")
	self.visible = false
	
# Function called when a location is covered by a fog tile
func _on_location_covered(_area): # _area is the Location object that triggered the signal
	self.location_covered = _area
	if (location_covered):
		print("Location ", self.location_covered.get_name()," is covered by this fog!")
		# Unveil Aircraft location at the start of the game
		if (location_covered.get_name() == "Aircraft"):
			self.visible = false
			print("Unveiling ", self.location_covered.get_name())
		self.disconnect("area_entered", self, "_on_location_covered")
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	# Process method of detecting collision not needed atm (we are using signals) but left here just in case
	#var b = get_overlapping_bodies()
	#if b.size() > 0:
		#self.visible = false
