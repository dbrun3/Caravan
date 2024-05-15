extends Control

# Declare member variables here. Examples:
onready var player_inventory = $PlayerInventory/VBoxContainer
onready var player_table = $PlayerTable/VBoxContainer
onready var npc_table = $NPCTable/VBoxContainer
onready var npc_inventory = $NPCInventory/VBoxContainer
onready var player_table_value_label = $PanelContainer/VBoxContainer/HBoxContainer/PlayerValueContainer/PlayerValue
onready var npc_table_value_label = $PanelContainer/VBoxContainer/HBoxContainer/NPCValueContainer/NPCValue/
onready var accept_button = $PanelContainer/VBoxContainer/AcceptButton
onready var cancel_button = $PanelContainer/VBoxContainer/CancelButton
onready var item_info = $PanelContainer/VBoxContainer/RichTextLabel
onready var customer_rect = $TextureRect
onready var player_money = $PlayerMoney
onready var NPC_money = $NPCMoney

var playerInventoryItems: Array # array of Items
var npcInventoryItems: Array # array of Items
var playerTableItems: Array # array of Items
var npcTableItems: Array # array of Items

var money_owed = 0 # The amount of money the player owes the NPC (if NPC offers higher value than the player) or vice versa

var mouse_in = false
var dragging = false
var focused_item_rect = null # texturerect
var focused_item = null # item object
var origin_container = null

# Called when the node enters the scene tree for the first time.
func _ready():
	accept_button.connect("pressed", self, "_accept_button_pressed")
	cancel_button.connect("pressed", self, "_cancel_button_pressed")
	
	player_money.text = str(Global.player.money)
	NPC_money.text = str(Global.current_character.money)
	
	initialize_item_lists()
	
	populate_inventory(playerInventoryItems, player_inventory)
	populate_inventory(npcInventoryItems, npc_inventory)
	customer_rect.texture = Global.current_character.load_sprite("nuetral")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragging && Input.is_action_pressed("left_click")):
		follow_mouse(focused_item_rect)
	elif (mouse_in && Input.is_action_pressed("left_click")):
		dragging = true
		remove_from_container(focused_item_rect)
		add_to_root(focused_item_rect)
		follow_mouse(focused_item_rect)
	elif (dragging): # stopped dragging after starting a drag
		dragging = false
		if origin_container == player_inventory:
			if mouse_in_bounds(player_table):
				move_to_container(focused_item_rect, player_table)
			else:
				move_to_container(focused_item_rect, origin_container)
		elif origin_container == npc_inventory:
			if mouse_in_bounds(npc_table):
				move_to_container(focused_item_rect, npc_table)
			else:
				move_to_container(focused_item_rect, origin_container)
		elif origin_container == player_table:
			if mouse_in_bounds(player_inventory):
				move_to_container(focused_item_rect, player_inventory)
			else:
				move_to_container(focused_item_rect, origin_container)
		elif origin_container == npc_table:
			if mouse_in_bounds(npc_inventory):
				move_to_container(focused_item_rect, npc_inventory)
			else:
				move_to_container(focused_item_rect, origin_container)
	else:
		dragging = false

# Initialize Item Lists for each inventory/table
func initialize_item_lists():
	playerInventoryItems = Global.current_location.locationItems.duplicate(true) # deep copy
	playerInventoryItems.append_array(Global.player.inventory) 
	npcInventoryItems = Global.current_character.inventory
	playerTableItems = []
	npcTableItems = []
	
	# debugging print statements
	print("Inventories before the trade:")
	print("Location Items:", Global.current_location.locationItems)
	print("Player Inventory:", Global.player.inventory)
	print("NPC Inventory:", Global.current_character.inventory)

# Populate Inventories
func populate_inventory(item_list, container):
	# Based on the item names, populate the inventory with their items
	for item in item_list:
		var i = TextureRect.new()
		i.texture = item.load_sprite()
		i.expand = true
		i.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		i.rect_min_size = Vector2(64, 64)
		i.rect_pivot_offset = Vector2(i.rect_min_size.x / 2, i.rect_min_size.y / 2) # scale about the center
		i.connect("mouse_entered", self, "_on_item_icon_hover", [i])
		i.connect("mouse_exited", self, "_on_item_icon_unhover", [i])
		
		var item_container = HBoxContainer.new()
		item_container.alignment = BoxContainer.ALIGN_CENTER
		item_container.add_child(i)
		
		container.add_child(item_container)

