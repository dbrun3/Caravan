extends TextureButton


var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HealButton_pressed():
	if player.has_item("Improvised Medkit"):
		player.health += 1
		if player.health > player.max_health:
			player.health = player.max_health
		player.remove_item("Improvised Medkit")
		print("Healed")
	elif player.has_item("Medkit"):
		player.health += 2
		if player.health > player.max_health:
			player.health = player.max_health
		player.remove_item("Medkit")
		print("Healed")
	else:
		print("No gas in inventory!")
