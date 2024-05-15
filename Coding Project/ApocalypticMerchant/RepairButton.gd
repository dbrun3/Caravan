extends TextureButton

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player


func _on_RepairButton_pressed():
	if player.has_item("Small Repair Kit"):
		player.durability += 25
		if player.durability > player.max_durability:
			player.durability = player.max_durability
		player.remove_item("Small Repair Kit")
		print("Repaired")
	elif player.has_item("Large Repair Kit"):
		player.durability += 50
		if player.durability > player.max_durability:
			player.durability = player.max_durability
		player.remove_item("Large Repair Kit")
		print("Repaired")
	else:
		print("No gas in inventory!")