# Get Item Index in a Container
func get_item_index(item_rect):
	#print(item_rect.get_parent().get_index()) # DEBUG
	return item_rect.get_parent().get_index()

# Get Associated Item List with a Container
func get_item_list(container):
	if container == player_inventory:
		return playerInventoryItems
	elif container == player_table:
		return playerTableItems
	elif container == npc_table:
		return npcTableItems
	else:
		return npcInventoryItems

# Add an Item to an Item List Associated with a Container
func add_to_list(item, list):
	list.append(item)
	#print(item.get_name()) #DEBUG

# Remove an Item from an Item List
func remove_from_list(index, list):
	focused_item = list.pop_at(index)
	#print(focused_item.get_name()) #DEBUG

# Update the Values of the Tables
func update_table_values():
	var player_table_value = 0
	for item in playerTableItems:
		player_table_value += item.itemValue
	player_table_value_label.text = str(player_table_value)
	
	var npc_table_value = 0
	for item in npcTableItems:
		npc_table_value += item.itemValue
	npc_table_value_label.text = str(npc_table_value)
	
	if player_table_value > npc_table_value: # npc will owe player money
		player_table_value_label.add_color_override("font_color", Color.green)
		npc_table_value_label.add_color_override("font_color", Color.red)
		
		money_owed = npc_table_value - player_table_value # negative value, character owes player money
		if abs(money_owed) > Global.current_character.money: # character does not have enough funds to make this trade happen
			accept_button.set_disabled(true)
			accept_button.set_text("Cannot Trade (%s short $%d)" % [Global.current_character.get_name(), (abs(money_owed) - Global.current_character.money)])
		else: # character has extra money to make up the difference
			accept_button.set_disabled(false)
			accept_button.set_text("Accept Trade (Receive $%d)" % abs(money_owed))
			
		# Change cancel button to a generous trade option
		cancel_button.set_text("Generous Trade (Receive no money)")
	elif player_table_value < npc_table_value: # player will owe npc money
		player_table_value_label.add_color_override("font_color", Color.red)
		npc_table_value_label.add_color_override("font_color", Color.green)
		
		money_owed = npc_table_value - player_table_value
		if money_owed > Global.player.money: # player does not have enough funds to make this trade happen
			accept_button.set_disabled(true)
			accept_button.set_text("Cannot Accept Trade (Short $%d)" % (money_owed - Global.player.money))
		else: # player has extra money to make up the difference
			accept_button.set_disabled(false)
			accept_button.set_text("Accept Trade (Pay $%d)" % money_owed)
			
		# restore actual cancel functionality
		cancel_button.set_text("Cancel Trade")
	else:
		player_table_value_label.add_color_override("font_color", Color.white)
		npc_table_value_label.add_color_override("font_color", Color.white)
		
		money_owed = 0
		accept_button.set_disabled(false)
		accept_button.set_text("Accept Trade")
		
		# restore actual cancel functionality
		cancel_button.set_text("Cancel Trade")

# Move Item to a Container ( calls add_to_container() remove_from_root() )
func move_to_container(item_rect, container):
	remove_from_root(item_rect)
	add_to_container(item_rect, container)
	_on_item_icon_unhover(item_rect)
	update_table_values()

# Add Item to Container
func add_to_container(item_rect, container):
	# add to list associated with contianer
	add_to_list(focused_item, get_item_list(container))
	
	var item_container = HBoxContainer.new()
	item_container.alignment = BoxContainer.ALIGN_CENTER
	item_container.add_child(item_rect)
	
	container.add_child(item_container)

# Remove Item From Container (Origin Container)
func remove_from_container(item_rect):
	# remove from list associated with contianer
	var item_index = get_item_index(item_rect)
	
	var item_hbox = item_rect.get_parent()
	origin_container = item_hbox.get_parent()
	item_hbox.remove_child(item_rect)
	origin_container.remove_child(item_hbox)
	
	# remove from list associated with contianer
	remove_from_list(item_index, get_item_list(origin_container))
	
func item_source(item_rect) -> Item:
	var item_index = get_item_index(item_rect)
	var item_hbox = item_rect.get_parent()
	origin_container = item_hbox.get_parent()
	var item = get_item_list(origin_container)[item_index]
	return item
	
