extends Button

var icon_path : String


func _on_pressed() -> void:
	get_parent().texture_path = icon_path 
