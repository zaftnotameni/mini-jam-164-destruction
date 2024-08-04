extends TextureButton

const wss := preload('res://game/Firework_Workshop/workshop.tscn')
const firework_scene := preload('res://game/firework/firework.tscn')

@onready var tl : Marker2D = %TL
@onready var br : Marker2D = %BR

var x_min : float
var x_max : float
var y_min : float
var y_max : float

var fireworks_per_second : float = 0.20
var fireworks_per_second_per_second : float = 0.0001
var max_fireworks_per_second : int = 2
var max_fireworks: int = 200
var elapsed_since_last : float = 0

func spawn_random_firework():
	if get_tree().get_node_count_in_group('fireworks-layer') >= max_fireworks: return
	if not __library.firework_library: return
	if not __library.firework_library.my_fireworks: return
	if __library.firework_library.my_fireworks.is_empty(): return
	var x = randf_range(x_min, x_max)
	var y = randf_range(y_min, y_max)
	var glopos : Vector2 = Vector2(x,y)
	var firework : FireworkScene = firework_scene.instantiate()
	firework.firework_data = __library.firework_library.my_fireworks.pick_random()
	firework.global_position = glopos
	get_tree().get_first_node_in_group('fireworks-layer').add_child(firework)

func on_pressed():
	owner.add_child(wss.instantiate())

func _ready() -> void:
	pressed.connect(on_pressed)
	x_min = [tl.global_position.x, br.global_position.x].min()
	x_max = [tl.global_position.x, br.global_position.x].max()
	y_min = [tl.global_position.y, br.global_position.y].min()
	y_max = [tl.global_position.y, br.global_position.y].max()

func _physics_process(delta: float) -> void:
	fireworks_per_second += fireworks_per_second_per_second * delta
	if fireworks_per_second > max_fireworks_per_second: fireworks_per_second = max_fireworks_per_second
	elapsed_since_last += delta
	if elapsed_since_last >= 1.0/fireworks_per_second:
		spawn_random_firework()
		elapsed_since_last = 0

func _process(_delta: float) -> void:
	%FirstFireworkLabel.visible = __library.firework_library.my_fireworks.is_empty()
	if not %FirstFireworkLabel.visible: set_process(false)

