class_name AutoloadLibrary extends Node

var firework_library : FireworkLibraryResource
const local_file_name : String = 'user://my-firework-library.json'

func save_to_local_file():
	var fa := FileAccess.open(local_file_name, FileAccess.WRITE)
	fa.store_string(firework_library.to_json())
	fa.close()

func load_from_local_file():
	if not FileAccess.file_exists(local_file_name):
		var fa := FileAccess.open(local_file_name, FileAccess.WRITE)
		fa.store_string(FireworkLibraryResource.new().to_json())
		fa.close()
	read_from_existing_local_file()

func read_from_existing_local_file():
	var fa := FileAccess.open(local_file_name, FileAccess.READ)
	firework_library = FireworkLibraryResource.from_json(fa.get_as_text())
	fa.close()

func _enter_tree() -> void:
	load_from_local_file()

func save_firework(firework_resource:FireworkResource):
	firework_library.my_fireworks.push_back(firework_resource)
	save_to_local_file()
