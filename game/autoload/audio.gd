class_name AutoloadAudio extends Node

# from ZapSplat, need to add attribution to credits
static var sfx_match_fire : AudioStreamWAV = load('res://game/assets/audio/match_fire.wav')
# from ZapSplat, need to add attribution to credits
static var sfx_smoke : AudioStreamWAV = load('res://game/assets/audio/smoke.wav')
# from ZapSplat, need to add attribution to credits
static var sfx_firework_explosion_1 : AudioStreamMP3 = load('res://game/assets/audio/firework_explosion_001.mp3')
# from ZapSplat, need to add attribution to credits
static var sfx_firework_explosion_2 : AudioStreamMP3 = load('res://game/assets/audio/firework_explosion_002.mp3')

static func play_once_and_free(sfx:AudioStream):
	var asp := AudioStreamPlayer.new()
	asp.stream = sfx
	asp.autoplay = true
	asp.finished.connect(asp.queue_free)
	current_scene().add_child(asp)

static func scene_tree() -> SceneTree: return Engine.get_main_loop() as SceneTree
static func current_scene() -> Node2D: return scene_tree().current_scene
