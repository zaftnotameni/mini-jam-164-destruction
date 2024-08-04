@tool
class_name DraggableOrb extends ColorRect

@export var element : FireworkData.Element

func _enter_tree() -> void:
	material = AutoloadMaterials.color_in_orb
	update_color_based_on_element()

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(duplicate())
	return element

func update_color_based_on_element():
	material.set_shader_parameter('frontFillInnerColour', ColorMixingLogic.mix_elements([element]))

