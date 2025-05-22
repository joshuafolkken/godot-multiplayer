class_name Main
extends Node2D

@export var player_scene: PackedScene

@onready var _version_label: Label = $VersionLabel
@onready var _chat: Chat = $Chat
@onready var _join_button: Button = $JoinButton
@onready var _connection_label: Label = $ConnectionLabel


func _ready() -> void:
	var info := Project.get_info()
	print(info)

	_chat.chat_message_sent.connect(_on_chat_message_sent)

	if ENetServer.is_server_mode():
		WebSocketServer.start(self)
		_join_button.visible = false
	else:
		_version_label.text = info


func add_player(id: int = 1, message: String = "") -> Player:
	var player: Player = player_scene.instantiate()
	player.name = str(id)
	player.set_message(message)
	call_deferred("add_child", player)

	return player


func remove_player(id: int) -> void:
	var player := get_node_or_null(str(id))
	if player:
		player.queue_free()


func show_connection_message(message: String) -> void:
	_connection_label.text = message


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
