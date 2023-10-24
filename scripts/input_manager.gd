extends Control

signal mouse_click

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("click"):
		mouse_click.emit(get_global_mouse_position())
