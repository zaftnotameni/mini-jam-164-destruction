class_name BehaviorFollowsMouse extends Node2D

@export var target : Node2D

func _ready() -> void:
	if not target: target = get_parent()

func _process(_delta: float) -> void:
	target.global_position = get_viewport().get_mouse_position()
