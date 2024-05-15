extends Timer

var player
var isIdle
var scene = null
var shouldMove

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player
	shouldMove = player.get_move()
	scene = get_tree().get_root().get_node("Navigation")
	scene.connect("send_idle", self, "_on_player_send_idle")
	scene.connect("send_move", self, "_on_player_send_move")

func _on_GasTimer_timeout():
	if !isIdle and shouldMove:
		return

func _on_player_send_idle(idle):
	isIdle = idle

func _on_player_send_move(move):
	shouldMove = move
