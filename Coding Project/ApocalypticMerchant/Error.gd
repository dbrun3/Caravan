extends TextureRect


func _ready():
	Global.player.connect("send_needs_repair", self, "_on_player_send_repair_state")


func _on_player_send_repair_state(needs_repair):
	if needs_repair:
		self.visible = true
	else:
		self.visible = false
