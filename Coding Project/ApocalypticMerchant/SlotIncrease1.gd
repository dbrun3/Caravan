extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var purchasedText = "Skill: Inventory Upgrade 1\n\nIncreases inventory slots by 12\n\nPurchased"
var cost = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SlotIncrease1_pressed():
	print("Pressed slot upgrade 1")
	var skill_tree = get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		Global.additionalInventorySlots = Global.additionalInventorySlots + 12
		self.disabled = true
		get_node("SlotIncrease1Description").text = purchasedText
		Global.purchasedSkills.append("SlotIncrease1")
		get_node("SlotIncrease2").disabled = false
	else:
		print("Not enough money")

func reenterSceneDisable():
	self.disabled = true
	get_node("SlotIncrease1Description").text = purchasedText
	
	
func _on_SlotIncrease1_mouse_entered():
	get_parent().get_node("DescriptionBackground").visible = true
	get_node("SlotIncrease1Description").visible = true


func _on_SlotIncrease1_mouse_exited():
	get_parent().get_node("DescriptionBackground").visible = false
	get_node("SlotIncrease1Description").visible = false
