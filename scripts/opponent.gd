extends Control

class_name Opponent

signal request_playable_piles
signal request_target_piles
signal move_card
signal no_available_move

var held_card:Card

var play_piles:Dictionary
var target_piles:Dictionary
var stackable_piles:Dictionary
var empty_piles:Array
var remaining_cards:int
var making_move:bool = false
var multicard_stacks:bool = true

func _process(delta: float) -> void:
	if !making_move:
		find_move()

func find_move() -> bool:
	for card_val in play_piles.keys():
		for target_val in target_piles.keys():
			if abs(card_val - target_val) == 1 or abs(card_val - target_val) >= 12:
				initiate_move_card(play_piles[card_val],target_piles[target_val])
				print('center move')
				return true
		if empty_piles.size() > 0 and multicard_stacks:
			print('solitare move')
			initiate_move_card(play_piles[card_val],empty_piles[0])
			return true
		if card_val in stackable_piles.keys() and remaining_cards > 5:
			initiate_move_card(play_piles[card_val],stackable_piles[card_val])
			print('stack move')
			return true
	send_stuck_state()
	return false

func reorder_cards(empy_spot:PlayPile) -> void:
	pass

func get_available_play_piles() -> void:
	request_playable_piles.emit()

func populate_playable_piles(playable_piles:Array) -> void:
	playable_piles = shuffle(playable_piles)
	empty_piles.clear()
	stackable_piles.clear()
	play_piles.clear()
	remaining_cards = 0
	multicard_stacks = false
	for pile in playable_piles:
		if pile.has_cards():
			if int(pile.stack.front().value_to_int()) in play_piles.keys():
				stackable_piles[int(pile.stack.front().value_to_int())] = pile
			else:
				play_piles[int(pile.stack.front().value_to_int())] = pile
			remaining_cards += pile.stack.size()
		else:
			empty_piles.append(pile)
		if pile.stack.size() > 1:
			multicard_stacks = true

func get_target_piles() -> void:
	request_target_piles.emit()

func populate_target_piles(targeted_piles:Array) -> void:
	target_piles.clear()
	for pile in targeted_piles:
		target_piles[int(pile.stack.front().value_to_int())] = pile

func send_stuck_state() -> void:
	no_available_move.emit()

func initiate_move_card(starting_pile:PlayPile, target_pile:PlayPile) -> void:
	making_move = true
	move_card.emit(starting_pile, target_pile)
	look_at_cards()

func look_at_cards() -> void:
	get_available_play_piles()
	get_target_piles()

#should put this in a static util fucntion but shhhh
func shuffle(arr:Array) -> Array:
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	for i in range(arr.size()-1,0,-1):
		var j:int = rng.randf_range(0,i+1)
		var temp = arr[i]
		arr[i] = arr[j]
		arr[j] = temp
	return arr

func move_complete() -> void:
	making_move = false
	look_at_cards()
