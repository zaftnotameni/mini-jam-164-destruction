@tool
class_name ToolScriptHelpers extends Node

static func on_pre_save(what: int, fn:Callable) -> void: if what == NOTIFICATION_EDITOR_PRE_SAVE: await fn.call()

static func tool_add_child(parent:Node, child:Node, custom_owner:Node=null):
	if custom_owner and not is_valid_tool_target(custom_owner): return
	if not custom_owner and not is_valid_tool_target(parent): return
	parent.add_child.call_deferred(child)
	await child.ready
	child.owner = custom_owner if custom_owner else parent.get_tree().edited_scene_root

static func is_valid_tool_target(node:Node) -> bool:
	if not node: return false
	if not node.get_tree(): return false
	if not Engine.is_editor_hint(): return false
	if node.get_tree().edited_scene_root != node and node.get_tree().edited_scene_root != node.owner: return false
	return true

static func remove_all_children(node:Node):
	if not is_valid_tool_target(node): return
	for child:Node in node.get_children():
		child.queue_free()
		await child.tree_exited

static func remove_all_line2d_children(node:Node):
	if not is_valid_tool_target(node): return
	for child:Node in node.get_children():
		if child is Line2D:
			child.queue_free()
			await child.tree_exited

static func remove_all_sprite2d_children(node:Node):
	if not is_valid_tool_target(node): return
	for child:Node in node.get_children():
		if child is Sprite2D:
			child.queue_free()
			await child.tree_exited

static func remove_all_polygon2d_children(node:Node):
	if not is_valid_tool_target(node): return
	for child:Node in node.get_children():
		if child is Polygon2D:
			child.queue_free()
			await child.tree_exited
