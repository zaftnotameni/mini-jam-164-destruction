class_name FireworkData extends Resource

static func from_firework_to_json_data(firework_resource:FireworkResource) -> Dictionary:
	var firework_json := {}
	firework_json['elements'] = firework_resource.elements.map(func(element): return Element.find_key(element))
	firework_json['friendly_name'] = firework_resource.friendly_name
	firework_json['explosion_amount'] = firework_resource.explosion_amount
	firework_json['explosion_scale_amount_min'] = firework_resource.explosion_scale_amount_min
	firework_json['explosion_scale_amount_max'] = firework_resource.explosion_scale_amount_max
	firework_json['explosion_color'] = '#' + firework_resource.explosion_color.to_html()
	firework_json['explosion_textures'] = []
	for texture in firework_resource.explosion_textures:
		firework_json['explosion_textures'].push_back(texture.resource_path)
	return firework_json

static func from_json_data_to_firework(firework_data:Dictionary) -> FireworkResource:
	var firework_resource := FireworkResource.new()
	firework_resource.elements = firework_data.elements.map(func(element): return Element[element])
	firework_resource.friendly_name = firework_data.friendly_name
	firework_resource.explosion_amount = firework_data.explosion_amount
	firework_resource.explosion_scale_amount_min = firework_data.explosion_scale_amount_min
	firework_resource.explosion_scale_amount_max = firework_data.explosion_scale_amount_max
	firework_resource.explosion_color = Color(firework_data.explosion_color)
	for texture in firework_data.explosion_textures:
		if ResourceLoader.exists(texture):
			firework_resource.explosion_textures.push_back(load(texture))
	return firework_resource

## The mapping from ingredient -> Color is from
## https://www.elementchem.com/2013/12/30/the-chemistry-of-fireworks/
enum Element { None, Mg, Sr, Ba, Cu, Ca, Na }

## todo: nicer/fancier colors (ideally still following the spirite of the element chemistry
## todo: invent more colors for different mixtures of elements
## maybe: 3 element mixtures?
static func color_of_mix(element_a:Element, element_b:Element) -> Color:
	var mix := [element_a, element_b]
	if mix.has(Element.Cu) and mix.has(Element.Sr): return Color.PURPLE
	return color_of_element(element_a)

## todo: nicer/fancier colors (ideally still following the spirite of the element chemistry
static func color_of_element(element:Element) -> Color:
	match element:
		Element.Sr: return Color.RED
		Element.Ba: return Color.GREEN
		Element.Cu: return Color.BLUE
		Element.Ca: return Color.ORANGE
		Element.Na: return Color.YELLOW
		Element.Mg: return Color.WHITE
	return Color.HOT_PINK
