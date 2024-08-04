extends ColorRect

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Color

func _drop_data(at_position: Vector2, data: Variant) -> void:
	material.set_shader_parameter('frontFillInnerColour', data)
