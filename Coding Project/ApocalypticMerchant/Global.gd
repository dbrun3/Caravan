extends Node

var running = false
var music: AudioStreamMP3
var current_tool = 0
var current_scene = null
var current_location = null
var current_character = null
var ending = -1
var done_randomizing_locations = false # flag so randomization not triggered upon re-entering Nav scene
const map_size := Vector2(6144.0, 6144.0) # map size, access: Global.map_size.x (width) or Global.map_size.y (height)
var location_manager
var item_manager
var charevent_manager
const cell_size := Vector2(256.0, 256.0) # grid cell size
const total_cells := Vector2(map_size.x / cell_size.x, map_size.y / cell_size.y) # total cell width and height
var player = null # stores player KinematicBody2D node and its children
var cameraPosition := Vector2(0.0, 0.0)
var enterLocationButtonPressed = false

var purchasedSkills = [] # array that holds node paths of purchased skills
var additionalInventorySlots : int = 0 # holds slot upgrades to add to grid upon scene entry

func _ready():
	pass


func init():
	
	current_tool = 0
	current_scene = null
	current_location = null
	current_character = null
	ending = -1
	done_randomizing_locations = false # flag so randomization not triggered upon re-entering Nav scene
	location_manager
	item_manager
	charevent_manager
	player = null # stores player KinematicBody2D node and its children
	cameraPosition = Vector2(0.0, 0.0)
	enterLocationButtonPressed = false

	purchasedSkills = [] # array that holds node paths of purchased skills
	additionalInventorySlots = 0 # holds slot upgrades to add to grid upon scene entry
	
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	player = Player.new()
	player.name = "Player"
	
	item_manager = ItemManager.new()
	item_manager.load_items()
	
	charevent_manager = CharacterManager.new()
	location_manager = LocationManager.new() # This is all that is needed! loading locations and characters done in LocationManager init()


	location_manager.get_location("Aircraft").locationItems = [item_manager.create_item("Glock"), item_manager.create_item("9mm"), item_manager.create_item("Gas Mask"), item_manager.create_item("Small Repair Kit"), item_manager.create_item("Medkit")]
	location_manager.get_location("Car").locationItems = [item_manager.create_item("M16"), item_manager.create_item("5.56"), item_manager.create_item("5.56"), item_manager.create_item("Small Repair Kit"), item_manager.create_item("Medkit")]

func goto_scene(path):
	Fade.fade_out(1)
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().current_scene = current_scene
	Fade.fade_in(1)




func _input(event):
	if Input.is_key_pressed(KEY_Q):
		goto_scene("res://MainMenu.tscn")
