extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var money_label = get_node("PlayerMoney")
	money_label.text = "$" + str(Global.player.money)
	for skill in Global.purchasedSkills:
		get_node(skill).reenterSceneDisable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateMoneyDisplayed():
	var money_label = get_node("PlayerMoney")
	money_label.text = "$" + str(Global.player.money)

func processUpgrade(cost):
	var new_balance = Global.player.money - cost
	if new_balance < 0:
		return false
	Global.player.money = new_balance
	return true
