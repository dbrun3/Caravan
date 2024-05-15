extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 3000
var purchasedText = "Skill: Speed Upgrade 2\n\nIncreases caravan top speed by 30mph\n\nPurchased"

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
	get_node("Speed2Description").text = purchasedText

func _on_Speed2_pressed():
	print("Pressed speed upgrade 2")
	var skill_tree = get_parent().get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		var old_speed = Global.player.max_speed
		print("old speed: ", old_speed)
		var new_speed = old_speed + 30
		print("new speed: ", new_speed)
		Global.player.max_speed = new_speed
		self.disabled = true
		get_node("Speed2Description").text = purchasedText
		Global.purchasedSkills.append("Speed1/Speed2")
	else:
		print("Not enough money")


func _on_Speed2_mouse_entered():
	get_parent().get_parent().get_node("DescriptionBackground").visible = true
	get_node("Speed2Description").visible = true


func _on_Speed2_mouse_exited():
	get_parent().get_parent().get_node("DescriptionBackground").visible = false
	get_node("Speed2Description").visible = false
