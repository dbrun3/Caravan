extends GridContainer

# member variables
var centered = false
var inventory = null # stores reference to parent node (Inventory)

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_parent().get_parent() # fetches parent node
	
# returns item to table and removes it from scene	
func cancel():
	
	inventory.itemtable.table_add(inventory.focusedItem)
	inventory.remove_child(inventory.focusedIcon)
	var index = inventory.inventoryIcons.find(inventory.focusedIcon)
	if index != -1:
		inventory.inventoryIcons.pop_at(index)
	print("inventory icon array size: ", inventory.inventoryIcons.size())
	inventory.focusedIcon = null
	inventory.focusedItem = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# adjusts the inventory grid to be centered at bottom of window
	if !centered: # only ran once
		var vp = get_viewport_rect().size.x / 2
		var g = self.rect_size.x / 2
		var t = vp - g
		self.rect_position.x = t
		self.rect_position.y = get_viewport_rect().size.y / 2 - inventory.cell_size + 39
		# old grid y position
		#self.rect_position.y = get_viewport_rect().size.y - inventory.cell_size - self.rect_size.y
		centered = true
		inventory.gridBG.rect_size = self.rect_size + Vector2(inventory.cell_size / 2, inventory.cell_size / 2)
		inventory.gridBG.rect_global_position = self.rect_global_position - Vector2(inventory.cell_size / 4, inventory.cell_size / 4)

# determines if an item goes out of inventory grid bounds after an item has been anchored to a cell.
# does so by checking if all 4 rectangle corners are valid points within the grid container.
func item_bounds_check(item):
	
	var top_left = item.rect_global_position
	var top_right = top_left + Vector2(item.rect_size.x - 1, 0)
	var bottom_left = top_left + Vector2(0, item.rect_size.y - 1)
	var bottom_right = top_right + Vector2(0, item.rect_size.y - 1)
	
	if !self.get_global_rect().has_point(top_left):
		print("item goes out of inventory bounds")
		return false
	if !self.get_global_rect().has_point(top_right):
		print("item goes out of inventory bounds")
		return false
	if !self.get_global_rect().has_point(bottom_left):
		print("item goes out of inventory bounds")
		return false
	if !self.get_global_rect().has_point(bottom_right):
		print("item goes out of inventory bounds")
		return false
	return true

# event handler that determines if item dragged onto grid cell or not. 
# if so, bounds are checked to make sure icon does not go out of inventory grid.
# Collisions between other icons are also checked, via the call of the focusedIcon method check_overlaps
func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_released("left_click"):
			if inventory.focusedIcon != null:
				if get_global_rect().has_point(get_global_mouse_position()): # checks if mouse release point is within the grid rectangle
					var pos = (get_global_mouse_position() - (inventory.focusedIcon.rect_size / 2)) + Vector2(inventory.cell_size / 2, inventory.cell_size / 2)
					var children = get_children()
					var found = false
					for i in children: # iterates through grid children (grid cells) and determines whether any of them contain the anchor point
						if i.get_global_rect().has_point(pos):
							var p = i.rect_position
							p = p + self.rect_position
							inventory.focusedIcon.set_global_position(p)
							if item_bounds_check(inventory.focusedIcon):
								found = true
								inventory.focusedIcon.check_overlaps()
							break
					if !found:
						print("could not snap to square")
						cancel()
				else:
					cancel()
				
				
				
				
		
