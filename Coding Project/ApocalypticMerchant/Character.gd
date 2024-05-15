class_name CharacterEvent
extends Node

# Member Variables
var characterName: String   # the name of the character
var characterFilepath: String # the filepath to the character's sprite
var dialogPath: String        # the dialog id of the characters dialog tree
var location: String        # the location name of where the character is currently at
var possible_biomes: Array # the biomes (strings) the character can be at
var respect: int            # the amount of respect the character has for the player
var inventory: Array        # the items the character has on hand for trading
var money: int
var currentPage: String     # current dialog character is on incase of trade mid-conversation
var combatSkill: int # combat skill of the character
var rewards: Array 

# Constructor
func _init(name = "", fpath = "", dpath = "", items = [], biomes = [], money = 0, nSkill = 0):
	self.characterName = name
	self.dialogPath = "res://assets/dialogs/" + dpath + ".tres"
	self.location = ""
	self.possible_biomes = biomes
	self.characterFilepath = "res://assets/characters/" + fpath + "/"
	self.respect = -1
	self.combatSkill = nSkill
	
	while items.size() > 0:
		var item = Global.item_manager.create_item(items.pop_front())
		self.inventory.append(item)

	self.currentPage = "none"
	if money == 0:
		self.money = int(rand_range(10,80))
	else:
		self.money = money
	print(self.money)

# Load sprite of type for character
func load_sprite(value: String) -> Resource:
	match(value):
		"bad":
			return ResourceLoader.load(characterFilepath + "bad.png")
		"neutral":
			return ResourceLoader.load(characterFilepath + "neutral.png")
		"good":
			return ResourceLoader.load(characterFilepath + "good.png")
		"default":
			print("yay")
			return ResourceLoader.load(characterFilepath + "default.png")
		_:
			if respect >= 3 and respect <= 7:
				return ResourceLoader.load(characterFilepath + "neutral.png") 
			elif respect < 3:
				return ResourceLoader.load(characterFilepath + "bad.png")
			elif respect > 7:
				return ResourceLoader.load(characterFilepath + "good.png")	
			else:
				return ResourceLoader.load(characterFilepath + "default.png") 
	
# Load character dialog from tres file
func load_dialog() -> Resource:
	return ResourceLoader.load(dialogPath)


# Inventory has specific item? 
func has_item(name) -> bool:
	
	for item in inventory:
		if item.itemName == name:
			return true
	
	return false
	
# Inventory has item of type?	
func has_type(type) -> bool:
	
	for item in inventory:
		if item.itemType == type:
			return true
	
	return false
	
# Functions
# Getters/Setters
# I think there's a more GDScript-specific way of creating getters and setters, maybe might switch to that in future
func get_name() -> String:
	return self.characterName

func set_name(name):
	self.characterName = name

func get_respect() -> int:
	return self.respect

func get_respect_status() -> String: # converts respect value into respect "status"/"state"
	if self.respect == -1:
		return "default"
	elif self.respect >= 3 and self.respect <= 7:
		return "neutral"
	elif self.respect < 3:
		return "bad"
	elif self.respect > 7:
		return "good"
	return "default"

func set_respect(rspt):
	self.respect = rspt

func inc_respect(rspt: int) -> void:
	self.respect += rspt

func dec_respect(rspt: int) -> void:
	self.respect -= rspt

func get_inventory() -> Array:
	return self.inventory

func set_inventory(iArray):
	self.inventory = iArray

func add_inventory_item(item):
	self.inventory.append(item)

func remove_inventory_item(item):
	self.inventory.erase(item)

func remove_item_type(item_type):
	for item in self.inventory:
		if item.get_type() == item_type:
			remove_inventory_item(item)
			return

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
