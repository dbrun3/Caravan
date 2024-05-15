class_name Location
extends Area2D

# Member variables
var locationName : String
var locationIcon : String 
var locationBackgrounds : Array
var locationItems : Array
var dialogID : String
const dialogPath: String = "res://assets/dialogs/locationdialogs.tres"
var characters : Array
var image_size
var iconScale : Vector2
var playerEnterPos
var locationBiome : String
var currentPage
var currentBackground

func _init(name = "unnamed", icon = "noone.png", backgrounds = ["noone.png"], did = "city1", biome = "nobiome", icon_scale = Vector2(1, 1)):
	self.locationName = name
	self.locationIcon = icon
	self.locationBackgrounds = backgrounds
	self.locationItems = []
	self.dialogID = did
	self.characters = []
	for x in range(locationBackgrounds.size()):
		characters.append([])
	self.iconScale = icon_scale
	self.add_child_nodes()
	self.connect("body_entered", self, "_on_player_entered")
	self.connect("body_exited", self, "_on_player_exit")
	self.locationBiome = biome
	currentPage = null
	currentBackground = 0

# Returns location name
func get_name() -> String:
	return locationName

func set_dialog(id: String):
	dialogID = id

# Returns location dialog start OR next page in the dialog
func get_dialog():
	return dialogID	

# Gets loads icon and returns texture
func load_icon() -> Resource:
	return ResourceLoader.load(locationIcon)	
	
	# Gets loads background and returns texture
func load_background(index) -> Resource:
	currentBackground = index
	return ResourceLoader.load(locationBackgrounds[index])	
	
# Load location dialog from tres file
func load_dialog() -> Resource:
	return ResourceLoader.load(dialogPath)

# Function to add a character to the location
func add_character(character: CharacterEvent, room: int) -> void:
	characters[room].append(character)

# Function to remove a character from the location
func remove_character(character: CharacterEvent) -> void:
	for x in range(characters.size() - 1):
		if characters[x].has(character):
			characters[x].erase(character)

# Function to get the list of characters in the location
func get_characters(room) -> Array:
	return characters[room]

func has_item(item_name):
	for item in locationItems:
		if item.get_name() == item_name:
			return true
	return false

func has_type(item_type):
	for item in locationItems:
		if item.get_type() == item_type:
			return true
	return false

func add_child_nodes():
	# 1 = location, 2 = player, 3 = fog
	self.set_collision_layer_bit(1, true)
	self.set_collision_mask_bit(1, true)
	self.set_collision_layer_bit(2, false)
	self.set_collision_mask_bit(2, true)
	self.set_collision_layer_bit(3, false)
	self.set_collision_mask_bit(3, false)
	#self.collision_layer = 2
	#self.collision_mask = 2
	var sprite = Sprite.new() # creates location image sprite node
	self.add_child(sprite) # adds to this Area2D location
	var collisionBox = CollisionShape2D.new() # creates CollisionShape2D node
	self.add_child(collisionBox) # adds CollisionShape2D instance as child node
	sprite.texture = self.load_icon() # assigns sprite node its texture
	sprite.scale = iconScale
	self.image_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height()) * sprite.scale
	
	
	
	var collision_extents = Vector2(image_size.x / 2, image_size.y / 2)
	collisionBox.shape = RectangleShape2D.new()
	collisionBox.shape.extents = collision_extents
	
	var player_area_collision_extents = Vector2(image_size.x / 2, image_size.y / 2)
	if self.image_size.x >= Global.cell_size.x: # if image width greater than cell size, its collision limited to width of its cell
		player_area_collision_extents.x = (Global.cell_size.x / 2) - 2
	if self.image_size.y >= Global.cell_size.y: # if image height greater than cell height, its collision box limited to height of its cell
		player_area_collision_extents.y = (Global.cell_size.y / 2) - 2
	
	collisionBox.shape.extents = player_area_collision_extents

func _on_player_entered(_body):
	if Global.done_randomizing_locations == true:
		Global.current_location = self
		print("current location set to ", Global.current_location.get_name())
	
func _on_player_exit(_body):
	if Global.done_randomizing_locations == true:
		if Global.enterLocationButtonPressed == false:
			Global.current_location = Global.location_manager.get_location("Desert")
			print("current location set to ", Global.current_location.get_name())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore: unused_argument
func _process(_delta):
	if Global.done_randomizing_locations == true:
		var p = self.get_overlapping_bodies()
		if p.size() > 0 and Global.current_location != self:
			Global.current_location = self
			print("current location set to ", Global.current_location.get_name())
				
		
	
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		#print("Clicked location: ", self.get_name())
		#print(self.get_name(), " z-index: ", self.z_index)
		return
