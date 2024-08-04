extends HBoxContainer

signal new_shape_update(path : String)

var texture_path : String:
	set(new_value):
		texture_path = new_value
		new_shape_update.emit(new_value)
