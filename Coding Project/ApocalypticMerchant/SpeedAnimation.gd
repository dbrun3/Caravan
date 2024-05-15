extends AnimatedSprite

# Member variables
var player
var speed: float
var max_speed: float
var startMoving: bool

func _ready():
	player = Global.player
	startMoving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.idle == false:
		if !startMoving:
			anim_start()
			startMoving = true
			return
		determine_frame()
		return
	else:
		if startMoving:
			anim_stop()
			startMoving = false
		return

#
# anim_stop()
#
# Animates the speed gauge to go from max speed to 0.
# Modify the .create_timer() param to change how fast it is.
#
func anim_stop():
	while self.frame != 0:
		yield(get_tree().create_timer(0.05), "timeout")
		self.set_frame(self.frame - 1)

#
# anim_start()
#
# Animates the speed gauge to go from 0 to max_speed.
# Modify the .create_timer() param to change how fast it is.
#
func anim_start():
	while self.frame != determine_frame():
		yield(get_tree().create_timer(0.1), "timeout")
		self.set_frame(self.frame + 1)

#
# determine_frame
#
# Determines what frame to display on the speed gauge
#
func determine_frame() -> int:
	# update current gas value
	self.speed = player.get_speed()
	self.max_speed = 345
	var meterPortion: float = self.max_speed * 0.08333 # Set to 1/12th of the max gas
	if self.speed == self.max_speed:
		self.set_frame(13)
		return self.frame
	elif self.speed < self.max_speed && self.speed >= (meterPortion * 12):
		self.set_frame(12)
		return self.frame
	elif self.speed < (meterPortion * 12) && self.speed >= (meterPortion * 11):
		self.set_frame(11)
		return self.frame
	elif self.speed < (meterPortion * 11) && self.speed >= (meterPortion * 10):
		self.set_frame(10)
		return self.frame
	elif self.speed < (meterPortion * 10) && self.speed >= (meterPortion * 9):
		self.set_frame(9)
		return self.frame
	elif self.speed < (meterPortion * 9) && self.speed >= (meterPortion * 8):
		self.set_frame(8)
		return self.frame
	elif self.speed < (meterPortion * 8) && self.speed >= (meterPortion * 7):
		self.set_frame(7)
		return self.frame
	elif self.speed < (meterPortion * 7) && self.speed >= (meterPortion * 6):
		self.set_frame(6)
		return self.frame
	elif self.speed < (meterPortion * 6) && self.speed >= (meterPortion * 5):
		self.set_frame(5)
		return self.frame
	elif self.speed < (meterPortion * 5) && self.speed >= (meterPortion * 4):
		self.set_frame(4)
		return self.frame
	elif self.speed < (meterPortion * 4) && self.speed >= (meterPortion * 3):
		self.set_frame(3)
		return self.frame
	elif self.speed < (meterPortion * 3) && self.speed >= (meterPortion * 2):
		self.set_frame(2)
		return self.frame
	elif self.speed < (meterPortion * 2) && self.speed >= (meterPortion):
		self.set_frame(2)
		return self.frame
	elif self.speed < (meterPortion):
		self.set_frame(0)
		return self.frame
	else:
		print("SPEED_ANIMATION: determine_frame() error")
		return -1
