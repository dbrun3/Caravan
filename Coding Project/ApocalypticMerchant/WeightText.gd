extends RichTextLabel

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = Global.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "> Weight:          " + str(player.get_weight()) + "/" + str(player.get_max_weight()) + " kg"
