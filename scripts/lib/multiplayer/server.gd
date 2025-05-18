class_name Server
extends Node

var _peer := ENetMultiplayerPeer.new()
var _main_scene: Main
var _player: Player


func _ready() -> void:
	_peer.create_server(NetworkConfig.get_port())
	multiplayer.multiplayer_peer = _peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	_main_scene = get_parent()
	_player = _main_scene.add_player(1, "🟢 Server online — port %d" % NetworkConfig.get_port())


func _on_peer_connected(id: int) -> void:
	_player.show_chat_message("⚡ client connected: %d" % id)
	_main_scene.add_player(id)


func _on_peer_disconnected(id: int) -> void:
	_player.show_chat_message("🔥 client disconnected: %d" % id)
