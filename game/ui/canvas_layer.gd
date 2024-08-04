extends CanvasLayer

@onready var name_line: LineEdit = %NameLine

func _process(delta: float) -> void:
	if name_line.text != "" :
		%Button.disabled = false


func _on_button_pressed() -> void:
	Global.player_name = name_line.text
	hide()
