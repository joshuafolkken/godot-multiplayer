class_name Main
extends Node2D

@export var player_scene: PackedScene


func add_player(id: int = 1, message: String = "") -> Player:
	var player: Player = player_scene.instantiate()
	player.name = str(id)
	player.set_message(message)
	call_deferred("add_child", player)

	return player


func _on_host_button_pressed() -> void:
	var server := Server.new()
	add_child(server)


func _on_join_button_pressed() -> void:
	var client := Client.new()
	add_child(client)


func _on_send_button_pressed() -> void:
	var message_text_edit: TextEdit = $MessageTextEdit
	var message := message_text_edit.text.strip_edges(true, true)
	if message.is_empty():
		return

	message_text_edit.clear()
	message_text_edit.grab_focus()

	var my_player: Player = get_node(str(multiplayer.get_unique_id()))
	if my_player:
		my_player.show_chat_message(message)


func _input_send(event: InputEvent) -> void:
	var message_text_edit: TextEdit = $MessageTextEdit
	if not message_text_edit.has_focus():
		return

	if not event is InputEventKey:
		return

	var key_event := event as InputEventKey

	if key_event.keycode == KEY_ENTER:
		get_viewport().set_input_as_handled()
		_on_send_button_pressed()


func _input(event: InputEvent) -> void:
	_input_send(event)
