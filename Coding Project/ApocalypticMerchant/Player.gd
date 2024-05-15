class_name Player extends KinematicBody2D

# Custom signals
signal send_idle(idleBool)
signal send_move(canMove)
signal send_first(firstMarkerMove)
signal send_needs_repair(needsRepair)

const fog_collision_shape_radius = 512 # modify this to change circle collision shape radius
var random_stop_distance
var stop_player_randomly
var needs_repair = false

# UI Variables
var UIViewportSize
var UIClickPosition
var marker_max_x
var marker_min_x
var marker_max_y
var marker_min_y

# Player Capacities
var max_weight_capacity: float = 100 # the maximum weight a player can carry in kg
var max_gas_capacity: float = 10000 # the maximum amount of gas a player can hold
var max_speed: int = 300 # the maximum speed a player can move
var max_durability: int = 100 # the maximum durability of the caravan
var max_health: int = 3 # the maximum health count for the player

# Player Attributes
export var speed: int = max_speed # the player's speed
var weight: float # the player's weight in kg (dependent on player's inventory)
var velocity = Vector2(0, 0) # the player's velocity
var inventory: Array # the player's inventory of items
var money: int # the amount of money player has
var gas: float # the amount of gas player has (the rate at which gas decreases dependent on weight)
var combatSkill: int # the combat skill rating of the player (used during combat events)
var health: int # the player's health
var durability: int # the caravan's durability

# Member Variables
var clickPosition = Vector2(0, 0) 
var iconScale: Vector2
var image_size
var idle: bool = true
var moveMarker
var shouldMove = false
var canClick = true
var movingAnimationNode
var gasAnimationNode
var hasTraded = false
var firstMarkerMove = false

# Quest Completion
var hasPasskey = false
var deadwoodFound = false
var remnantFound = false
var ssaAlly = false
var kronusAlly = false
var deadwoodPowered = false
var kronusPowered = false
var playerHasCore = false
var uss = false

# Constructor
func _init(nWeight = 0, nSpeed = max_speed, nMoney = 5000, nGas = max_gas_capacity, nSkill = 20):
	self.weight = nWeight
	self.speed = nSpeed
	self.inventory = []
	self.money = nMoney
	self.gas = nGas
	self.combatSkill = nSkill
	self.iconScale = Vector2(20, 20)
	self.health = self.max_health
	self.durability = self.max_durability
	self.add_child_nodes()
	
# Functions
# Getters/Setters
func get_weight() -> float:
	return self.weight

func get_max_weight() -> float:
	return self.max_weight_capacity

func set_weight(nWeight: float):
	self.weight = nWeight

#
# add_weight
#
# weightToAdd: float -> the amount of weight to add to player
# Returns true if successful, false if not
#
func add_weight(weightToAdd: float) -> bool:
	if check_add_weight(weightToAdd):
		self.weight += weightToAdd
		print("WEIGHT: Successfully added " + str(weightToAdd))
		return true
	else:
		print("WEIGHT: Adding " + str(weightToAdd) + " would go over capacity")
		return false

#
# remove_weight
#
# weightToRemove: float -> the amount of weight to remove from player
# Returns true if successful, false if not
#
func remove_weight(weightToRemove: float) -> bool:
	if check_remove_weight(weightToRemove):
		self.weight -= weightToRemove
		print("WEIGHT: Successfully removed " + str(weightToRemove))
		return true
	else:
		print("WEIGHT: Removing " + str(weightToRemove) + " would go under zero")
		return false

#
# check_add_weight
#
# theoreticalWeight: float -> the amount of weight to check to be added
# returns true if the resulting amount is max_weight_capacity or below, false if not
#
func check_add_weight(theoreticalWeight: float) -> bool:
	if (self.weight + theoreticalWeight) <= max_weight_capacity:
		return true
	else:
		return false

#
# check_remove_weight
#
# theoreticalWeight: float -> the amount of weight to check to be removed
# returns true if the resulting amount is 0 or above, false if not
#
func check_remove_weight(theoreticalWeight: float) -> bool:
	if (self.weight - theoreticalWeight) >= 0:
		return true
	else:
		return false

func get_speed() -> int:
	return self.speed

func set_speed(nSpeed):
	self.speed = nSpeed

func get_max_speed() -> int:
	return self.max_speed

func get_inventory() -> Array:
	return self.inventory

func set_inventory(iArray):
	self.inventory = iArray
	var newWeight: float
	for i in iArray:
		newWeight += i.get_weight()
	self.weight = newWeight

func get_money() -> int:
	return self.money

func set_money(nMoney):
	self.money = nMoney

func get_gas() -> float:
	return self.gas

func set_gas(nGas):
	self.gas = nGas

func get_max_gas() -> float:
	return self.max_gas_capacity

#
# add_gas
#
# gasToBeAdded: float -> the amount of gas to add to player
# Returns true if successful, false if not
#
func add_gas(gasToBeAdded: float) -> bool:
	if check_add_gas(gasToBeAdded):
		self.gas += gasToBeAdded
		print("GAS: Added " + str(gasToBeAdded) + " units of gas")
		return true
	else:
		print("GAS: Not enough space for " + str(gasToBeAdded) + " units of gas")
		return false

