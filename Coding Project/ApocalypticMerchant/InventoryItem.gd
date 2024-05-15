extends TextureRect


# member variables
var enable_dragging = false
var outline = null
var area = null
var colbox = null
var colcheck = false
var inventory = null
var hoveredOver = false
# Called when the node enters the scene tree for the first time.
# fetches parent node. Adds ColorRect, Area2D and CollisionShape2D children to self.
# ColorRect is used to show how many cells an item takes up
# Area2D and CollisionShape2D are added to allow for item collision detection within the inventory.
func _ready():
	self.rect_pivot_offset = self.rect_size / 2
	inventory = get_parent()
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	outline = Sprite.new()
	outline.texture = ResourceLoader.load("res://assets/items/grid_item_space.png")
	outline.scale = self.rect_size
	outline.z_index = -1
	outline.position = self.rect_size / 2
	self.add_child(outline)
	area = Area2D.new()
	colbox = CollisionShape2D.new()
	colbox.shape = RectangleShape2D.new()
	colbox.shape.extents = self.rect_size / 2
	area.add_child(colbox)
	area.position = self.rect_size / 2
	self.add_child(area)
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	

	outline.visible = false


	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("left_click") and self.hoveredOver and inventory.focusedIcon == null:
		
		# set focusedIcon and find item in inventory corresponding to icon
		inventory.focusedIcon = self
		var self_icon_index = inventory.inventoryIcons.find(self)
		if self_icon_index != -1:
			inventory.focusedItem = Global.player.inventory.pop_at(self_icon_index)
			Global.player.remove_weight(inventory.focusedItem.get_weight())
			inventory.inventoryIcons.pop_at(self_icon_index)
		else:
			print("something wrong with inventoryIcons array")
		print(Global.player.inventory.size())
		outline.visible = true
	
		
	if InputEventMouseMotion and inventory.focusedIcon == self:
		# adjusts icon position to be centered at mouse cursor position
		set_global_position(get_global_mouse_position() - (rect_size / 2))
		
	if colcheck:
		if area.get_overlapping_areas().size() > 0:
			# return focusedItem to table
			print("colliding with other item")
			inventory.itemtable.table_add(inventory.focusedItem)
			inventory.remove_child(self)
		else:
			# add to focusedItem to inventory and focusedIcon to grid. Save invPos.
			Global.player.add_inventory_item(inventory.focusedItem)
			#Global.player.inventory.push_back(inventory.focusedItem)
			print(Global.player.inventory.size())
			inventory.inventoryIcons.push_back(self)
			print("inventory icon array size: ", inventory.inventoryIcons.size())
			inventory.focusedItem.invPos = self.rect_global_position
			self.outline.visible = false
			print("no overlaps detected")
		colcheck = false
		inventory.focusedItem = null
		


# sets a flag to allow self to detect collisions with other items.
# A delay is used via a timer to allow for the frame to update so that
# the collision detection works properly/as intended.
func check_overlaps():
	inventory.focusedIcon = null
	yield(get_tree().create_timer(0.03), "timeout")
	colcheck = true
	
	
func _on_mouse_entered():
	print("mouse entered")
	self.hoveredOver = true
	
func _on_mouse_exited():
	print("mouse exited")
	self.hoveredOver = false
	
