class_name AutoloadAudio extends Node

static var sfx_match_fire : AudioStreamWAV = load('res://game/assets/audio/match_fire.wav')
static var sfx_smoke : AudioStreamWAV = load('res://game/assets/audio/smoke.wav')

static func play_once_and_free(sfx:AudioStream):
	var asp := AudioStreamPlayer.new()
	asp.stream = sfx
	asp.autoplay = true
	asp.finished.connect(asp.queue_free)
	current_scene().add_child(asp)

static func scene_tree() -> SceneTree: return Engine.get_main_loop() as SceneTree
static func current_scene() -> Node2D: return scene_tree().current_scene
