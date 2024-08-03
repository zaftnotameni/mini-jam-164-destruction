## this can be attached to any node and it will make the node follow the mouse pointer
class_name BehaviorFollowsMouse extends Node2D

@export var target : Node2D

func _ready() -> void:
	if not target: target = get_parent()

## todo: this needs to be adjusted in case we have a camera
func _process(_delta: float) -> void:
	target.global_position = get_viewport().get_mouse_position()
