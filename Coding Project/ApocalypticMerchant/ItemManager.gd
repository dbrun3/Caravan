class_name ItemManager
extends Node

# Member Variables
# Dictionary of items, key: String (name of item), value: Item (the Item object)
var itemDict: Dictionary

# Constructor
func _init():
	self.itemDict = {}

# Load/Initialize Characters
func load_items() -> void:
	#### BOT TEST ASSETS ####
	var redbot = Item.new("redbot", "res://assets/items/bots/bot0.png", 10, 1, "bot", Vector2(1, 1), 0.1)
	var orangebot = Item.new("orangebot", "res://assets/items/bots/bot1.png", 20, 1, "bot", Vector2(1, 1), 0.1)
	var yellowbot = Item.new("yellowbot", "res://assets/items/bots/bot2.png", 30, 1, "bot", Vector2(1, 1), 0.1)
	var lightgreenbot = Item.new("lightgreenbot", "res://assets/items/bots/bot3.png", 40, 1, "bot", Vector2(1, 1), 0.1)
	var greenbot = Item.new("greenbot", "res://assets/items/bots/bot4.png", 50, 1, "bot", Vector2(1, 1), 0.1)
	var lightbluebot = Item.new("lightbluebot", "res://assets/items/bots/bot5.png", 10, 1, "bot", Vector2(1, 1), 0.1)
	var bluebot = Item.new("bluebot", "res://assets/items/bots/bot6.png", 20, 1, "bot", Vector2(1, 1), 0.1)
	var lightpurplebot = Item.new("lightpurplebot", "res://assets/items/bots/bot7.png", 30, 1, "bot", Vector2(1, 1), 0.1)
	var purplebot = Item.new("purplebot", "res://assets/items/bots/bot8.png", 40, 1, "bot", Vector2(1, 1), 0.1)
	var pinkbot = Item.new("pinkbot", "res://assets/items/bots/bot9.png", 50, 1, "bot", Vector2(1, 1), 0.1)
	
	add_item(redbot)
	add_item(orangebot)
	add_item(yellowbot)
	add_item(lightgreenbot)
	add_item(greenbot)
	add_item(lightbluebot)
	add_item(bluebot)
	add_item(lightpurplebot)
	add_item(purplebot)
	add_item(pinkbot)
	##########################
	
	# AMMO
	var item_556ammo = Item.new("5.56", "res://assets/items/5-56.png", 50, 1, "ammo", Vector2(1, 1), 0.2)
	var item_762ammo = Item.new("7.62", "res://assets/items/7-62.png", 70, 1, "ammo", Vector2(1, 1), 0.3)
	var item_9mmammo = Item.new("9mm", "res://assets/items/9mm.png", 40, 1, "ammo", Vector2(1, 1), 0.1)
	var item_akmagazine = Item.new("AK Magazine", "res://assets/items/AK Magazine.png", 150, 1, "ammo", Vector2(1, 1), 3)
	var item_heavyammo = Item.new("Heavy Ammo", "res://assets/items/Heavy Ammo.png", 50, 1, "ammo", Vector2(1, 1), 0.1)
	var item_pistolmagazine = Item.new("Pistol Magazine", "res://assets/items/Pistol Magazine.png", 100, 1, "ammo", Vector2(1, 1), 1)
	var item_rocket = Item.new("Rocket", "res://assets/items/Rocket.png", 100, 1, "ammo", Vector2(2, 1), 10)

	# CLOTHES
	var item_boots = Item.new("Boots", "res://assets/items/Boots.png", 50, 1, "clothes", Vector2(1, 1), 3)
	var item_chestplate = Item.new("Chestplate", "res://assets/items/Chestplate.png", 250, 1, "clothes", Vector2(2, 2), 9.1)
	var item_gasmask = Item.new("Gas Mask", "res://assets/items/Gas Mask.png", 150, 1, "clothes", Vector2(1, 1), 2.7)
	var item_hockeymask = Item.new("Hockey Mask", "res://assets/items/Hockey Mask.png", 40, 1, "clothes", Vector2(1, 1), 1.5)
	var item_rubbergloves = Item.new("Rubber Gloves", "res://assets/items/Rubber Gloves.png", 50, 1, "clothes", Vector2(1, 1), 1.9)

	# FOOD
	var item_beefcan = Item.new("Beef Can", "res://assets/items/Beef Can.png", 5, 1, "food", Vector2(1, 1), 2)
	var item_mre = Item.new("MRE", "res://assets/items/MRE.png", 12, 1, "food", Vector2(2, 1), 6)
	var item_mrebox = Item.new("MRE Box", "res://assets/items/MRE Box.png", 144, 1, "food", Vector2(2, 2), 72)
	var item_tunacan = Item.new("Tuna Can", "res://assets/items/Tuna Can.png", 4, 1, "food", Vector2(1, 1), 2)
	var item_waterbottle = Item.new("Water Bottle", "res://assets/items/Water Bottle.png", 6, 1, "food", Vector2(1, 1), 1.9)
	var item_waterbottlepack = Item.new("Water Bottle Pack", "res://assets/items/Water Bottle Pack.png", 54, 1, "food", Vector2(1, 1), 17.9)

	# MEDICAL
	var item_antiradiationpills = Item.new("Anti-Radiation Pills", "res://assets/items/Anti Radiation Pills.png", 75, 1, "medical", Vector2(1, 1), 0.6)
	var item_bandageroll = Item.new("Bandage Roll", "res://assets/items/Bandage Roll.png", 50, 1, "medical", Vector2(1, 1), 0.4)
	var item_coldmedicine = Item.new("Cold Medicine", "res://assets/items/Cold Medicine.png", 50, 1, "medical", Vector2(1, 1), 0.6)
	var item_improvisedmedkit = Item.new("Improvised Medkit", "res://assets/items/Improvised Medkit.png", 40, 1, "medical", Vector2(1, 1), 0.9)
	var item_mats = Item.new("Mats", "res://assets/items/Mats.png", 30, 1, "drugs", Vector2(1, 1), 0.6)
	var item_medkit = Item.new("Medkit", "res://assets/items/Medkit.png", 75, 1, "medical", Vector2(2, 1), 1)

	# PARTS
	var item_akbarrel = Item.new("AK Barrel", "res://assets/items/AK Barrel.png", 333, 1, "parts", Vector2(1, 1), 2.3)
	var item_akbody = Item.new("AK Body", "res://assets/items/AK Body.png", 400, 1, "parts", Vector2(1, 1), 3.5)
	var item_akstrap = Item.new("AK Strap", "res://assets/items/AK Strap.png", 50, 1, "parts", Vector2(1, 1), 0.7)

	# QUESTS
	var item_invoice = Item.new("invoice", "res://assets/items/Invoice.png", 0, 1, "quests", Vector2(1, 1), 0.1)
	var item_kronussuit = Item.new("Kronus Suit", "res://assets/items/Kronus Suit.png", 3000, 1, "quests", Vector2(3, 3), 10)
	var item_matbox = Item.new("matbox", "res://assets/items/Matsbox.png", 1000, 1, "quests", Vector2(3, 2), 10)
	var item_order = Item.new("order", "res://assets/items/Order.png", 0, 1, "quests", Vector2(1, 1), 0.1)
	var item_reactorboxempty = Item.new("corebox", "res://assets/items/Reactor Box (Empty).png", 10000, 1, "quests", Vector2(5, 5), 10)
	var item_reactorboxfull = Item.new("coreboxfull", "res://assets/items/Reactor Box (Full).png", 100000, 1, "quests", Vector2(5, 5), 80)
	var item_ssasuit = Item.new("SSA Suit", "res://assets/items/SSA Suit.png", 3000, 1, "quests", Vector2(3, 3), 10)
	var item_betony = Item.new("Betony", "res://assets/items/Betony.png", 20, 1, "quests", Vector2(1,1), 0.1)
	var item_hyssop = Item.new("Hyssop", "res://assets/items/Hyssop.png", 20, 1, "quests", Vector2(1,1), 0.1)
	var item_herbalmedicine = Item.new("Herbal Medicine", "res://assets/items/Herbal Medicine.png", 400, 1, "quests", Vector2(1, 1), 0.4)

	# SCRAP
	var item_bracelet = Item.new("Bracelet", "res://assets/items/Bracelet.png", 2, 1, "scrap", Vector2(1, 1), 0.2)
	var item_deerskull = Item.new("Deer Skull", "res://assets/items/Deer Skull.png", 100, 1, "scrap", Vector2(2, 2), 8.3)
	var item_engineblock = Item.new("Engine Block", "res://assets/items/Engine Block.png", 1000, 1, "scrap", Vector2(3, 3), 100)
	var item_fishinghook = Item.new("Fishing Hook", "res://assets/items/Fishing Hook.png", 1, 1, "scrap", Vector2(1, 1), 0.1)
	var item_gear = Item.new("Gear", "res://assets/items/Gear.png", 6, 1, "scrap", Vector2(1, 1), 1.8)
	var item_leatherhide = Item.new("Leather Hide", "res://assets/items/Leather Hide.png", 9, 1, "scrap", Vector2(1, 1), 4.5)
	var item_metalpipe = Item.new("Metal Pipe", "res://assets/items/Metal Pipe.png", 16, 1, "scrap", Vector2(2, 1), 3)
	var item_piston = Item.new("Piston", "res://assets/items/Piston.png", 50, 1, "scrap", Vector2(1, 1), 4.3)
	var item_rope = Item.new("Rope", "res://assets/items/Rope.png", 3, 1, "scrap", Vector2(1, 1), 0.3)
	var item_scrapmetal = Item.new("Scrap Metal", "res://assets/items/Scrap Metal.png", 2, 1, "scrap", Vector2(1, 1), 1.4)
	var item_screws = Item.new("Screws", "res://assets/items/Screws.png", 8, 1, "scrap", Vector2(1, 1), 1.1)

	# TECH
	var item_cpu = Item.new("CPU", "res://assets/items/CPU.png", 600, 1, "tech", Vector2(1, 1), 0.2)
	var item_gpu = Item.new("GPU", "res://assets/items/GPU.png", 900, 1, "tech", Vector2(1, 1), 0.8)
	var item_motherboard = Item.new("Motherboard", "res://assets/items/Motherboard.png", 300, 1, "tech", Vector2(1, 1), 2.1)

	# TOOLS
	var item_crowbar = Item.new("Crowbar", "res://assets/items/Crowbar.png", 200, 1, "tools", Vector2(2, 1), 2)
	var item_gas = Item.new("Gas", "res://assets/items/Gas.png", 250, 1, "tools", Vector2(2, 2), 8)
	var item_largetoolkit = Item.new("Large Repair Kit", "res://assets/items/Large Tool Kit.png", 300, 1, "tools", Vector2(2, 2), 17.5)
	var item_lighter = Item.new("Lighter", "res://assets/items/Lighter.png", 3, 1, "tools", Vector2(1, 1), 0.2)
	var item_matches = Item.new("Matches", "res://assets/items/Matches.png", 10, 1, "tools", Vector2(1, 1), 0.1)
	var item_nightvisiongoggles = Item.new("Night Vision Goggles", "res://assets/items/Night Vision Goggles.png", 750, 1, "tools", Vector2(2, 1), 4)
	var item_smalltoolkit = Item.new("Small Repair Kit", "res://assets/items/Small Tool Kit.png", 150, 1, "tools", Vector2(2, 1), 8.6)
	var item_walkie = Item.new("Walkie", "res://assets/items/Walkie.png", 300, 1, "tools", Vector2(1, 1), 2)

	# WEAPONS
	var item_ak = Item.new("AK", "res://assets/items/AK.png", 1000, 1, "weapons", Vector2(3, 2), 10)
	item_ak.itemAmmo = "7.62"
	item_ak.itemDamage = 40
	var item_combatknife = Item.new("Combat Knife", "res://assets/items/CombatKnife.png", 300, 1, "weapons", Vector2(2, 1), 1)
	item_combatknife.itemDamage = 10
	item_combatknife.itemAmmo = "none"
	var item_glock = Item.new("Glock", "res://assets/items/Glock.png", 800, 1, "weapons", Vector2(1, 1), 4)
	item_glock.itemAmmo = "9mm"
	item_glock.itemDamage = 20
	var item_knife = Item.new("Knife", "res://assets/items/Knife.png", 100, 1, "weapons", Vector2(1, 1), 0.8)
	item_knife.itemAmmo = "none"
	item_knife.itemDamage = 5
	var item_m16 = Item.new("M16", "res://assets/items/M16.png", 1000, 1, "weapons", Vector2(3, 2), 10)
	item_m16.itemAmmo = "5.56"
	item_m16.itemDamage = 30
	var item_pistol = Item.new("Pistol", "res://assets/items/Pistol.png", 600, 1, "weapons", Vector2(1, 1), 5)
	item_pistol.itemDamage = 20
	item_pistol.itemAmmo = "9mm"
	var item_rocketlauncher = Item.new("Rocket Launcher", "res://assets/items/Rocket Launcher.png", 2000, 1, "weapons", Vector2(3, 2), 5)
	item_rocketlauncher.itemAmmo = "Rocket"
	item_rocketlauncher.itemDamage = 100

	# WEARABLES
	var item_backpack = Item.new("Backpack", "res://assets/items/Backpack.png", 300, 1, "wearable", Vector2(2, 2), 1.3)
	var item_hazmatsuit = Item.new("Hazmat Suit", "res://assets/items/Hazmat Suit.png", 600, 1, "wearable", Vector2(2, 3), 1.5)
	var item_utilitybelt = Item.new("Utility Belt", "res://assets/items/Utility Belt.png", 250, 1, "wearable", Vector2(3, 1), 2.2)

	# AMMO
	add_item(item_556ammo)
	add_item(item_762ammo)
	add_item(item_9mmammo)
	add_item(item_akmagazine)
	add_item(item_heavyammo)
	add_item(item_pistolmagazine)
	add_item(item_rocket)
	# CLOTHES
	add_item(item_boots)
	add_item(item_chestplate)
	add_item(item_gasmask)
	add_item(item_rubbergloves)
	# FOOD
	add_item(item_beefcan)
	add_item(item_mre)
	add_item(item_mrebox)
	add_item(item_tunacan)
	add_item(item_waterbottle)
	add_item(item_waterbottlepack)
	# MEDICAL
	add_item(item_antiradiationpills)
	add_item(item_bandageroll)
	add_item(item_coldmedicine)
	add_item(item_improvisedmedkit)
	add_item(item_mats)
	add_item(item_medkit)
	# PARTS
	add_item(item_akbarrel)
	add_item(item_akbody)
	add_item(item_akstrap)
	# QUESTS
	add_item(item_invoice)
	add_item(item_kronussuit)
	add_item(item_ssasuit)
	add_item(item_matbox)
	add_item(item_order)
	add_item(item_reactorboxempty)
	add_item(item_reactorboxfull)
	add_item(item_betony)
	add_item(item_hyssop)
	add_item(item_herbalmedicine)
	# SCRAP
	add_item(item_bracelet)
	add_item(item_deerskull)
	add_item(item_engineblock)
	add_item(item_fishinghook)
	add_item(item_gear)
	add_item(item_leatherhide)
	add_item(item_metalpipe)
	add_item(item_piston)
	add_item(item_rope)
	add_item(item_scrapmetal)
	# TECH
	add_item(item_cpu)
	add_item(item_gpu)
	add_item(item_motherboard)
	# TOOLS
	add_item(item_crowbar)
	add_item(item_gas)
	add_item(item_largetoolkit)
	add_item(item_lighter)
	add_item(item_matches)
	add_item(item_nightvisiongoggles)
	add_item(item_smalltoolkit)
	add_item(item_walkie)
	# WEAPONS
	add_item(item_ak)
	add_item(item_combatknife)
	add_item(item_glock)
	add_item(item_knife)
	add_item(item_m16)
	add_item(item_pistol)
	add_item(item_rocketlauncher)
	# WEARABLES
	add_item(item_backpack)
	add_item(item_hazmatsuit)
	add_item(item_utilitybelt)

