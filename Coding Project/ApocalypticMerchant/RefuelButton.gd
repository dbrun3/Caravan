extends TextureButton

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player

func _on_RefuelButton_pressed():
	if player.has_item("Gas"):
		player.add_gas(2000)
		player.remove_item("Gas")
		print("Refueled")
	else:
		print("No gas in inventory!")
