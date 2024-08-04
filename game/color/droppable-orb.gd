@tool
class_name DroppableOrb extends ColorRect

@export var elements : Array[FireworkData.Element]

func _enter_tree() -> void:
	if not elements: elements = [FireworkData.Element.Mg]
	update_color_based_on_elements()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is FireworkData.Element

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	assert(data is FireworkData.Element, 'data must be Element')
	elements.push_back(data)
	update_color_based_on_elements()

func update_color_based_on_elements():
	material.set_shader_parameter('frontFillInnerColour', ColorMixingLogic.mix_elements(elements))
	material.set_shader_parameter('fill_value', -1 + (elements.size() * 0.10))

