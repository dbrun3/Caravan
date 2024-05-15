extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 1000
var purchasedText = "Skill: Fuel Capacity Upgrade 1\n\nIncreases fuel tank capacity by 10%\n\nPurchased"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reenterSceneDisable():
	self.disabled = true
	get_node("TankCapacity1Description").text = purchasedText
	
func _on_TankCapacity1_pressed():
	var skill_tree = get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		Global.player.max_gas_capacity = Global.player.max_gas_capacity * 1.1
		self.disabled = true
		get_node("TankCapacity1Description").text = purchasedText
		Global.purchasedSkills.append("TankCapacity1")
		get_node("TankCapacity2").disabled = false
	else:
		print("Not enough money")


func _on_TankCapacity1_mouse_entered():
	get_parent().get_node("DescriptionBackground").visible = true
	get_node("TankCapacity1Description").visible = true


func _on_TankCapacity1_mouse_exited():
	get_parent().get_node("DescriptionBackground").visible = false
	get_node("TankCapacity1Description").visible = false
