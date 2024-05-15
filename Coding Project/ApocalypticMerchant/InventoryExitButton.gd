extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InventoryExitButton_pressed():
	if Global.player.hasTraded && !Global.player.needs_repair:
		Global.player.hasTraded = false
		Global.goto_scene("res://Navigation.tscn")
	else:
		Global.goto_scene("res://EventScene.tscn")
