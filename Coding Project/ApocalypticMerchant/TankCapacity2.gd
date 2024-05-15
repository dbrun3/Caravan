extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 3000
var purchasedText = "Skill: Fuel Capacity Upgrade 2\n\nIncreases fuel tank capacity by 20%\n\nPurchased"

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
	get_node("TankCapacity2Description").text = purchasedText

func _on_TankCapacity2_pressed():
	var skill_tree = get_parent().get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		Global.player.max_gas_capacity = Global.player.max_gas_capacity * 1.2
		self.disabled = true
		get_node("TankCapacity2Description").text = purchasedText
		Global.purchasedSkills.append("TankCapacity1/TankCapacity2")
	else:
		print("Not enough money")


func _on_TankCapacity2_mouse_entered():
	get_parent().get_parent().get_node("DescriptionBackground").visible = true
	get_node("TankCapacity2Description").visible = true


func _on_TankCapacity2_mouse_exited():
	get_parent().get_parent().get_node("DescriptionBackground").visible = false
	get_node("TankCapacity2Description").visible = false
