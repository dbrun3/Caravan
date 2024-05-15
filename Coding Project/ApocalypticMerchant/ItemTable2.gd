extends HBoxContainer


# Declare member variables here
var inventory = null
var dragging = false
var mouse_in = false
var focused_item_rect = null
var focused_index = -1

# Wrapper function adds items to both the table container and location item array
func table_add(item : Item):
	Global.current_location.locationItems.append(item)
	_table_add(item)

# Wrapper function removes items from both the table container and location item array
func table_remove(index : int):
	
	var item_vbox = self.get_child(index)
	
	if item_vbox is VBoxContainer:
		var item_rect = item_vbox.get_child(0)
		item_vbox.remove_child(item_rect)
		
	self.remove_child(item_vbox)
	
	var item = Global.current_location.locationItems.pop_at(index)
	return item

# Called when the node enters the scene tree for the first time.
func _ready():
	
	inventory = get_parent().get_parent()
	
	# add location's items' icons to table
	for item in Global.current_location.locationItems:
		_table_add(item)
	

	#inventory.itemtable = self


func _process(delta):
	if (dragging && Input.is_action_pressed("left_click")):
		pass
	elif (mouse_in && Input.is_action_pressed("left_click")):
		dragging = true
		itemSelected(focused_index)
	else:
		dragging = false

func itemSelected(index):
	# create new icon texture rect
	var icon = TextureRect.new()
	icon.texture = focused_item_rect.texture
	
	# attach inventory item script
	var src = load("res://InventoryItem.gd")
	icon.set_script(src)
	icon.set_process(true)
	
	# add the new icon to the inventory scene, track the item it represents
	inventory.add_child(icon)	
	inventory.focusedIcon = icon
	inventory.focusedIcon.outline.visible = true
	inventory.focusedItem = table_remove(index)

		
func _table_add(item : Item):
	var i = TextureRect.new()
	i.texture = item.load_sprite()
	i.expand = true
	i.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	i.rect_min_size = Vector2(64, 64)
	i.rect_pivot_offset = Vector2(i.rect_min_size.x / 2, i.rect_min_size.y / 2) # scale about the center
	i.connect("mouse_entered", self, "_on_item_icon_hover", [i])
	i.connect("mouse_exited", self, "_on_item_icon_unhover", [i])
	
	var item_container = VBoxContainer.new()
	item_container.alignment = BoxContainer.ALIGN_CENTER
	item_container.add_child(i)
	
	self.add_child(item_container)

# Item Hover Signals
func _on_item_icon_hover(item_rect):
	if dragging == false:
		item_rect.rect_scale = Vector2(1.1, 1.1)
		mouse_in = true
		focused_index = get_item_index(item_rect)
		focused_item_rect = item_rect

func _on_item_icon_unhover(item_rect):
	item_rect.rect_scale = Vector2(1, 1)
	mouse_in = false
	focused_index = null
	focused_item_rect = null

# Get Item Index in a Container
func get_item_index(item_rect):
	#print(item_rect.get_parent().get_index()) # DEBUG
	return item_rect.get_parent().get_index()

# Check if Mouse In Bounds of Container (the vbox)
func mouse_in_bounds(container):
	return container.get_parent().get_rect().has_point(get_global_mouse_position())
