extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var purchasedText = "Skill: Inventory Upgrade 2\n\nIncreases inventory slots by 12\n\nPurchased"
var cost = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.purchasedSkills.has(get_parent().name):
		self.disabled = false
	else:
		self.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reenterSceneDisable():
	self.disabled = true
	get_node("SlotIncrease2Description").text = purchasedText

func _on_SlotIncrease2_pressed():
	print("Pressed slot upgrade 2")
	var skill_tree = get_parent().get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		Global.additionalInventorySlots = Global.additionalInventorySlots + 12
		self.disabled = true
		get_node("SlotIncrease2Description").text = purchasedText
		Global.purchasedSkills.append("SlotIncrease1/SlotIncrease2")
	else:
		print("Not enough money")


func _on_SlotIncrease2_mouse_entered():
	get_parent().get_parent().get_node("DescriptionBackground").visible = true
	get_node("SlotIncrease2Description").visible = true

func _on_SlotIncrease2_mouse_exited():
	get_parent().get_parent().get_node("DescriptionBackground").visible = false
	get_node("SlotIncrease2Description").visible = false
