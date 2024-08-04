extends CanvasLayer

signal scene_transitioning(new_scene_path)

@onready var _fade_animation:AnimationPlayer = $fadeAnimation
@onready var loading_bar : ProgressBar = $Loading
@onready var is_loading := false

var scene_load_status = 0
var _scene_path := ""
var progress = []
var progress_value = 0
var previous_progress_value = 0


func _process(_delta):
	if !is_loading:
		return
	_load_scene()
	

func transition_to(scene_path: String):
	_scene_path = scene_path
	_load()
	
	

func _load():
	is_loading = true
	_fade_animation.play("fadeOut")
	loading_bar.visible = true
	get_tree().paused = true
	ResourceLoader.load_threaded_request(_scene_path)
	
	
func _load_scene():
	scene_load_status = ResourceLoader.load_threaded_get_status(_scene_path, progress)
	
	
	if progress[0] < 1:
		var new_progress_value = floor(progress[0] * 100)

		if new_progress_value > previous_progress_value:
			progress_value = new_progress_value
			previous_progress_value = new_progress_value
		elif new_progress_value < previous_progress_value:
			progress_value = previous_progress_value
		else:
			progress_value = previous_progress_value
		
	else :
		progress_value += randi_range(0,1)
	
	
	loading_bar.value = progress_value
	
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		if loading_bar.value >= 100:
			_loaded()


func _loaded():
	var result = ResourceLoader.load_threaded_get(_scene_path)
	scene_transitioning.emit(_scene_path)
	var results_err_check = get_tree().change_scene_to_packed(result)
	if results_err_check != OK:
		printerr("TransitionMgr: could not change to scene '%s'" % _scene_path)
		return
	_reset()
	_fade_animation.play("fadeIn")

func _reset():
	loading_bar.visible = false
	is_loading = false
	get_tree().paused = false
	scene_load_status = 0
	progress = []
	progress_value = 0
	previous_progress_value = 0
	
