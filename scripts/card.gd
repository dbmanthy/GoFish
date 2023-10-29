extends Control

class_name Card

var value:String
var suit:String

var revealed:bool = false

func _ready() -> void:
	hide_card()

#because are using init cant use @onready https://ask.godotengine.org/156464/i-dont-understand-why-base-is-nil
func populate_card(value:String, suit:String) -> Card:
	self.value = value
	self.suit = suit

	return self

func reveale_card() -> void:
	revealed = true
	if suit in ['♤','♧']:
		$CardOutter/CardColor.color = Color("#262626")
	else:
		$CardOutter/CardColor.color = Color("#c02626")

	$CardOutter/CardInner/TopSymbols/NumberLeft.text = ' '+value
	$CardOutter/CardInner/BottomSybmols/NumberRight.text = value+' '

	$CardOutter/CardInner/BottomSybmols/SuitLeft.text = ' '+suit
	$CardOutter/CardInner/TopSymbols/SuitRight.text = suit+' '

	$CardOutter/CardInner/Number/Label.text = suit+value

func hide_card() -> void:
	revealed = false
	$CardOutter/CardColor.color = Color("#265cc0")

	$CardOutter/CardInner/TopSymbols/NumberLeft.text = ' ?'
	$CardOutter/CardInner/BottomSybmols/NumberRight.text = '? '

	$CardOutter/CardInner/BottomSybmols/SuitLeft.text = ' ?'
	$CardOutter/CardInner/TopSymbols/SuitRight.text = '? '

	$CardOutter/CardInner/Number/Label.text = "X"


func card_size() -> Vector2:
	return $CardOutter.size

func value_to_int() -> int:
	if value == 'A':
		return	1
	elif value == 'J':
		return 11
	elif value == 'Q':
		return 12
	elif value == 'K':
		return 13
	else:
		return int(value)


