class_name LocationManager extends Node

var locationDict: Dictionary # dictionary of Locations
var fogDict: Dictionary # dictionary of fog tiles (key = fog id, value = Fog object)
var character_manager: CharacterManager # charactermanager class
var generic_biome_ids: Array = [0, 0, 0] # deadwood, scorch, city
var centers = []

func _init():
	locationDict = {}
	fogDict = {}
	load_locations()
	load_fogs()
	character_manager = Global.charevent_manager
	character_manager.load_characters()
	load_characters_into_locations()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func new_generic_biome(biome) -> Location:
	match(biome):
		"deadwood":
			var id = generic_biome_ids[0]
			generic_biome_ids[0] += 1
			if id < 3:
				return Location.new("deadwood"+str(id), "res://assets/icons/deadwood0.png", ["res://assets/backgrounds/forest.jpg"], "woods", "woods")
			else:
				return Location.new("deadwood"+str(id), "res://assets/icons/deadwood01.png", ["res://assets/backgrounds/forest.jpg"], "woods", "woods")
		"scorch":
			var id = generic_biome_ids[1]
			generic_biome_ids[1] += 1
			return Location.new("Scorch"+str(id), "res://assets/icons/scorch.png", ["res://assets/backgrounds/scorch.png"], "scorch", "scorch")
		"city":
			var id = generic_biome_ids[2]
			generic_biome_ids[2] += 1
			var r = RandomNumberGenerator.new()
			r.randomize();
			var c = r.randi_range(0, 3)
			match(c):
				0:	
					return Location.new("Urban"+str(id), "res://assets/icons/city01.png", ["res://assets/backgrounds/city0.png"], "city", "city")
				1:
					return Location.new("Urban"+str(id), "res://assets/icons/city02.png", ["res://assets/backgrounds/city0.png"], "city", "city")
				2:
					return Location.new("Urban"+str(id), "res://assets/icons/city03.png", ["res://assets/backgrounds/city0.png"], "city", "city")
				3:	
					return Location.new("Urban"+str(id), "res://assets/icons/city01.png", ["res://assets/backgrounds/city0.png"], "city", "city")
	
	return null
	
