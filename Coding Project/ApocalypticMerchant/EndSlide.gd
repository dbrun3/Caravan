extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text = null
var slides: Array
var index = 0
var texts = [["For restoring their power the remnants accepted you with open arms, making you an official member of their clergy","After many years of service, you eventually bring them out of the mountain they had spent all their lives in. But they were not prepared for the wasteland that they had left for so many years in the dark.", "They retreated back into the cave they spent their entire lives in, and would now spend the rest of their days there too..."],["With the power of the Remnant's reactor, the Executive's factories were now fully operational.", "His empire expanded, his force of scavengers spreading outside of the City limits, taking Mats with them. It wasn't long before the rest of the wasteland was hooked.", "There were few who resisted temptation, but none could resist the might of his soldiers. They were property of Kronus, and for the rest of their lives lived under the Executive's gaze."],["Utilizing the Remnant's electricity, Independence went from a wasteland legend to a household name, drawing in traders, craftsman and all who wish to use this power to rebuild a better world.", "It also attracted those who wished to take it for themselves. The residents of Independence would constantly have to fight off raiders, and soon traveling to Independence became a dangerous task. Many left.", "It wasn't long before the City caught wind of Independence's power and its weakened fighting force. They launched a single attack at night and by that morning the Deadwood's name had never rung more true."],["With a single handshake, the nation of the Independant Salvaged States was born. Mayor Adams became President Adams, and the Colonel, his General.", "With the General's troops now defending the border of the Deadwood, the ISS's power was safeguarded from both raiders and the Executive's army.", "Without the threat of war, its economy thrived, drawing in traders, craftsman and refugees from the City looking for better work. Lacking a workforce, the City collapsed in on itself and soon became a memory many would choose to forget."],["Activating the weapon they called the Reclaimer, the Salvaged States of America launched a full-scale attack on the City. With his tower destroyed and army defeated, the Executive was taken prisoner.", "After the smoke had cleared, the Colonel sent his men to collect any survivors and eliminate any remaining Kronus Loyalists, but they had found none.", "The Executive faced a brief trial before being promptly executed by firing squad. The moment the last bullet was fired, not a single person from the City remained, and death had claimed the metropolis once again."],["You have died. Your cargo becomes a prize for those starting a life like your own and your bones a cautionary tale..."]]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	text = get_parent().get_child(1).get_child(0)
	
	if Global.ending == -1:
		print("ERROR NO ENDING SET")
		return
	

	var path = "assets/endings/" + str(Global.ending) + "/"

	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			slides.append(ResourceLoader.load(path + file_name))
	dir.list_dir_end()
	self.texture_normal = slides[index]
	self.text.bbcode_text = "[center]" + texts[Global.ending][index / 2] + "[/center]"


func _on_Fade_Timer():
	Fade.fade_in(2)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	index += 2
	if index / 2 == texts[Global.ending].size():
		Global.goto_scene("res://MainMenu.tscn")
		return
	self.text.bbcode_text = "[center]" + texts[Global.ending][index / 2] + "[/center]"	
	self.texture_normal = slides[index]

func _on_EndSlide_button_down():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Fade.fade_out(2)
	var timer := Timer.new()
	timer.wait_time = 3 # 2 second
	timer.one_shot = true # don't loop, run once
	timer.autostart = true # start timer when added to a scene
	timer.connect("timeout", self, "_on_Fade_Timer")
	add_child(timer)
