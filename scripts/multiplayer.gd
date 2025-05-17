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
