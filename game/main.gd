extends Node2D


func _ready() -> void:
	
	await Leaderboards.post_guest_score(
		Global.leaderboard_id,
		Global.score,
		Global.player_name,
		Global.player_build,
		)
