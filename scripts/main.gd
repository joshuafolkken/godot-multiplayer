class_name Main
extends Node2D

@export var player_scene: PackedScene

@onready var connection_label: Label = $ConnectionLabel


func _ready() -> void:
	($Chat as Chat).chat_message_sent.connect(_on_chat_message_sent)

	if ENetServer.is_server_mode():
		print("server mode")
		WebSocketServer.start(self)
		($JoinButton as Button).visible = false
	else:
		print("client mode")


func add_player(id: int = 1, message: String = "") -> Player:
	var player: Player = player_scene.instantiate()
	player.name = str(id)
	player.set_message(message)
	call_deferred("add_child", player)

	return player


func show_connection_message(message: String) -> void:
	connection_label.text = message


func _on_join_button_pressed() -> void:
	var client := WebSocketClient.start(self)
	show_connection_message("Connecting to server ...")
	client.connected_to_server.connect(_on_client_connected_to_server)
	client.connection_failed.connect(_on_client_connection_failed)


func _on_client_connected_to_server() -> void:
	show_connection_message("Connected to server.")


func _on_client_connection_failed() -> void:
	show_connection_message("Connection failed.")


func _on_chat_message_sent(message: String) -> void:
	var my_player: Player = get_node(str(multiplayer.get_unique_id()))
	if my_player:
		my_player.show_chat_message(message)
