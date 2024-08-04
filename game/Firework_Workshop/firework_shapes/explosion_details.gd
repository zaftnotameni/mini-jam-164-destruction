extends VBoxContainer

const EXPLOSION_SPRITE = preload("res://game/Firework_Workshop/firework_shapes/explosion_sprite.tscn")
var texture_path = "res://game/assets/fireworks/shape_"

func _ready() -> void:
	for i in range(1,52):
		var texture__to_load_path = texture_path + str(i) + ".png"
		var temp_sprite = EXPLOSION_SPRITE.instantiate()
		temp_sprite.icon = load(texture__to_load_path)
		%Sprites.add_child(temp_sprite)
