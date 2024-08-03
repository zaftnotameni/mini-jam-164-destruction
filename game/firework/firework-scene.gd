class_name FireworkScene extends Node2D

@onready var explosion_trigger_area : Area2D = %ExplosionTriggerArea
@onready var light_wick_area : Area2D = %LightWickArea
@onready var firework: Area2D = %LightWickArea
@onready var party_wick_fire : CPUParticles2D = %PartyWickFire
@onready var party_rocket_fire : CPUParticles2D = %PartyRocketFire
@onready var wick : Line2D = %Wick
@onready var body : Sprite2D = %Body

var tween_light_wick : Tween
var tween_explode : Tween
var explosion : CPUParticles2D

func prepare_explosion() -> CPUParticles2D:
	explosion = __scenes.firework_explosion_scene.instantiate()
	explosion.one_shot = true
	explosion.emitting = true
	explosion.finished.connect(explosion.queue_free)
	explosion.finished.connect(self.queue_free)
	explosion.global_position = explosion_trigger_area.global_position
	get_tree().current_scene.add_child(explosion)
	return explosion

func explode_firework():
	if tween_explode: tween_explode.kill()
	if tween_light_wick: tween_light_wick.kill()
	tween_explode = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween_explode.tween_callback(body.queue_free)
	tween_explode.tween_callback(prepare_explosion)

func light_wick():
	if tween_explode: tween_explode.kill()
	if tween_light_wick: tween_light_wick.kill()
	tween_light_wick = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween_light_wick.tween_property(party_wick_fire, ^'visible', true, 0.01).from(false)
	tween_light_wick.tween_property(party_wick_fire, ^'emitting', true, 0.01).from(false)
	tween_light_wick.tween_property(party_wick_fire, ^'position', Vector2(0, 64), 5.0).from(Vector2(0, 100))
	tween_light_wick.parallel().tween_property(wick, ^'scale', Vector2(1, 0.1), 5.0).from(Vector2(1, 1))
	tween_light_wick.tween_property(party_wick_fire, ^'emitting', false, 0.01).from(true)
	tween_light_wick.parallel().tween_property(party_wick_fire, ^'visible', false, 0.01).from(true)
	tween_light_wick.parallel().tween_property(wick, ^'visible', false, 0.01).from(true)
	tween_light_wick.tween_property(party_rocket_fire, ^'visible', true, 0.5).from(false)
	tween_light_wick.tween_property(party_rocket_fire, ^'emitting', true, 0.5).from(false)
	tween_light_wick.tween_property(self, ^'position', Vector2(0, -900), 5.0).as_relative()

func on_area_entered_explosion_trigger_area(area:Area2D):
	if area.has_meta('explodes_fireworks') and area.get_meta('explodes_fireworks'): on_firework_entered_explodes_firework_area()

func on_area_entered_light_wick_area(area:Area2D):
	if area.has_meta('fire') and area.get_meta('fire'): on_fire_entered_light_wick_area()

func on_firework_entered_explodes_firework_area():
	explode_firework()

func on_fire_entered_light_wick_area():
	light_wick()

func _ready() -> void:
	light_wick_area.area_entered.connect(on_area_entered_light_wick_area)
	explosion_trigger_area.area_entered.connect(on_area_entered_explosion_trigger_area)