# Functions
# Getter, returns the item list dictionary
func get_all_items() -> Dictionary:
	return self.itemDict
	
func get_item(name: String) -> Item:
	if self.itemDict.has(name):
		return self.itemDict[name]
	print("Getting item \"" + name + "\" failed. No such item exists. Null has been returned.")
	return null
	
func get_rand_items(T: Array, N: int) -> Array: # used for random event characters with inventories, T is an array of strings (the item types the character can have), N is how many random items you want
	var possible_items = []
	for item_name in self.itemDict:
		var item = self.itemDict[item_name]
		if item.get_type() in T:
			possible_items.append(item_name)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var item_list = []
	for i in range(N):
		item_list.append(create_item(possible_items[rng.randi_range(0, possible_items.size()-1)]))
	return item_list
	
func get_rand_items_type(T: String, N: int, dups: bool) -> Array: # returns array of N items of type T with duplicates allowed (true) or not (false)
	if not T in ["ammo", "clothes", "food", "medical", "parts", "quests", "scrap", "tech", "tools", "weapons", "wearable"]:
		print("Type \"" + T + "\" is not a valid item type.")
		return []
	
	var possible_items = []
	for item_name in self.itemDict:
		var item = self.itemDict[item_name]
		if item.get_type() == T:
			possible_items.append(item_name)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var item_list = []
	if dups == true:
		for i in range(N):
			item_list.append(create_item(possible_items[rng.randi_range(0, possible_items.size()-1)]))
		return item_list
	elif dups == false:
		if possible_items.size() < N:
			for item_name in possible_items:
				item_list.append(create_item(item_name))
			print("Only " + str(possible_items.size()) + " items of type " + T + " exist, which is less than " + str(N) + ". Returning a list of these " + str(possible_items.size()) + " items.")
			return item_list
		else:
			var pi = possible_items.duplicate()
			pi.shuffle()
			for i in range(N):
				var random_item_name = pi.pop_front()
				item_list.append(create_item(random_item_name))
			return item_list
			
	return []

