class_name FireworkData extends Resource

static func from_firework_to_json(firework_resource:FireworkResource) -> String:
	var firework_json := {}
	firework_json['elements'] = firework_resource.elements.map(func(element): return Element.find_key(element))
	firework_json['friendly_name'] = firework_resource.friendly_name
	if firework_resource.explosion_texture:
		firework_json['explosion_texture'] = firework_resource.explosion_texture.resource_path
	return JSON.stringify(firework_json)

static func from_json_to_firework(firework_json:String) -> FireworkResource:
	var firework_data := JSON.parse_string(firework_json) as Dictionary
	var firework_resource := FireworkResource.new()
	firework_resource.elements = firework_data.elements.map(func(element): return Element[element])
	firework_resource.friendly_name = firework_data.friendly_name
	if firework_data.explosion_texture:
		if ResourceLoader.exists(firework_data.explosion_texture):
			firework_resource.explosion_texture = load(firework_data.explosion_texture)
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
