extends Node2D

const ADDRESS = "localhost"
const PORT = 50000

@export var player_scene: PackedScene

var _peer := ENetMultiplayerPeer.new()


func _add_player(id := 1) -> void:
	var player: Player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)


func _on_host_button_pressed() -> void:
	_peer.create_server(PORT)
	multiplayer.multiplayer_peer = _peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()


func _on_join_button_pressed() -> void:
	_peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = _peer


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
