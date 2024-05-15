extends TextureButton

var player
var scene = null
var idle

func _ready():
	scene = get_tree().get_root().get_node("Navigation")
	scene.connect("player_added", self, "_on_player_added")

func _on_player_added():
	player = get_tree().get_root().get_node("Navigation/Player")
	player.connect("send_idle", self, "_on_player_send_idle")

func _on_player_send_idle(idleBool):
	self.disabled = !idleBool

func _on_EnterLocation_pressed():
	Global.enterLocationButtonPressed = true
	if Global.player.idle == true:
		print("Player entered ", Global.current_location.get_name())
		Global.cameraPosition = self.get_parent().get_parent().get_parent().get_node("RTS-Camera2D").position
		Global.location_manager.save_location_nodes()
		Global.goto_scene("res://EventScene.tscn")
		Fade.fade_out(1)
