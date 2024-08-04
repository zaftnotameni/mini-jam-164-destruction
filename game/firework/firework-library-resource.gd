class_name FireworkLibraryResource extends Resource

@export var my_fireworks : Array = []

static func from_json(json:String) -> FireworkLibraryResource:
	var res := FireworkLibraryResource.new()
	var json_data := JSON.parse_string(json) as Dictionary
	res.my_fireworks = json_data.my_fireworks.map(func(firework): return FireworkData.from_json_data_to_firework(firework))
	return res

func to_json() -> String:
	var json_array = my_fireworks.map(func(firework): return FireworkData.from_firework_to_json_data(firework))
	return JSON.stringify({ 'my_fireworks': json_array }, '  ')