#
# remove_gas
#
# Removes gas from the player based on the distance from the marker
# Also factors in inventory weight
# Returns true if successful, false if not
#
func remove_gas() -> bool:
	if !self.idle:
		var gasToBeRemoved: float
		gasToBeRemoved = float(speed / 100)
		# weight portion
		if self.weight > 0:
			gasToBeRemoved = gasToBeRemoved + (gasToBeRemoved * (self.weight / self.max_weight_capacity))
		if check_remove_gas(gasToBeRemoved):
			self.gas -= gasToBeRemoved
			#print("GAS: Used " + str(gasToBeRemoved) + " units")
		else:
			player_idle()
			if !Global.player.has_item("Gas"):	
				Global.ending = 5
				Global.goto_scene("res://Ending.tscn")
			return false
		return true
	return false

#
# check_remove_gas
#
# theoreticalGas: float -> the amount of gas to check to be removed
# returns true if the resulting amount is 0 or above, false if not
#
func check_remove_gas(theoreticalGas: float) -> bool:
	if (self.gas - theoreticalGas) >= 0:
		return true
	else:
		return false

#
# check_add_gas
#
# theoreticalGas: float -> the amount of gas to check to be added
# returns true if the resulting amount is max_gas_capacity or below, false if not
#
func check_add_gas(theoreticalGas: float) -> bool:
	if (self.gas + theoreticalGas) <= self.max_gas_capacity:
		return true
	else:
		return false

func get_skill() -> int:
	return self.combatSkill

func set_skill(nSkill):
	self.combatSkill = nSkill

func get_health() -> int:
	return self.health	

func get_max_health() -> int:
	return self.max_health

func get_durability() -> int:
	return self.durability

func get_max_durability() -> int:
	return self.max_durability

func remove_durability() -> bool:
	if self.durability <= 0:
		return false
	self.durability -= ((self.weight / self.max_weight_capacity) * 5) + 1
	return true

func get_idle():
	return self.idle

func set_move(shouldMoveParam):
	shouldMove = shouldMoveParam

func get_move() -> bool:
	return self.shouldMove

func get_first_marker_move() -> bool:
	return self.firstMarkerMove

func set_click(newClick):
	canClick = newClick

func add_inventory_item(item):
	self.inventory.append(item)
	add_weight(item.get_weight())

func remove_inventory_item(item):
	self.inventory.erase(item)
	remove_weight(item.get_weight())

func has_item(item_name):
	for item in inventory:
		if item.get_name() == item_name:
			return true
	return false
	
func has_type(item_type):
	for item in inventory:
		if item.get_type() == item_type:
			return true
	return false

func remove_item(item_name):
	for item in inventory:
		if item.get_name() == item_name:
			remove_inventory_item(item)
			return
#
# is_click_inbounds()
#
# Checks if the player clicked inside the usable screen space on the left side in navigation
# Returns true if yes, false if not
#
func is_click_inbounds() -> bool:
	return UIClickPosition.y < marker_max_y and UIClickPosition.x < marker_max_x and UIClickPosition.y >= marker_min_y and UIClickPosition.x >= marker_min_x

#
# player_idle()
#
# Mostly for the _physics_process(_delta) function but allows for setting the player's
# status outside of that function.
#
func player_idle():
	# Set player to idle
	movingAnimationNode.visible = false
	movingAnimationNode.stop()
	#gasAnimationNode.stop()
	movingAnimationNode.set_frame(0)
	idle = true
	shouldMove = false
	emit_signal("send_idle", idle)

#
# player_idle_repair()
#
# Mostly for the _physics_process(_delta) function but allows for setting the player's
# status outside of that function.
#
func player_idle_repair():
	# Set player to idle
	print("hello")
	movingAnimationNode.visible = false
	movingAnimationNode.stop()
	#gasAnimationNode.stop()
	movingAnimationNode.set_frame(0)
	idle = true
	shouldMove = false
	needs_repair = true
	emit_signal("send_idle", idle)
	emit_signal("send_needs_repair", needs_repair)

#
# player_not_idle()
#
# Mostly for the _physics_process(_delta) function but allows for setting the player's
# status outside of that function.
#
func player_not_idle(tPParam, speedParam):
	# Move the player
	idle = false
	emit_signal("send_idle", idle)
	move_and_slide(tPParam * speedParam)
	movingAnimationNode.visible = true
	movingAnimationNode.play()
	#gasAnimationNode.play()
	look_at(moveMarker.position)
	remove_gas()

