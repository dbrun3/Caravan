extends VBoxContainer

var player
var scene = null

func _ready():
	scene = get_tree().get_root().get_node("Navigation")
	scene.connect("player_added", self, "_on_player_added")

func _on_player_added():
	player = get_tree().get_root().get_node("Navigation/Player")

func _on_Buttons_mouse_entered():
	player.set_click(false)

func _on_Buttons_mouse_exited():
	player.set_click(true)
