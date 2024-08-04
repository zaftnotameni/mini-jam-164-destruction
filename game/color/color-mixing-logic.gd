extends Node

static func mix_colors(colors:Array[Color]) -> Color:
	var total_r : float = 0
	var total_g : float = 0
	var total_b : float = 0
	for color in colors:
		total_r += color.r
		total_g += color.g
		total_b += color.b
	var max_val : float = maxf(maxf(total_r, total_g), total_b)
	if max_val <= 0.1: max_val = 1
	return Color(total_r/max_val, total_g/max_val, total_b/max_val, 1.0)