#
# move_marker_position()
#
# Mostly for the _physics_process(_delta) function but allows for setting the move
# marker's position based on a player's click and the UI click position
#
func move_marker_position(click, UIClick):
	# Sets the marker position to the mouse
	moveMarker.position = clickPosition + Vector2(0, -25)
	moveMarker.z_index = 4096
	firstMarkerMove = true
	emit_signal("send_first", true)
	stop_player_randomly = should_stop()
	print(stop_player_randomly)
	generate_random_stop_distance()
	emit_signal("send_move", true)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets the click position to mouse position
	clickPosition = Vector2(position.x, position.y)
	self.z_index = 4096
	# Sets the size of the UI screen viewport
	UIViewportSize = get_tree().get_root().get_node("Navigation/UI").get_viewport().size
	# Sets the usable screensize for the marker

	marker_max_x = 832
	marker_min_x = 76.8
	marker_max_y = 540
	marker_min_y = 64.8

	#marker_max_x = UIViewportSize.x * 0.65
	#marker_min_x = UIViewportSize.x * 0.06
	#marker_max_y = UIViewportSize.y * 0.75
	#marker_min_y = UIViewportSize.y * 0.09
	print("X: " + str(marker_max_x))
	print("x: " + str(marker_min_x))
	print("Y: " + str(marker_max_y))
	print("y: " + str(marker_min_y))

func _physics_process(_delta):
	if Global.done_randomizing_locations == true:
		# Checks if left click was pressed
		if Input.is_action_just_pressed("left_click"):
			# Gets mouse position coordinates for map movement
			clickPosition = get_global_mouse_position()
			# Gets mouse position coordinates for UI clicking
			UIClickPosition = get_tree().get_root().get_node("Navigation/UI").get_viewport().get_mouse_position()
			# Checks if the player can click, if their mouse is above the bottom 25% of the screen, and if the player is idle
			if canClick == true and is_click_inbounds() and idle == true:
				move_marker_position(clickPosition, UIClickPosition)

		# Calculates the target position
		var targetPosition = (moveMarker.position - position).normalized()
		
		# Speed is affected by inventory weight
		# MAX_SPEED - ((WEIGHT_PERCENT) * (90% OF MAX_SPEED))
		self.speed = self.max_speed - floor((self.weight / self.max_weight_capacity) * (0.9 * max_speed))
		
		if shouldMove == true:
			if stop_player_randomly == false:
				# Check if the player is in a 3px range of the click position, i  f not move to the target position
				# Also checks if the player should start moving
				if position.distance_to(moveMarker.position) > 3 && shouldMove == true:
					player_not_idle(targetPosition, speed)
				else:
					player_idle()
			else:
				if random_stop_distance != null:
					if position.distance_to(moveMarker.position) > random_stop_distance && shouldMove == true:
						player_not_idle(targetPosition, speed)
					else:
						player_idle_repair()
		

# generates distance from move marker to stop at
func generate_random_stop_distance():
	var rng_seed = RandomNumberGenerator.new()
	print(position.distance_to(moveMarker.position))
	random_stop_distance = position.distance_to(moveMarker.position) * randf()
	print(random_stop_distance)

# based on durability, randomly decides whether player should stop during their trip
func should_stop():
	var stop_chance = (100.0 - durability) / 100.0
	print(stop_chance)
	var rng_seed = RandomNumberGenerator.new()
	var rng = randf()
	if rng <= stop_chance:
		return true
	return false
		

func add_child_nodes():
	var mesh = MeshInstance2D.new()
	var player_collision_shape = CollisionShape2D.new()
	self.add_child(mesh)
	self.add_child(player_collision_shape)
	mesh.mesh = QuadMesh.new()
	mesh.texture = ResourceLoader.load("res://assets/player/testCaravan.png")
	mesh.scale = self.iconScale
	self.image_size = Vector2(mesh.texture.get_width(), mesh.texture.get_height()) * mesh.scale
	mesh.rotation_degrees = -90
	var collision_extents = Vector2(0.5, 0.5)
	player_collision_shape.shape = RectangleShape2D.new()
	player_collision_shape.shape.extents = collision_extents
	
	# create area2d along with circle collision shape for fog specific hit detection
	var area = Area2D.new()
	var player_fog_collision_shape = CollisionShape2D.new()
	player_fog_collision_shape.shape = CircleShape2D.new()
	player_fog_collision_shape.shape.radius = fog_collision_shape_radius
	
	area.add_child(player_fog_collision_shape)
	self.add_child(area)
	area.connect("area_entered", self, "_on_fog_entered")
	
	# 1 = location, 2 = player, 3 = fog
	area.set_collision_layer_bit(1, false) 
	area.set_collision_mask_bit(1, false)
	area.set_collision_layer_bit(2, false)
	area.set_collision_mask_bit(2, false)
	area.set_collision_layer_bit(3, false)
	area.set_collision_mask_bit(3, false)
	area.set_collision_layer_bit(4, false)
	
	# 1 = location, 2 = player, 3 = fog
	self.set_collision_layer_bit(1, false) 
	self.set_collision_mask_bit(1, true)
	self.set_collision_layer_bit(2, true)
	self.set_collision_mask_bit(2, false)
	self.set_collision_layer_bit(3, false)
	self.set_collision_mask_bit(3, true)
	#self.collision_layer = 2
	#self.collision_mask = 2
	

# checks if area entered is of type Fog, if so, disables it
func _on_fog_entered(_area):
	if _area is Fog:
		_area.visible = false
