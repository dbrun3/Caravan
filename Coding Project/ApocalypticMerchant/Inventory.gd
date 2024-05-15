extends Control


# member variables
const cell_size = 64 # inventory grid cell size
var inventorySet = false
var itemtable = null # stores reference to itemlist child node
var focusedItem = null # item being dragged
var focusedIcon = null # icon of being currently dragged
var inventoryIcons = [] # array of icons parallels the Global list of items they represent
var gridBG = null
var grid = null
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# create grid
	gridBG = get_node("GridLayer/GridBackground")
	gridBG.visible = false
	grid = get_node("GridLayer/InventoryGrid") # fetches grid container child node
	get_node("GridLayer").z_index = -1
	var i = 0
	while i < (36 + Global.additionalInventorySlots):	# adds 36 cells to grid container of type ColorRect (colored dark gray)
		var node = ColorRect.new()
		node.color = Color(1,1,1,0.3)
		node.rect_size = Vector2(cell_size, cell_size)
		node.rect_min_size = Vector2(cell_size, cell_size)
		grid.add_child(node)
		i = i + 1
	
	# populate grid with existing icons of exisiting items in inventory
	for item in Global.player.inventory :
		
		# new texture rect
		var icon = TextureRect.new()
		icon.texture = item.load_sprite()
		icon.rect_global_position = item.invPos
		
		
		# attach inventory item script
		var src = load("res://InventoryItem.gd")
		icon.set_script(src)
		icon.set_process(true)
		
		# add the new icon to the inventory scene, track the item it represents
		add_child(icon)	
		inventoryIcons.push_back(icon)
	inventorySet = true

