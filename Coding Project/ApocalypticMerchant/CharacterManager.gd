class_name CharacterManager
extends Node

# Member Variables
# Dictionary of static (linear/ununique) characters, key: String (name of character), value: Character (the Character object)
var sCharDict: Dictionary # static characters
var dCharDict: Dictionary # dynamic characters
var events: Dictionary # random events

# Constructor
func _init():
	self.sCharDict = {}
	self.dCharDict = {}
	self.events = {}
	
# Load/Initialize Characters
func load_characters() -> void:
	# Get instance of the item_manager
	var im = Global.item_manager
	### DYNAMIC CHARACTERS ###
	var cityman = CharacterEvent.new("City Man", "junk", "cityman")
	var junkman = CharacterEvent.new("Junkman", "junk", "junkman", ["Rope", "9mm", "Small Repair Kit", "Large Repair Kit", "Gas", "Gas", "Gas"])
	junkman.inventory.append_array(Global.item_manager.get_rand_items_type("scrap", 5, true))
	var lonemerchant = CharacterEvent.new("Lone Merchant", "storeowner", "lonemerchant", ["Rope", "Gas"])
	lonemerchant.money = 2761
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("ammo", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("clothes", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("food", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("medical", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("parts", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("scrap", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("tech", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("tools", 2, true))
	lonemerchant.inventory.append_array(Global.item_manager.get_rand_items_type("wearable", 2, true))
	var mercenary = CharacterEvent.new("Mercenary", "merc", "mercenary", ["Knife", "7.62", "9mm", "Mats"])
	mercenary.money = 400
	mercenary.combatSkill = 80
	mercenary.inventory.append_array(Global.item_manager.get_rand_items_type("food", 2, true))
	mercenary.inventory.append_array(Global.item_manager.get_rand_items_type("medical", 1, true))
	var manager = CharacterEvent.new("Manager", "manager", "manager")
	var mayor = CharacterEvent.new("Mayor", "mayor", "mayor", ["Gas", "Gas", "5.56", "Hazmat Suit", "Small Repair Kit"])
	mayor.money = 4000
	mayor.inventory.append_array(Global.item_manager.get_rand_items_type("tools", 1, true))
	var ssa_guard = CharacterEvent.new("SSA Guard", "ssa_guard", "ssa_guard")
	var ssa_guard2 = CharacterEvent.new("SSA Guard2", "ssa_guard", "ssa_guard2")
	var ssa_arms = CharacterEvent.new("SSA Arms", "bubbles", "ssa_arms", ["SSA Suit", "Combat Knife", "Pistol", "Glock", "M16", "Rocket Launcher"])
	ssa_arms.money = 2500
	var deacon = CharacterEvent.new("Deacon", "deacon", "deacon")
	var bishop = CharacterEvent.new("Bishop", "engineer", "engineer", ["Gas", "Small Repair Kit", "Medkit"])
	bishop.money = 0
	var doctor = CharacterEvent.new("Doctor", "doctor", "doctor")
	var herbalist = CharacterEvent.new("Herbalist", "herb", "herbalist", ["Rubber Gloves", "Water Bottle", "Water Bottle", "Water Bottle", "Bracelet", "Knife"])
	var exec = CharacterEvent.new("Executive", "exec", "exec")
	var terminal = CharacterEvent.new("Terminal", "factory", "factory")
	var colonel = CharacterEvent.new("Colonel", "colonel", "colonel")
	var reformed_raider = CharacterEvent.new("Reformed Raider", "reform", "reformed_raider", ["7.62", "Metal Pipe", "Piston", "Gas", "Large Repair Kit"])
	reformed_raider.money = 2000
	var independence_resident = CharacterEvent.new("Independence Resident", "resident", "independence_resident", ["Gas", "9mm", "Small Repair Kit", "Boots", "Bandage Roll", "Improvised Medkit", "Walkie", "Backpack"])
	independence_resident.inventory.append_array(Global.item_manager.get_rand_items_type("food", 2, true))
	var wise_scav = CharacterEvent.new("Wise Scavenger", "scavenger", "wise_scavenger", ["9mm", "Gas", "Scrap Metal", "Bracelet"])
	wise_scav.money = 700
	var junkyard_worker = CharacterEvent.new("Junkyard Worker", "merc", "junkyard_worker")
	var engineer = CharacterEvent.new("Engineer", "engineer", "engineer")
	add_dCharacter(colonel)
	add_dCharacter(doctor)
	add_dCharacter(herbalist)
	add_dCharacter(exec)
	add_dCharacter(deacon)
	add_dCharacter(bishop)
	add_dCharacter(manager)
	add_dCharacter(cityman)
	add_dCharacter(junkman)
	add_dCharacter(lonemerchant)
	add_dCharacter(mercenary)
	add_dCharacter(mayor)
	add_dCharacter(ssa_guard)
	add_dCharacter(ssa_guard2)
	add_dCharacter(ssa_arms)
	add_dCharacter(terminal)
	add_dCharacter(reformed_raider)
	#add_dCharacter(independence_resident)
	add_dCharacter(wise_scav)
	add_dCharacter(junkyard_worker)
	add_dCharacter(engineer)
	
	##########################
	### STATIC CHARACTERS ###
	var guard = CharacterEvent.new("Guard", "lp", "guard")
	var hunter = CharacterEvent.new("Hunter", "oldman", "hunter")
	var mechanic = CharacterEvent.new("Mechanic", "mechanic", "mechanic", ["Large Repair Kit", "Small Repair Kit", "Engine Block"])
	mechanic.money = 1500
	mechanic.inventory.append_array(im.get_rand_items_type("tools", 3, false))
	var gas = CharacterEvent.new("Gas", "gas", "gas", ["Gas","Gas", "Water Bottle"])
	gas.money = 2000
	gas.inventory.append_array(Global.item_manager.get_rand_items_type("food", 3, true))
	var medic = CharacterEvent.new("Medic", "junk", "medic")
	var scavenger = CharacterEvent.new("Scavenger", "scavenger", "scavenger")
	var survivor = CharacterEvent.new("Survivor", "survivor", "survivor", ["Backpack", "Knife"])
	survivor.money = 20
	var weaponsmith = CharacterEvent.new("Weaponsmith", "junk", "weaponsmith")
	add_dCharacter(guard)
	add_sCharacter(hunter)
	add_dCharacter(gas)
	add_sCharacter(mechanic)
	add_sCharacter(medic)
	add_sCharacter(scavenger)
	add_dCharacter(survivor)
	add_sCharacter(weaponsmith)
	#########################
	#### EVENTS #####
	var scavaggro = CharacterEvent.new("Scav (Aggravated)", "scavenger", "scavaggro", [], ["city"])
	scavaggro.combatSkill = 20
	var scavpassive = CharacterEvent.new("Scav", "scavenger", "scavpassive",  [], ["city"])
	scavpassive.combatSkill = 20
	var raider = CharacterEvent.new("Raider", "raiders", "raider", [], ["nobiome"])
	raider.combatSkill = 40
	var wanderer = CharacterEvent.new("Wanderer", "wander", "wanderer", [], ["nobiome"])
	var lp = CharacterEvent.new("Loss Prevention", "lp", "lp", [], ["city"])
	lp.combatSkill = 70
	var patrol = CharacterEvent.new("Soldiers", "soldiers", "ssa_patrol", [], ["nobiome"])
	patrol.rewards = ["M16", "5.56"]
	lp.rewards = ["Rocket Launcher", "Rocket", "5.56", "5.56", "5.56"]
	raider.rewards = ["AK", "7.62", "7.62", "7.62"];
	scavpassive.rewards = ["Mats", "9mm"]
	scavaggro.rewards = ["Mats", "9mm"]
	add_event(scavaggro)
	add_event(scavpassive)
	add_event(raider)
	add_event(wanderer)
	add_event(lp)
	add_event(patrol)
	#Item discovery
	var rand_tools = CharacterEvent.new("tools", "", "rand_item", [], ["city", "nobiome", "scorch"])
	var rand_scrap = CharacterEvent.new("scrap", "", "rand_item", [], ["city", "nobiome", "scorch"])
	var rand_medical = CharacterEvent.new("medical", "", "rand_item", [], ["city"])
	var rand_parts = CharacterEvent.new("parts", "", "rand_item", [], ["city", "nobiome" , "woods"])
	var rand_food = CharacterEvent.new("food", "", "rand_item", [], ["city", "woods"])
	var rand_ammo = CharacterEvent.new("ammo", "", "rand_item", [], ["city", "woods", "nobiome"])
	add_event(rand_food)
	add_event(rand_tools)
	add_event(rand_scrap)
	add_event(rand_medical)
	add_event(rand_parts)
	add_event(rand_ammo)

# Functions

# Character Dictionary Getters
func get_all_sCharacters() -> Dictionary:
	return self.sCharDict
	
func get_all_dCharacters() -> Dictionary:
	return self.dCharDict
	
func get_all_characters() -> Dictionary:
	var allCharsDict = self.sCharDict.duplicate().merge(self.dCharDict.duplicate())
	return allCharsDict
##############################

# Character Dictionary Existence Checks
func exists_sCharacter(name: String) -> bool:
	if self.sCharDict.has(name):
		return true
	return false
	
func exists_dCharacter(name: String) -> bool:
	if self.dCharDict.has(name):
		return true
	return false
	
func exists_character(name: String) -> bool:
	if self.sCharDict.has(name) or self.dCharDict.has(name) or self.events.has(name):
		return true
	return false
	
func exists_event(name: String) -> bool:
	if self.events.has(name):
		print("event " + name + " exists")
		return true
	return false
##############################

# Individual Character Getters
func get_sCharacter(name: String) -> CharacterEvent:
	if self.sCharDict.has(name):
		return self.sCharDict[name]
	print("Getting static Character \"" + name + "\" failed. No such static Character exists. Null has been returned.")
	return null
	
func get_dCharacter(name: String) -> CharacterEvent:
	if self.dCharDict.has(name):
		return self.dCharDict[name]
	print("Getting dynamic Character \"" + name + "\" failed. No such dynamic Character exists. Null has been returned.")
	return null
	
func get_character(name: String) -> CharacterEvent:
	if self.sCharDict.has(name):
		return self.sCharDict[name]
	elif self.dCharDict.has(name):
		return self.dCharDict[name]
	elif self.events.has(name):
		return self.events[name]
	print("Getting Character \"" + name + "\" failed. No such Character exists. Null has been returned.")
	return null
	
func get_rand_sCharacter() -> CharacterEvent:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var sDictKeys = self.sCharDict.keys()
	return self.sCharDict[sDictKeys[rng.randi_range(0, sDictKeys.size()-1)]]
	
func get_rand_dCharacter() -> CharacterEvent:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dDictKeys = self.dCharDict.keys()
	return self.dCharDict[dDictKeys[rng.randi_range(0, dDictKeys.size()-1)]]
	
func get_rand_event(biome: String) -> CharacterEvent:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var eventKeys = self.events.keys()
	
	var event = self.events[eventKeys[rng.randi_range(0, eventKeys.size()-1)]]
	
	while !event.possible_biomes.has(biome):
		event = self.events[eventKeys[rng.randi_range(0, eventKeys.size()-1)]]
		
	return event
##################################

# Add/Remove CharacterEvent Objects
func add_sCharacter(sChar: CharacterEvent) -> void:
	if self.sCharDict.has(sChar.get_name()) or self.dCharDict.has(sChar.get_name()): # a character with the same name exists already
		print("A Character with the name \"" + sChar.get_name() + "\" already exists! Check to make sure all Character names are unique.")
		return
	self.sCharDict[sChar.get_name()] = sChar
	#print("Successfully added Character \"" + sChar.get_name() + "\".")
	
func add_dCharacter(dChar: CharacterEvent) -> void:
	if self.sCharDict.has(dChar.get_name()) or self.dCharDict.has(dChar.get_name()): # a character with the same name exists already
		print("A Character with the name \"" + dChar.get_name() + "\" already exists! Check to make sure all Character names are unique.")
		return
	self.dCharDict[dChar.get_name()] = dChar
	#print("Successfully added Character \"" + dChar.get_name() + "\".")
	
func add_event(event: CharacterEvent) -> void:
	if self.events.has(event.get_name()) or self.events.has(event.get_name()): # a character with the same name exists already
		print("A Event with the name \"" + event.get_name() + "\" already exists! Check to make sure all Event names are unique.")
		return
	self.events[event.get_name()] = event
	print("Successfully added Event \"" + self.events[event.get_name()].get_name() + "\".")

func remove_event(charName: String) -> void:
	if !self.events.erase(charName): # .erase() returns false if key doesnt exist, otherwise the removal occurs and true is returned
		print("Removing Event \"" + charName + "\" failed: No Event with that name exists.")
		return
	print("Successfully removed Event \"" + charName + "\".")

func remove_character(charName: String) -> void:
	if !self.sCharDict.erase(charName) and !self.dCharDict.erase(charName): # .erase() returns false if key doesnt exist, otherwise the removal occurs and true is returned
		print("Removing Character \"" + charName + "\" failed: No Character with that name exists.")
		return
	print("Successfully removed Character \"" + charName + "\".")
###################################

# Clear Out Character Dictionaries
func clear_sCharacters() -> void:
	self.sCharDict.clear()

func clear_dCharacters() -> void:
	self.dCharDict.clear()

func clear_all_characters() -> void:
	self.sCharDict.clear()
	self.dCharDict.clear()
###################################

# Get Names of Characters (keys of the dictionaries)
func get_characterNames() -> Array:
	return dCharDict.keys() + sCharDict.keys()
	
func print_characterNames_dict() -> void: # mostly for debugging purposes, shows character names and what dictionary they belong to
	print("dCharDict has characters:")
	for dCharName in dCharDict.keys():
		print(dCharName)
	print("-------------------------")
	print("sCharDict has characters:")
	for sCharName in sCharDict.keys():
		print(sCharName)
	print("-------------------------")
###################################

# Get Number of Characters
func num_sCharacters() -> int:
	return self.sCharDict.size()
	
func num_dCharacters() -> int:
	return self.dCharDict.size()
	
func num_Characters() -> int:
	return self.sCharDict.size() + self.dCharDict.size()
####################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
