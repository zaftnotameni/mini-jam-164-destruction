extends VBoxContainer

const firework_scene := preload('res://game/firework/firework.tscn')

func _enter_tree() -> void:
	for firework_data in __library.firework_library.my_fireworks:
		var btn := TextureButton.new()
		btn.texture_normal = firework_data.explosion_textures[0]
		btn.texture_pressed = firework_data.explosion_textures[0]
		btn.texture_hover = firework_data.explosion_textures[0]
		btn.texture_disabled = firework_data.explosion_textures[0]
		btn.texture_focused = firework_data.explosion_textures[0]
		btn.self_modulate = firework_data.explosion_color
		btn.pressed.connect(on_button_pressed.bind(firework_data))
		add_child.call_deferred(btn)

func on_button_pressed(firework_data:FireworkResource):
	var glopos : Vector2 = %CreateFireworkAt.global_position
	var firework : FireworkScene = firework_scene.instantiate()
	firework.firework_data = firework_data
	firework.global_position = glopos
	get_tree().get_first_node_in_group('fireworks-layer').add_child(firework)
