extends Button

var moveMarker
var resetPosition = Vector2(8000, 8000)

func _ready():
	moveMarker = get_tree().get_root().get_node("Navigation/MoveMarker")
	print("ready")

# Runs when button is pressed
func _on_ResetMarkerButton_pressed():
	moveMarker.position = resetPosition
	print("moved")

func _process(delta):
	if moveMarker.position == resetPosition:
		self.disabled = true
	else:
		self.disabled = false
