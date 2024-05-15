extends ItemList


# Declare member variables here
var icon = preload("res://icon.png")
var sus = preload("res://assets/characters/sus.png")
var inventory = null

# Wrapper function adds items to both the table container and location item array
func table_add(item : Item):
	Global.current_location.locationItems.append(item)
	add_item(item.get_name(), item.load_sprite(), true)

# Wrapper function removes items from both the table container and location item array
func table_remove(index : int):
	var item = Global.current_location.locationItems.pop_at(index)
	remove_item(index)
	return item

# Called when the node enters the scene tree for the first time.
func _ready():
	
	inventory = get_parent()
	
	# add location's items' icons to table
	for item in Global.current_location.locationItems:
		self.add_item(item.get_name(), item.load_sprite(), true)
	
	#add_item("temp", icon, true)
	#add_item("sus", sus, true)
	#add_item("temp", icon, true)
	#add_item("sus", sus, true)
	inventory.itemtable = self
	

func _on_ItemTable_item_selected(index):
	# create new icon texture rect
	var icon = TextureRect.new()
	icon.texture = get_item_icon(index)
	
	# attach inventory item script
	var src = load("res://InventoryItem.gd")
	icon.set_script(src)
	icon.set_process(true)
	
	# add the new icon to the inventory scene, track the item it represents
	inventory.add_child(icon)	
	inventory.focusedIcon = icon
	inventory.focusedIcon.outline.visible = true
	inventory.focusedItem = table_remove(index)
	# remove the item from array & table			
		