# Load/Initialize Locations
func load_locations() -> void:
	var city0 = Location.new("Kronus", "res://assets/icons/city_tower.png", ["res://assets/backgrounds/kronus.png", "res://assets/backgrounds/kronusdoor.png", "res://assets/backgrounds/kronus.jpg"], "city0", "city") 
	var city1 = Location.new("Residential District", "res://assets/icons/city1.png", ["res://assets/backgrounds/city1.png", "res://assets/backgrounds/city1.jpg", "res://assets/backgrounds/city4.png"], "city1", "city")
	var city2 = Location.new("Medical District", "res://assets/icons/city2.png", ["res://assets/backgrounds/fountain.png", "res://assets/backgrounds/hospital.jpg", "res://assets/backgrounds/city0.png"],"city3", "city")
	var city3 = Location.new("Terminal", "res://assets/icons/terminal.png", ["res://assets/backgrounds/terminal.jpg", "res://assets/backgrounds/airplaneint.JPG"],"city2", "city")
	var deadwood1 = Location.new("Burbs", "res://assets/icons/deadwood1.png", ["res://assets/backgrounds/deadwood1.png", "res://assets/backgrounds/woodshome.jpg"],"deadwood1", "woods")
	var deadwood2 = Location.new("Camp", "res://assets/icons/deadwood2.png", ["res://assets/backgrounds/camp.jpg", "res://assets/backgrounds/tent.png", "res://assets/backgrounds/forest.jpg"], "deadwood2", "woods")
	var deadwood3 = Location.new("Grid", "res://assets/icons/grid.png", ["res://assets/backgrounds/transformer.png"], "deadwood3", "woods")
	var junkyard = Location.new("Junkyard", "res://assets/icons/junkyard.png", ["res://assets/backgrounds/junkyard.jpg", "res://assets/backgrounds/garage.jpg","res://assets/backgrounds/junkyard.png"],"junk")
	var aircraft = Location.new("Aircraft", "res://assets/icons/desert_aircraft.png", ["res://assets/backgrounds/desert_aircraft.jpg"], "plane")
	var car = Location.new("Car", "res://assets/icons/desert_car.png", ["res://assets/backgrounds/desert_car.jpg"], "car")
	var merchshack = Location.new("Merchant's Shack", "res://assets/icons/merchantshack.png", ["res://assets/backgrounds/merchantshack.png", "res://assets/backgrounds/generalstore.jpg"],"shack")
	var gas = Location.new("gas", "res://assets/icons/gas.png", ["res://assets/backgrounds/gas.png", "res://assets/backgrounds/gasint.jpg", "res://assets/backgrounds/garage.jpg"],"gas")
	var factory = Location.new("factory", "res://assets/icons/factory.png", ["res://assets/backgrounds/factory.png","res://assets/backgrounds/factory2.jpg"],"factory")
	var nuclear = Location.new("nuclear", "res://assets/icons/nuclear.png", ["res://assets/backgrounds/nuclear.jpg", "res://assets/backgrounds/hole.jpg", "res://assets/backgrounds/core.png"],"nuclear", "scorch")
	var scorch = Location.new("Scorched Burbs", "res://assets/icons/scorch1.png", ["res://assets/backgrounds/scorchburb.jpg", "res://assets/backgrounds/scorchhouse.jpg"],"homes", "scorch")
	var base = Location.new("SSA", "res://assets/icons/base.png", ["res://assets/backgrounds/ssa_entrance.jpg", "res://assets/backgrounds/ssa_entrance2.jpg", "res://assets/backgrounds/ssa.jpg", "res://assets/backgrounds/oval.jpg", "res://assets/backgrounds/guns.png"],"ssa")	
	var crater = Location.new("Crater", "res://assets/icons/crater.png", [], 0)
	var remnant = Location.new("Mountain", "res://assets/icons/mountain.png", ["res://assets/backgrounds/cave.jpg", "res://assets/backgrounds/cave.png", "res://assets/backgrounds/remnantdoor.png", "res://assets/backgrounds/remnant.jpg", "res://assets/backgrounds/engineer.jpg"], "cave1")
	var abandon = Location.new("Shelter", "res://assets/icons/vault.png", ["res://assets/backgrounds/abandon.png","res://assets/backgrounds/abandon.jpg", "res://assets/backgrounds/abandon_terminal.jpg"], "abandon")
	var desert = Location.new("Desert", "res://assets/characters/noone.png", ["res://assets/backgrounds/desert.jpg"], "desert")
	
	add_location(city0)
	add_location(new_generic_biome("city"))
	add_location(city1)
	add_location(new_generic_biome("city"))
	add_location(city2)
	add_location(city3)
	add_location(new_generic_biome("city"))
	add_location(deadwood3)
	add_location(new_generic_biome("deadwood"))
	add_location(new_generic_biome("deadwood"))
	add_location(deadwood1)
	add_location(deadwood2)
	add_location(new_generic_biome("deadwood"))
	add_location(new_generic_biome("deadwood"))
	add_location(new_generic_biome("deadwood"))
	add_location(nuclear)
	add_location(new_generic_biome("scorch"))
	add_location(new_generic_biome("scorch"))
	add_location(new_generic_biome("scorch"))
	add_location(scorch)
	add_location(new_generic_biome("scorch"))
	add_location(new_generic_biome("scorch"))
	add_location(new_generic_biome("scorch"))
	add_location(junkyard)
	add_location(aircraft)
	add_location(car)
	#add_location(crater)
	add_location(base)
	add_location(merchshack)
	add_location(factory)
	add_location(gas)
	add_location(remnant)
	add_location(abandon)
	add_location(desert)
	
# Load/initialize Fog tiles
func load_fogs() -> void:
	var fog_id_num = 0
	for row in Global.total_cells.x:
		for col in Global.total_cells.y:
			var fog = Fog.new(fog_id_num, -(Global.map_size.x / 2) + (row * Global.cell_size.x + Global.cell_size.x / 2), -(Global.map_size.y / 2) + (col * Global.cell_size.y + Global.cell_size.y / 2))
			add_fog(fog)
			fog_id_num += 1
# Add Fog object to fogDict
func add_fog(new_fog: Area2D) -> void:
	self.fogDict[new_fog.get_id()] = new_fog
	#print("Successfully added " + new_fog.get_id())

