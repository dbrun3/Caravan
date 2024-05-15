extends TextureButton

var player
var canMove
var canStop: bool
var firstMarkerMove

# Sets references to the scene and connects to signal "player_added" from Navigation.gd
func _ready():
	player = Global.player
	player.connect("send_first", self, "_on_player_send_first")
	player.connect("send_idle", self, "_on_player_send_idle")
	player.connect("send_needs_repair", self, "_on_player_send_repair_state")
	canStop = false
	firstMarkerMove = false

func _on_player_send_first(first):
	firstMarkerMove = first

func _on_player_send_idle(idle):
	if idle:
		canStop = false
	else:
		canStop = true

func _on_player_send_repair_state(needs_repair):
	if needs_repair:
		self.disabled = true
	else:
		self.disabled = false


func _on_Move_pressed():
	if !firstMarkerMove:
		return
	if !canStop:
		player.set_move(true)
		var targetPosition = (player.moveMarker.position - player.position).normalized()
		player.player_not_idle(targetPosition, player.get_speed())
		player.remove_durability()
		canStop = true
	else:
		player.player_idle()
		player.set_move(false)
		canStop = false
