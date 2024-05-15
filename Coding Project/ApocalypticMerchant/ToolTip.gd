extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var slides: Array
var on: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.current_tool > 9:
		self.queue_free()
		return
	
	var path = "assets/tooltip/"
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
	self.texture = slides[Global.current_tool]
	self.visible = true
	on = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventMouseButton && on:
		self.visible = false
		on = false
		Global.current_tool += 2