# Load characters into locations
func load_characters_into_locations() -> void:
	move_character_to_location("Doctor", "Medical District", 0)
	move_character_to_location("scrap", "Medical District", 1)
	move_character_to_location("medical", "Medical District", 1)
	move_character_to_location("Loss Prevention", "Medical District", 1)
	move_character_to_location("Junkman", "Junkyard", 0)
	move_character_to_location("scrap", "Junkyard", 1)
	move_character_to_location("scrap", "Junkyard", 1)
	move_character_to_location("Reformed Raider", "Junkyard", 1)
	move_character_to_location("scrap", "Junkyard", 1)
	move_character_to_location("Lone Merchant", "Merchant's Shack")
	move_character_to_location("Gas", "gas", 0)
	move_character_to_location("Mechanic", "gas", 1)
	move_character_to_location("scrap", "Residential District", 0)
	move_character_to_location("scrap", "Residential District", 0)
	move_character_to_location("Mercenary", "Residential District", 0)
	move_character_to_location("Scav (Aggravated)", "Residential District", 0)
	move_character_to_location("scrap", "Residential District", 1)
	move_character_to_location("Survivor", "Residential District", 1)
	move_character_to_location("scrap", "Residential District", 1)
	move_character_to_location("Scav", "Residential District", 1)
	move_character_to_location("scrap", "Terminal", 0)
	move_character_to_location("scrap", "Terminal", 0)
	move_character_to_location("scrap", "Terminal", 0)
	move_character_to_location("Scav (Aggravated)", "Terminal", 0)
	move_character_to_location("ammo", "Terminal", 0)
	move_character_to_location("ammo", "Terminal", 0)
	move_character_to_location("scrap", "Burbs", 0)
	move_character_to_location("ammo", "Burbs", 0)
	move_character_to_location("Guard", "Kronus", 0)
	move_character_to_location("Manager", "Kronus", 0)
	move_character_to_location("Executive", "Kronus", 1)
	move_character_to_location("Mayor", "Camp", 0)
	move_character_to_location("Herbalist", "Camp", 1)
	move_character_to_location("SSA Guard", "SSA", 0)
	move_character_to_location("SSA Guard2", "SSA", 1)
	move_character_to_location("Colonel", "SSA", 2)
	move_character_to_location("SSA Arms", "SSA", 3)
	move_character_to_location("scrap", "Shelter", 0)
	move_character_to_location("tools", "Shelter", 0)
	move_character_to_location("tools", "Shelter", 0)
	move_character_to_location("scrap", "Shelter", 0)
	move_character_to_location("tools", "Shelter", 0)
	move_character_to_location("tools", "Mountain", 0)
	move_character_to_location("scrap", "Mountain", 0)
	move_character_to_location("Deacon", "Mountain", 2)
	move_character_to_location("Bishop", "Mountain", 3)
	move_character_to_location("Terminal", "factory", 0)
	move_character_to_location("scrap", "Scorched Burbs", 0)
	move_character_to_location("Junkyard Worker", "Junkyard", 1)

# add location object to locationDict, randomizes array after insert
# returns false if not added (no duplicates allowed), otherwise true
func add_location(new_location: Area2D) -> void:
	if self.locationDict.has(new_location.get_name()): # a location with the same name exists already
		print("Location \"" + new_location.get_name() + "\" already exists! Check to make sure all location names are unique.")
		return
	self.locationDict[new_location.get_name()] = new_location
	#print("Successfully added Location \"" + new_location.get_name() + "\".")

func get_location(location_name: String) -> Location:
	if self.locationDict.has(location_name):
		return self.locationDict[location_name]
	print("Getting Location \"" + location_name + "\" failed. No such Location exists. Null has been returned.")
	return null

# removes a location from locationDict
# returns true if removed, otherwise false
func remove_location(location_name: String) -> bool:
	if !self.locationDict.erase(location_name): # .erase() returns false if key doesnt exist, otherwise the removal occurs and true is returned
		print("Removing Location \"" + location_name + "\" failed: No Location with that name exists.")
		return false
	print("Successfully removed Location \"" + location_name + "\".")
	return true

# moves a character to a location (character exits/removed from their previous location)
func move_character_to_location(character_name: String, destination_location_name: String = "biome", room: int = -1) -> void:
	var character: CharacterEvent = character_manager.get_character(character_name)
	var destination: Location
	if destination_location_name == "biome": # biome-based character, moves to random location in the biome
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		
		var possible_locations = []
		for location_name in locationDict:
			if locationDict[location_name].locationBiome in character.possible_biomes:
				possible_locations.append(location_name)
				
		destination = locationDict[possible_locations[rng.randi_range(0, possible_locations.size()-1)]]
		print("Scavenger " + destination.get_name())
	else:
		destination = locationDict[destination_location_name]
	
	if character.location != "": # character is already currently at a location
		remove_character_from_location(character_name)
	
	if room == -1:
		destination.add_character(character, destination.locationBackgrounds.size() - 2)
	else:
		destination.add_character(character, room)	
	Global.charevent_manager
	if !character_manager.exists_event(character_name):	
		character.location = destination_location_name
	#print(character.get_name() + "has been added to " + destination.get_name())