# Add Item to Root
func add_to_root(item_rect):
	add_child(item_rect)
	
# Remove Item From Root
func remove_from_root(item_rect):
	remove_child(item_rect)

# Follow mouse
func follow_mouse(item_rect):
	var position = get_global_mouse_position()
	item_rect.set_position(position - item_rect.rect_size/2)

# Check if Mouse In Bounds of Container (the vbox)
func mouse_in_bounds(container):
	return container.get_parent().get_rect().has_point(get_global_mouse_position())

# Item Hover Signals
func _on_item_icon_hover(item_rect):
	if dragging == false:
		item_rect.rect_scale = Vector2(1.1, 1.1)
		mouse_in = true
		focused_item_rect = item_rect
		
		var item = item_source(item_rect)
		item_info.bbcode_text = "[center]" + str(item.itemName) + "  -  " + str(item.itemValue) + "[/center]"

func _on_item_icon_unhover(item_rect):
	item_rect.rect_scale = Vector2(1, 1)
	mouse_in = false

# Functions to actually perform the trade
func remove_traded_p_l_items(): # remove traded player/location items from their original lists
	# Remove traded player inventory items from global player inventory
	var new_pInventory = [] # new global player inventory
	var new_player_weight = 0 # player weight fix???
	for item in playerInventoryItems:
		if Global.player.inventory.has(item): # item came from global player inventory
			new_pInventory.append(item)
			new_player_weight += item.get_weight() # player weight fix???
	Global.player.inventory = new_pInventory
	Global.player.set_weight(new_player_weight) # player weight fix???
	
	# Remove traded location items from global location items inventory
	var new_lInventory = [] # new global location items inventory
	for item in playerInventoryItems:
		if Global.current_location.locationItems.has(item): # item came from global location items inventory
			new_lInventory.append(item)
	Global.current_location.locationItems = new_lInventory

func swap_table_items(): # give player table items to npc inventory, give npc table items to location items array
	for item in playerTableItems:
		Global.current_character.inventory.append(item)
	
	for item in npcTableItems:
		Global.current_location.locationItems.append(item)

# Button Events
func _accept_button_pressed():
	# debug print statements
	print("Inventories right before swap:")
	print("Location Items:", Global.current_location.locationItems)
	print("Player Inventory:", Global.player.inventory)
	print("pContainer Inventory:", playerInventoryItems)
	print("NPC Items:", Global.current_character.inventory)
	
	# Actually perform the item swaps
	remove_traded_p_l_items()
	swap_table_items()
	
	# debug print statements
	print("Inventories after the trade:")
	print("Location Items:", Global.current_location.locationItems)
	print("Player Inventory:", Global.player.inventory)
	print("NPC Items:", Global.current_character.inventory)
	
	# Deduct any money the player owed the NPC
	if money_owed > 0:
		Global.player.money -= money_owed
		Global.current_character.money += money_owed
	# Deduct any money the NPC owed the player
	elif money_owed < 0:
		Global.player.money += abs(money_owed)
		Global.current_character.money -= abs(money_owed)
	
	print("Player money after trade: " + str(Global.player.money)) # debug money check
	print("Character money after trade: " + str(Global.current_character.money)) # debug money check
	
	Global.goto_scene("res://EventScene.tscn") # <- change this to the appropriate scene later

func _cancel_button_pressed():
	# If the cancel button's state is the generous trade option, just exchange the items (no money +/-) and go back to EventScene
	if cancel_button.get_text() == "Generous Trade (Receive no money)":
		# Actually perform the item swaps
		remove_traded_p_l_items()
		swap_table_items()
		Global.goto_scene("res://EventScene.tscn")
		return
	
	# Global player inventory and global location items arrays are preserved since deep copy was made for the playerInventoryItems array
	# in other words, the original arrays are unmodified until trade acceptance/cancellation.
	
	# Global character inventory DOES get changed as items are dragged to and from it, so npc table items must be returned to npc inventory
	for item in npcTableItems:
		Global.current_character.inventory.append(item)
	
	# debug print statements
	print("Inventories after trade cancellation:")
	print("Location Items:", Global.current_location.locationItems)
	print("Player Inventory:", Global.player.inventory)
	print("NPC Items:", Global.current_character.inventory)
	
	Global.goto_scene("res://EventScene.tscn") # <- change this to the appropriate scene later