#
# create_item
#
# itemName: String -> takes an item name that exists
# return Item -> returns a duplicate of the Item requested
# return null -> if item doesn't exist
#
func create_item(itemName: String) -> Item:
	# Check if item exists
	if exists_item(itemName) == false:
		print("Item: (" + itemName + ") does not exist")
		return null
	# Grab item to be created
	var originalItem = get_item(itemName)
	# Set all _init() variables for Item.gd
	var name = originalItem.get_name()
	var filepath = originalItem.get_filepath()
	var value = originalItem.get_value()
	var quantity = originalItem.get_quantity()
	var type = originalItem.get_type()
	var size = originalItem.get_size()
	var weight = originalItem.get_weight()
	var newItem = Item.new(name, filepath, value, quantity, type, size, weight)
	# DEBUG: Check if Item is created correctly
	#print("Item Created: " + newItem.get_name() + ", "
	#					+ newItem.get_filepath() + ", "
	#					+ str(newItem.get_value()) + ", "
	#					+ str(newItem.get_quantity()) + ", "
	#					+ newItem.get_type() + ", "
	#					+ str(newItem.get_size()) + ", "
	#					+ str(newItem.get_weight()))

	return newItem

#
# exists_item
#
# name: String -> the name of the item
# return -> true if found, false if not
#
func exists_item(name: String) -> bool:
	if self.itemDict.has(name):
		return true
	return false

# Adds an Item object to the dictionary
func add_item(item: Item) -> void:
	if self.itemDict.has(item.get_name()): # an item with the same name exists already
		print("An Item with the name \"" + item.get_name() + "\" already exists! Check to make sure all item names are unique.")
		return
	self.itemDict[item.get_name()] = item
	#print("Successfully added Item \"" + item.get_name() + "\".")

# Removes an Item object from the dictionary
func remove_item(itemName: String) -> void:
	if !self.itemDict.erase(itemName): # .erase() returns false if key doesnt exist, otherwise the removal occurs and true is returned
		print("Removing item \"" + itemName + "\" failed: No item with that name exists.")
		return
	print("Successfully removed item \"" + itemName + "\".")

# Clears the item list dictionary
func remove_all_items() -> void:
	self.itemDict.clear()
	
func get_item_names() -> Array:
	return itemDict.keys()

# Get the number of Items that have been added to the game
func num_items() -> int:
	return self.itemDict.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
