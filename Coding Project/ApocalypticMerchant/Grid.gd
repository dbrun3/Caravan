extends Node2D


func _draw() -> void:
	#draw vertical lines
	for i in Global.total_cells.x:
		var from := Vector2((i * Global.cell_size.x) - (Global.map_size.x / 2), -(Global.map_size.y / 2))
		var to := Vector2(from.x, Global.map_size.y / 2)
		draw_line(from, to, Color(0,0,0,0.1))
		
	#draw horizontal lines
	for j in Global.total_cells.y:
		var from := Vector2(-(Global.map_size.x / 2), (Global.cell_size.y * j) - Global.map_size.y / 2)
		var to := Vector2(Global.map_size.x / 2, from.y)
		draw_line(from, to, Color(0,0,0,0.1))
