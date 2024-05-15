extends AnimatedSprite

# Member variables
var player
var gas: float
var max_gas: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.play("default", false)
	determine_frame()
	self.stop()

func _ready():
	player = Global.player

#
# determine_frame
#
# Determines what frame to display on the fuel gauge based on gas level
#
func determine_frame():
	# update current gas value
	self.gas = player.get_gas()
	self.max_gas = player.get_max_gas()
	var meterPortion: float = self.max_gas * 0.08333 # Set to 1/12th of the max gas
	if self.gas == self.max_gas:
		self.set_frame(0)
		return
	elif self.gas < self.max_gas && self.gas >= (meterPortion * 12):
		self.set_frame(1)
		return
	elif self.gas < (meterPortion * 12) && self.gas >= (meterPortion * 11):
		self.set_frame(2)
		return
	elif self.gas < (meterPortion * 11) && self.gas >= (meterPortion * 10):
		self.set_frame(3)
		return
	elif self.gas < (meterPortion * 10) && self.gas >= (meterPortion * 9):
		self.set_frame(4)
		return
	elif self.gas < (meterPortion * 9) && self.gas >= (meterPortion * 8):
		self.set_frame(5)
		return
	elif self.gas < (meterPortion * 8) && self.gas >= (meterPortion * 7):
		self.set_frame(6)
		return
	elif self.gas < (meterPortion * 7) && self.gas >= (meterPortion * 6):
		self.set_frame(7)
		return
	elif self.gas < (meterPortion * 6) && self.gas >= (meterPortion * 5):
		self.set_frame(8)
		return
	elif self.gas < (meterPortion * 5) && self.gas >= (meterPortion * 4):
		self.set_frame(9)
		return
	elif self.gas < (meterPortion * 4) && self.gas >= (meterPortion * 3):
		self.set_frame(10)
		return
	elif self.gas < (meterPortion * 3) && self.gas >= (meterPortion * 2):
		self.set_frame(11)
		return
	elif self.gas < (meterPortion * 2) && self.gas >= (meterPortion):
		self.set_frame(12)
		return
	elif self.gas < (meterPortion):
		self.set_frame(13)
		return
	else:
		print("GAS_ANIMATION: determine_frame() error")
