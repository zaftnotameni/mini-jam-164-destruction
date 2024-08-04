class_name Workshop_Panel extends CanvasLayer
const FIREWORK_EXPLOSION = preload("res://game/Firework_Workshop/firework_explosion/firework_explosion.tscn")

@onready var name_line : LineEdit = %NameLine

var explosion: CPUParticles2D
var firework_data: FireworkResource

#func _ready() -> void:
	#current_explosion = FIREWORK_EXPLOSION.instantiate()
	#explosion_pannel.add_child(current_explosion)
	#current_explosion.self_modulate = Color.RED


func _on_button_pressed() -> void:
	explosion = FIREWORK_EXPLOSION.instantiate()
	firework_data = FireworkResource.new()
	%explosion.add_child(explosion)
	%Firework_Button.hide()
	%explosion_details.show()
	%Color_Mixer.show()


func _on_color_mixer_new_color_update(new_color: Color) -> void:
	if explosion:
		explosion.self_modulate = new_color
		firework_data.explosion_color = new_color

func _on_explosion_details_new_shape_update(path: String) -> void:
	if path:
		explosion.amount = 10
		explosion.scale_amount_min = randf_range(0.01,0.25)
		explosion.scale_amount_max = randf_range(0.30,0.5)
		explosion.texture = load(path)
		firework_data.explosion_amount = explosion.amount
		firework_data.explosion_scale_amount_min = explosion.scale_amount_min
		firework_data.explosion_scale_amount_max = explosion.scale_amount_max
		firework_data.explosion_textures = [explosion.texture]

func _on_finalize_pressed() -> void:
	if not name_line.text or name_line.text.is_empty():
		firework_data.friendly_name = 'NO NAME'
	else:
		firework_data.friendly_name = name_line.text

	firework_data.elements = get_tree().get_first_node_in_group('color-mixer-droppable-orb').elements
	__library.save_firework(firework_data)
	%Firework_Button.show()
	%explosion_details.hide()
	%Color_Mixer.hide()
	queue_free()
