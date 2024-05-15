extends AudioStreamPlayer


const mp3 = preload("res://assets/music/wasteland.mp3")


func play_music():
	
	if stream == mp3:
		return
	
	stream = mp3
	volume_db = -10
	play()
