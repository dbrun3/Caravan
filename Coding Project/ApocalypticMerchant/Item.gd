class_name Item
extends Node

# Declare member variables here. Examples:
var itemName: String
var itemFilepath: String
var itemValue: int
var itemQuantity: int
var itemType: String
var itemSize: Vector2
var invPos : Vector2
var itemWeight: float
var itemDamage: int # The amount of damage an item does
var itemAmmo: String # The associated ammo for weapon Items
# Potential item attributes we might use/modiy in the future
#var itemCost: int

# Constructor
func _init(name = "", fpath = "", value = 0, qnty = 0, type = "", size = Vector2(1, 1), weight = 0.1, dmg = 0, ammo = ""):
	self.itemName = name
	self.itemFilepath = fpath
	self.itemValue = value
	self.itemQuantity = qnty
	self.itemType = type
	self.itemSize = size
	self.invPos = Vector2(-1, -1)
	self.itemWeight = weight
	if name == "AK":
		self.itemAmmo = "7.62"
		self.itemDamage = 40
	elif name == "Combat Knife":
		self.itemAmmo = "none"
		self.itemDamage = 10
	elif name == "Glock":
		self.itemAmmo = "9mm"
		self.itemDamage = 20
	elif name == "Knife":
		self.itemAmmo = "none"
		self.itemDamage = 5
	elif name == "M16":
		self.itemAmmo = "5.56"
		self.itemDamage = 30
	elif name == "Pistol":
		self.itemAmmo = "9mm"
		self.itemDamage = 20
	elif name == "Rocket Launcher":
		self.itemAmmo = "Rocket"
		self.itemDamage = 100
	else:
		self.itemAmmo = ammo
		self.itemDamage = dmg

func load_sprite() -> Resource:
	return ResourceLoader.load(itemFilepath)

# Functions
# Getters/Setters
func get_name() -> String:
	return self.itemName

func get_filepath() -> String:
	return self.itemFilepath
	
func get_value() -> int:
	return self.itemValue
	
func get_quantity() -> int:
	return self.itemQuantity
	
func get_type() -> String:
	return self.itemType
	
func get_size() -> Vector2:
	return self.itemSize
	
func get_weight() -> float:
	return self.itemWeight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