# removes a character from their current location
func remove_character_from_location(character_name: String) -> void:
	var character: CharacterEvent = character_manager.get_character(character_name)
	if character.location == "": # character is not at any location currently
		print("Character \"" + character.get_name() + "\" is not in any location.")
		return
	get_location(character.location).remove_character(character)
	print("Character \"" + character.get_name() + "\" is removed")
	character.location = ""

# Unveils a location covered by fog
func unveil_location(location_name: String) -> void:
	# Check if the location name is valid
	if not location_name in self.locationDict.keys():
		print(location_name, " is not a valid location, cannot be unveiled.")
		return
	
	# Go through the fog tiles to find the one that covers the specified location
	for fog_id in self.fogDict:
		var fog = self.fogDict[fog_id]
		var covered_location = fog.location_covered
		if covered_location != null and covered_location.get_name() == location_name: # fog tile covering the location found
			fog.visible = false # remove the fog tile covering the location
			#print(covered_location.get_name(), " unveiled!")
			return # location unveiled, no need to continue looping

# getter for locationDict
func get_dict() -> Dictionary:
	return locationDict

# clears locationDict
func clear_array() -> void:
	locationDict.clear()
	
# returns locationDict size
func location_dict_size() -> int:
	return locationDict.size()
	
	
func assign_random_position(tree : SceneTree, i : Area2D, prevGroup : Array) -> void:
	
			
	var area_overlaps = i.get_overlapping_areas().size()
	var player_overlap = i.get_overlapping_bodies().size()
	var distanceOk = false
	var minDistance = 3
	
	if i.locationBiome == "nobiome":
		minDistance = 3
		
	
	while !distanceOk:
				
		# first assign location with a random position
		var rng = RandomNumberGenerator.new() # random number generator initialized for random location position generation
		rng.randomize() # generates new randomization seed
		i.position.x = rng.randi_range(-(Global.map_size.x / 2 / Global.cell_size.x) + minDistance, (Global.map_size.x / 2 / Global.cell_size.x) - minDistance) * Global.cell_size.x - Global.cell_size.x / 2
		i.position.y = rng.randi_range(-(Global.map_size.y / 2 / Global.cell_size.y) + minDistance, (Global.map_size.y / 2 / Global.cell_size.y) - minDistance) * Global.cell_size.y - Global.cell_size.y / 2
		
		# second check for collisions
		yield(tree, "physics_frame")
		area_overlaps = i.get_overlapping_areas().size()
		player_overlap = i.get_overlapping_bodies().size()
		if (area_overlaps != 0) or (player_overlap != 0):
			 continue
		
		# finally check if too close to other locations placed
		# could potentially add statement here to adjust mininum distance depending on if "biome" or "nobiome"
		
		distanceOk = true
		
		for j in prevGroup:
			if i.position.distance_to(j.position) <= (Global.cell_size.x * 2):
				distanceOk = false
				break;
	#add node to previous group so other locations dont spawn right next to it
	prevGroup.append(i)

func assign_biome_member_position(tree : SceneTree, i : Area2D, center : Area2D, prevGroup: Array) -> void:
	
	var radii = 1;
	var tries = 0;
	var rng = RandomNumberGenerator.new() # random number generator initialized for random location position generation
	rng.randomize() # generates new randomization seed
	
	i.position.x = center.position.x + (rng.randi_range(-radii, radii) * Global.cell_size.x)
	i.position.y = center.position.y + (rng.randi_range(-radii, radii) * Global.cell_size.y)
	
	
			
	var area_overlaps = i.get_overlapping_areas().size()
	var player_overlap = i.get_overlapping_bodies().size()
	var distanceOk = false
	
	while !distanceOk:
				
		# first assign location with a random position from the center of given radii
		i.position.x = center.position.x + (rng.randi_range(-radii, radii) * Global.cell_size.x)
		i.position.y = center.position.y + (rng.randi_range(-radii, radii) * Global.cell_size.y)
		
		# second check for collisions
		yield(tree, "physics_frame")
		area_overlaps = i.get_overlapping_areas().size()
		player_overlap = i.get_overlapping_bodies().size()
		
		# if collides, increase radii
		if (area_overlaps != 0) or (player_overlap != 0):
			tries += 1
			if tries == 3:
				tries = 0
				radii += 1
		else:
			distanceOk = true
	prevGroup.append(i)

