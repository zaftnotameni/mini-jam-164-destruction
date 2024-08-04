class_name Color_Mixer extends VBoxContainer

signal new_color_update(new_color : Color)

@export var current_color : Color = Color.WHITE:
	set(new_value):
		current_color = new_value
		new_color_update.emit(new_value)
