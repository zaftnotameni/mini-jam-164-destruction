class_name SmokeOverlayScene extends Control

func _ready() -> void:
	__bus.sig_smoke_emission_requested.connect(on_emission_requested)

func on_emission_requested(amount:float=0.0, color:Color=Color.HOT_PINK, time:float=5):
	var rect := ColorRect.new()
	rect.color = color
	rect.material = AutoloadMaterials.smoke_overlay.duplicate()
	rect.custom_minimum_size = Vector2(1200, 1200)
	rect.set_anchors_and_offsets_preset(PRESET_FULL_RECT, PRESET_MODE_KEEP_WIDTH)
	rect.material.setup_local_to_scene()
	rect.material.set_shader_parameter('offset', Vector2(randf() * 100, randf() * 100))
	rect.material.set_shader_parameter('speed', Vector2(randf() * 0.1 + 0.01, randf() * 0.1 + 0.02))
	rect.material.set_shader_parameter('density', 0.0)
	get_tree().get_first_node_in_group('smoke-layer').add_child(rect)
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(rect.material, 'shader_parameter/density', amount, 0.1)
	tween.tween_property(rect.material, 'shader_parameter/density', 0.0, time)
	tween.tween_callback(rect.queue_free)
