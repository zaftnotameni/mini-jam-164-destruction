class_name Workshop_Panel extends CanvasLayer
const FIREWORK_EXPLOSION = preload("res://game/Firework_Workshop/firework_explosion/firework_explosion.tscn")


var explosion: CPUParticles2D

#func _ready() -> void:
	#current_explosion = FIREWORK_EXPLOSION.instantiate()
	#explosion_pannel.add_child(current_explosion)
	#current_explosion.self_modulate = Color.RED


func _on_button_pressed() -> void:
	explosion = FIREWORK_EXPLOSION.instantiate()
	%explosion.add_child(explosion)
	%Firework_Button.hide()
	%Color_Mixer.show()


func _on_color_mixer_new_color_update(new_color: Color) -> void:
	if explosion:
		explosion.self_modulate = new_color
	
