extends Button

func _get_drag_data(at_position: Vector2) -> Variant:
	var color = Color.RED
	if name == 'BtnGreen': color = Color.GREEN
	if name == 'BtnBlue': color = Color.BLUE
	var scn = load('res://game/test/color_rect.tscn')
	var x: ColorRect = scn.instantiate()
	x.material.set_shader_parameter('frontFillInnerColour', color)
	set_drag_preview(x)
	return color

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print(data)
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	print(data)
