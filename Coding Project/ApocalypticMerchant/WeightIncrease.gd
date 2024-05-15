extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 1000
var purchasedText = "Skill: Weight Capacity Upgrade 1\n\nIncreases weight capacity of the caravan by 50%\n\nPurchased"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reenterSceneDisable():
	self.disabled = true
	get_node("WeightIncreaseDescription").text = purchasedText

func _on_WeightIncrease_pressed():
	var skill_tree = get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		Global.player.max_weight_capacity = Global.player.max_weight_capacity * 1.5
		self.disabled = true
		get_node("WeightIncreaseDescription").text = purchasedText
		Global.purchasedSkills.append("WeightIncrease")
		get_node("WeightIncrease2").disabled = false
	else:
		print("Not enough money")


func _on_WeightIncrease_mouse_entered():
	get_parent().get_node("DescriptionBackground").visible = true
	get_node("WeightIncreaseDescription").visible = true


func _on_WeightIncrease_mouse_exited():
	get_parent().get_node("DescriptionBackground").visible = false
	get_node("WeightIncreaseDescription").visible = false
