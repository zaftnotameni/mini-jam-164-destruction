class_name DroppableOrb extends ColorRect

@export var elements : Array[FireworkData.Element]
var parent : Color_Mixer

func _enter_tree() -> void:
	add_to_group('color-mixer-droppable-orb')
	parent = get_parent()
	if not elements: elements = []
	update_color_based_on_elements()

func _notification(what: int) -> void: ToolScriptHelpers.on_pre_save(what, on_pre_save)

func on_pre_save():
	if not ToolScriptHelpers.is_valid_tool_target(self): return
	update_color_based_on_elements()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is FireworkData.Element

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	assert(data is FireworkData.Element, 'data must be Element')
	elements.push_back(data)
	update_color_based_on_elements()

func update_color_based_on_elements():
	material.set_shader_parameter('frontFillInnerColour', ColorMixingLogic.mix_elements(elements))
	material.set_shader_parameter('backFillColour', ColorMixingLogic.mix_elements(elements).lightened(0.2))
	material.set_shader_parameter('fill_value', -1 + (elements.size() * 0.10))
	parent.current_color = ColorMixingLogic.mix_elements(elements)
