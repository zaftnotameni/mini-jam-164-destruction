class_name FireworkData extends Resource

# The mapping from ingredient -> Color is from
# https://www.elementchem.com/2013/12/30/the-chemistry-of-fireworks/

enum Element { None, Mg, Sr, Ba, Cu, Ca, Na }

## todo: nicer/fancier colors (ideally still following the spirite of the element chemistry
## todo: invent more colors for different mixtures of elements
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

