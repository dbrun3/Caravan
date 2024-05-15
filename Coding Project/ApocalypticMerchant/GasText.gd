extends RichTextLabel

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "> Gas:        " + str(floor(player.get_gas())) + "/" + str(player.get_max_gas())