# randomizes each location position in the array
func randomize_map_locations(tree : SceneTree, parent : Node2D) -> void:
	
	var ui = parent.get_node("UI")
	var loading_screen = parent.get_node("ShaderLayer/LoadingAnimation")
	loading_screen.visible = true
	loading_screen.play()
	ui.visible = false
	
	yield(tree, "physics_frame") # pause execution for 1 physics frame, needed for collision updates
	
	var prevGroup = [] # tracks previously placed locations, used for minimum distance placement for new locations from other locations
	var prevBiome = null # last location placed's biome
	var prevNode = null # last location placed
	#var locationsFromBiomePlaced = [] # tracks which locations of current biome already placed, used to specify max distance for locations of same biome
	var biomeCenter = null;
	
	# location array iterated through and location position randomized based on
	# 1. map/grid size, image size. Ensures locations placed where fully visible (not out of bounds).
	#    - larger images are not placed at edge cells if they are larger than a cell to prevent image cutoff
	# 2. each location centered in a grid cell, these cells can contain at most 1 location
	# 3. placement ensures location not placed at player spawn position
	# 4. locations of same biome placed near each other, biomes are placed a specified minimum distance from one another
	# Remember here that dictionaries in Godot preserve insertion order
	for location_name in locationDict: # location_name is a key of the location dictionary
		yield(tree, "physics_frame") 
		
		var location = locationDict[location_name] # get the Location object
		if location.locationBiome == "nobiome": # if first location placed or location not in a biome, randomly set pos
			#assign_random_position(tree, location, prevGroup)
			var area_overlaps = location.get_overlapping_areas().size()
			var player_overlap = location.get_overlapping_bodies().size()
			var distanceOk = false
			var minDistance = 3
			
			if location.locationBiome == "nobiome":
				minDistance = 3
				
			
			while !distanceOk:
						
				# first assign location with a random position
				var rng = RandomNumberGenerator.new() # random number generator initialized for random location position generation
				rng.randomize() # generates new randomization seed
				location.position.x = rng.randi_range(-(Global.map_size.x / 2 / Global.cell_size.x) + minDistance, (Global.map_size.x / 2 / Global.cell_size.x) - minDistance) * Global.cell_size.x - Global.cell_size.x / 2
				location.position.y = rng.randi_range(-(Global.map_size.y / 2 / Global.cell_size.y) + minDistance, (Global.map_size.y / 2 / Global.cell_size.y) - minDistance) * Global.cell_size.y - Global.cell_size.y / 2
				
				# second check for collisions
				yield(tree, "physics_frame")
				area_overlaps = location.get_overlapping_areas().size()
				player_overlap = location.get_overlapping_bodies().size()
				if (area_overlaps != 0) or (player_overlap != 0):
					 continue
				
				# finally check if too close to other locations placed
				# could potentially add statement here to adjust mininum distance depending on if "biome" or "nobiome"
				
				distanceOk = true
				
				for j in prevGroup:
					if location.position.distance_to(j.position) <= (Global.cell_size.x * 2):
						distanceOk = false
						break;
			#add node to previous group so other locations dont spawn right next to it
			prevGroup.append(location)
			location.z_index = location.position.y
			
				
		elif location.locationBiome != prevBiome: # when new biome location placed for first time, set first location as "seed" (center), random pos
			biomeCenter = location
			centers.append(location_name)
			prevBiome = location.locationBiome
			#assign_random_position(tree, location, prevGroup)		
			var area_overlaps = location.get_overlapping_areas().size()
			var player_overlap = location.get_overlapping_bodies().size()
			var distanceOk = false
			var minDistance = 3
			
			if location.locationBiome == "nobiome":
				minDistance = 3
				
			
			while !distanceOk:
						
				# first assign location with a random position
				var rng = RandomNumberGenerator.new() # random number generator initialized for random location position generation
				rng.randomize() # generates new randomization seed
				location.position.x = rng.randi_range(-(Global.map_size.x / 2 / Global.cell_size.x) + minDistance, (Global.map_size.x / 2 / Global.cell_size.x) - minDistance) * Global.cell_size.x - Global.cell_size.x / 2
				location.position.y = rng.randi_range(-(Global.map_size.y / 2 / Global.cell_size.y) + minDistance, (Global.map_size.y / 2 / Global.cell_size.y) - minDistance) * Global.cell_size.y - Global.cell_size.y / 2
				
				# second check for collisions
				yield(tree, "physics_frame")
				area_overlaps = location.get_overlapping_areas().size()
				player_overlap = location.get_overlapping_bodies().size()
				if (area_overlaps != 0) or (player_overlap != 0):
					 continue
				
				# finally check if too close to other locations placed
				# could potentially add statement here to adjust mininum distance depending on if "biome" or "nobiome"
				
				distanceOk = true
				
				for j in prevGroup:
					if location.position.distance_to(j.position) <= (Global.cell_size.x * 2):
						distanceOk = false
						break;
			#add node to previous group so other locations dont spawn right next to it
			prevGroup.append(location)
			location.z_index = location.position.y
			
						
		else: # location placed within same biome, it is placed around the center.
			#assign_biome_member_position(tree, location, biomeCenter, prevGroup)
			var radii = 1;
			var tries = 0;
			var rng = RandomNumberGenerator.new() # random number generator initialized for random location position generation
			rng.randomize() # generates new randomization seed
			
			location.position.x = biomeCenter.position.x + (rng.randi_range(-radii, radii) * Global.cell_size.x)
			location.position.y = biomeCenter.position.y + (rng.randi_range(-radii, radii) * Global.cell_size.y)
			
			
					
			var area_overlaps = location.get_overlapping_areas().size()
			var player_overlap = location.get_overlapping_bodies().size()
			var distanceOk = false
			
			while !distanceOk:
						
				# first assign location with a random position from the center of given radii
				location.position.x = biomeCenter.position.x + (rng.randi_range(-radii, radii) * Global.cell_size.x)
				location.position.y = biomeCenter.position.y + (rng.randi_range(-radii, radii) * Global.cell_size.y)
				
				# second check for collisions
				yield(tree, "physics_frame")
				area_overlaps = location.get_overlapping_areas().size()
				player_overlap = location.get_overlapping_bodies().size()
				
				# if collides, increase radii
				if (area_overlaps != 0) or (player_overlap != 0):
					tries += 1
					if tries == 3:
						tries = 0
						radii += 1
				else:
					distanceOk = true
			prevGroup.append(location)
			location.z_index = location.position.y - 1
			
			
		yield(tree, "physics_frame")
		prevBiome = location.locationBiome
		
		
	yield(tree, "physics_frame")
	#yield(tree.create_timer(0.3), "timeout") # custom loading screen display adjustment, uncomment and modify if necessary
	
	for location_name in locationDict:
		var location = locationDict[location_name]
		if centers.has(location_name):
			#location.z_index = location.position.y
			if location.z_index != location.position.y:
				print("Error: location: ", location.position.y, " z-index: ", location.z_index)
		elif location.locationBiome == "nobiome":
			#location.z_index = location.position.y
			if location.z_index != location.position.y:
				print("Error: location: ", location.position.y, " z-index: ", location.z_index)
		else:
			#location.z_index = location.position.y - 1
			if location.z_index != location.position.y - 1:
				print("Error: location: ", location.position.y, " z-index: ", location.z_index)
		
	
	# loading screen no longer needed as all loading complete, removed from scene and memory freed
	#yield(tree.create_timer(0.3), "timeout") # custom loading screen display adjustment, uncomment and modify if necessary
	for fog_id in self.fogDict: # fog_id is a key of the fog dictionary
		var fog = self.fogDict[fog_id] # get the fog object
		parent.add_child(fog)
		#yield(tree, "idle_frame") # hopefully not needed, causes loading screen to be ~20 seconds
	# yield for 2 frames to allow fog signals to trigger (hopefully guaranteed to work every time)
	yield(tree, "idle_frame")
	yield(tree, "idle_frame")
	
	Global.current_location = Global.location_manager.get_location("Desert")
	loading_screen.visible = false
	loading_screen.stop()
	ui.visible = true
	Global.done_randomizing_locations = true

func save_location_nodes() -> void:
	var node
	# Save locations
	for location_name in locationDict: # location_name is a key of the location dictionary
		var location = locationDict[location_name]
		node = location.get_parent()
		node.remove_child(location)
	# Save fogs
	for fog_id in fogDict: # fog_id is a key of the fog dictionary
		var fog = fogDict[fog_id]
		node = fog.get_parent()
		node.remove_child(fog)
	node.remove_child(Global.player)
	
