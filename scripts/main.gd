class_name Main
extends Node2D

@export var player_scene: PackedScene


func _ready() -> void:
	($Chat as Chat).chat_message_sent.connect(_on_chat_message_sent)


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


func _on_chat_message_sent(message: String) -> void:
	var my_player: Player = get_node(str(multiplayer.get_unique_id()))
	if my_player:
		my_player.show_chat_message(message)
