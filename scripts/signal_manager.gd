extends Control

#node communication https://kidscancode.org/godot_recipes/4.x/basics/node_communication/
#and https://www.youtube.com/watch?v=qkLBzm5D3Rs&t=231s

func _ready() -> void:
	#input manager signls
	$InputManager.mouse_click.connect($Dealer.card_interact)

	#root
	get_tree().get_root().size_changed.connect($Dealer.set_play_area)

	#opponent signals
	$Opponent.request_playable_piles.connect($Dealer.show_playable_piles)
	$Dealer.send_playable_piles.connect($Opponent.populate_playable_piles)

	$Opponent.request_target_piles.connect($Dealer.show_target_piles)
	$Dealer.send_target_piles.connect($Opponent.populate_target_piles)

	$Opponent.move_card.connect($Dealer.manuel_move_card)
	$Dealer.shared_piles_changed.connect($Opponent.look_at_cards)

	$Opponent.no_available_move.connect($Dealer.opponent_stuck)
	$Dealer.move_made.connect($Opponent.move_complete)

	$Opponent.opponent_won.connect($Dealer.round_won)
	$Dealer.game_winnable.connect($Opponent.set_game_winnable)

	$Opponent.game_winnable.connect($Dealer.opponent_trigger_win_state)
