extends Node2D


func _ready() -> void:
	print(Global.player_name)
	await Leaderboards.post_guest_score(
		Global.leaderboard_id,
		Global.score,
		Global.player_name,
		Global.player_build,
		)
