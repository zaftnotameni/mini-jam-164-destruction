class_name AutoloadBus extends Node

@warning_ignore('unused_signal')
signal sig_smoke_emission_requested(amount:float,tint:Color,time:float)

func _enter_tree() -> void:
	add_to_group('bus')
	
static func scene_tree() -> SceneTree: return Engine.get_main_loop() as SceneTree
static func current_scene() -> Node2D: return scene_tree().current_scene
