class_name DraggableOrb extends ColorRect

@export var element : FireworkData.Element

func _enter_tree() -> void:
	update_color_based_on_element()

func _notification(what: int) -> void: ToolScriptHelpers.on_pre_save(what, on_pre_save)

func _ready() -> void:
	update_color_based_on_element()

func on_pre_save():
	if not ToolScriptHelpers.is_valid_tool_target(self): return
	update_color_based_on_element()

func _get_drag_data(_at_position: Vector2) -> Variant:
	var ghost := duplicate()
	ghost.custom_minimum_size = Vector2(32, 32)
	ghost.size = Vector2(32, 32)
	ghost.set_anchors_and_offsets_preset(PRESET_CENTER, PRESET_MODE_MINSIZE)
	set_drag_preview(ghost)
	return element

func update_color_based_on_element():
	get_node('Label').text = FireworkData.Element.find_key(element)
	material.set_shader_parameter('fill_value', 0.5)
	material.set_shader_parameter('frontFillInnerColour', ColorMixingLogic.mix_elements([element]))
	material.set_shader_parameter('backFillColour', ColorMixingLogic.mix_elements([element]).lightened(0.2))
