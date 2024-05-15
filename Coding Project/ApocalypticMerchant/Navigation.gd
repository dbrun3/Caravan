extends Node2D

# Custom signals
signal player_added()

# Called when the node enters the scene tree for the first time.
func _ready():
	var grid = get_node("Grid")
	grid.z_index = 4095
	var map = get_node("Map")
	map.z_index = -4096
	Global.player.moveMarker = get_node("MoveMarker")
	Global.player.movingAnimationNode = get_node("UI/MovingAnimation")
	Global.player.gasAnimationNode = get_node("UI/GasAnimation")
	add_child(Global.player)
	emit_signal("player_added")
	var camera = get_node("RTS-Camera2D")
	camera.position = Global.cameraPosition
	
	var location_dictionary = Global.location_manager.get_dict()
	for location_name in location_dictionary: # location_name is a key of the location dictionary
		var location = location_dictionary[location_name] # get the Location object
		add_child(location)
	
	if Global.done_randomizing_locations == false:
		for location_name in location_dictionary: # location_name is a key of the location dictionary
			var location = location_dictionary[location_name] # get the Location object
			location.add_to_group(location.locationBiome)
		yield(Global.location_manager.randomize_map_locations(get_tree(), self), "completed") # do not progress until the locations have been fully randomized
	else: # re-add fog for subsequent times the navigation scene is loaded (loads after the initial load)
		# Daniel's additions!!!
		var fog_dictionary = Global.location_manager.fogDict
		for fog_id in fog_dictionary: # fog_id is a key of the fog dictionary
			var fog = fog_dictionary[fog_id] # get the fog object
			add_child(fog)
	
	Global.enterLocationButtonPressed = false
	Fade.fade_in(1)
	
func _input(event):
	if Input.is_key_pressed(KEY_G):
		Global.player.add_gas(2000)
		
	if Input.is_key_pressed(KEY_M):
		Global.player.money = Global.player.money + 1000
		
	if Input.is_key_pressed(KEY_D):
		Global.player.durability = Global.player.max_durability
		
	if Input.is_key_pressed(KEY_F):
		var fog_dictionary = Global.location_manager.fogDict
		for fog_id in fog_dictionary: # fog_id is a key of the fog dictionary
			var fog = fog_dictionary[fog_id] # get the fog object
			fog.visible = false
