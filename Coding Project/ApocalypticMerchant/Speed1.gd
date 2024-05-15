extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cost = 1000
var purchasedText = "Skill: Speed Upgrade 1\n\nIncreases caravan top speed by 15mph\n\nPurchased"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Speed1_pressed():
	print("Pressed speed upgrade 1")
	var skill_tree = get_parent()
	if skill_tree.processUpgrade(self.cost):
		skill_tree.updateMoneyDisplayed()
		var old_speed = Global.player.max_speed
		print("old speed: ", old_speed)
		var new_speed = old_speed + 15
		print("new speed: ", new_speed)
		Global.player.max_speed = new_speed
		self.disabled = true
		get_node("Speed1Description").text = purchasedText
		Global.purchasedSkills.append("Speed1")
		get_node("Speed2").disabled = false
	else:
		print("Not enough money")
		
func reenterSceneDisable():
	self.disabled = true
	get_node("Speed1Description").text = purchasedText

func _on_Speed1_mouse_entered():
	get_parent().get_node("DescriptionBackground").visible = true
	get_node("Speed1Description").visible = true


func _on_Speed1_mouse_exited():
	get_parent().get_node("DescriptionBackground").visible = false
	get_node("Speed1Description").visible = false
