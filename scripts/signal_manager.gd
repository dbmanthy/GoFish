extends Control

#node communication https://kidscancode.org/godot_recipes/4.x/basics/node_communication/
#and https://www.youtube.com/watch?v=qkLBzm5D3Rs&t=231s

func _ready() -> void:
	#input manager signls
	$InputManager.mouse_click.connect($Dealer.card_interact)

	#root
	get_tree().get_root().size_changed.connect($Dealer.set_play_area)

	#play areas

