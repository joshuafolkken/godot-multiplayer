class_name Main
extends Node2D

@export var player_scene: PackedScene


func _ready() -> void:
	($Chat as Chat).chat_message_sent.connect(_on_chat_message_sent)

	if Server.is_server_mode():
		Server.start(self)
		($JoinButton as Button).visible = false


func add_player(id: int = 1, message: String = "") -> Player:
	var player: Player = player_scene.instantiate()
	player.name = str(id)
	player.set_message(message)
	call_deferred("add_child", player)

	return player


func _on_join_button_pressed() -> void:
	Client.start(self)


func _on_chat_message_sent(message: String) -> void:
	var my_player: Player = get_node(str(multiplayer.get_unique_id()))
	if my_player:
		my_player.show_chat_message(message)
