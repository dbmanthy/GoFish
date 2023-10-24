extends Control

class_name PlayPile

signal mouse_over
signal mouse_off

var stack_type:String

var stack:Array
var top_card:Card

var opponent_pile:bool

func _ready() -> void:
	connect("mouse_entered", singal_mouse_over)
	connect("mouse_exited",  singal_mouse_off)

func init(text:String, stack_type:String, opponent_pile:bool) -> PlayPile:
	self.z_index = -100
	self.stack_type = stack_type
	self.opponent_pile = opponent_pile
	$CardOutter/Number/Label.text = text
	return self

func add_card(card:Card) -> void:
	stack.push_front(card)
	set_card_display_order()
	var card_offset:Vector2
	match stack_type:
		'messy':
			card_offset = messy_pile()
		'clean':
			card_offset = Vector2.ZERO
		'stacked':
			card_offset = Vector2(0, card.card_size().y * card.scale.y * .15) * (stack.size() - 1)
			scale_input_area(card)
	card.position = self.position + card_offset
	top_card = card

func pop_card() -> Card:
	set_card_display_order()
	top_card = stack.front()
	if stack_type == "stacked":
		scale_input_area(top_card)
	return stack.pop_front()

func has_cards() -> bool:
	return true if stack.size() > 0 else false

func card_size() -> Vector2:
	return $CardOutter.size

func set_card_display_order() -> void:
	for i in range(stack.size()):
		stack[i].z_index = -i
		if stack[i].z_index < self.z_index:
			self.z_index -= 100

func singal_mouse_over() -> void:
	mouse_over.emit(self)

func singal_mouse_off() -> void:
	mouse_off.emit()

func messy_pile() -> Vector2:
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	var x:float = rng.randf_range(0,$CardOutter.size.x * .08) * rng.randi_range(-1,1)
	var y:float = rng.randf_range(0,$CardOutter.size.y * .08) * rng.randi_range(-1,1)
	return Vector2(x,y)

func empty():
	self.stack.clear()

func scale_input_area(card:Card) -> void:
	var added_card_length:float = card.card_size().y * card.scale.y * .15 * (stack.size() - 1)
	#var scale_factor:float = (card.card_size().y + added_card_length) / card.card_size().y
	$CardOutter.size.y = card.card_size().y + added_card_length

func reposition_cards() -> void:
	var temp_stack:Array = [] + stack
	temp_stack.reverse()
	empty()
	for i in range(temp_stack.size()):
		var card:Card = temp_stack[i]
		add_card(card)
