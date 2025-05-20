class_name WebSocketServer
extends Node

var _peer := WebSocketMultiplayerPeer.new()
var _main_scene: Main
# var _player: Player


func _ready() -> void:
	var port := NetworkConfig.get_port()
	var err := _peer.create_server(port)
	if err != OK:
		push_error("Failed to create server: %s, port: %d" % [error_string(err), port])
		get_tree().quit()
		return

	multiplayer.multiplayer_peer = _peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	_main_scene = get_parent()
	print("🟢 Server online — WebSocket %d" % NetworkConfig.get_port())
	# _player = _main_scene.add_player(1, "🟢 Server online — WebSocket %d" % NetworkConfig.get_port())


func _on_peer_connected(id: int) -> void:
	print("⚡ client connected: %d" % id)
	# _player.show_chat_message("⚡ client connected: %d" % id)
	_main_scene.add_player(id)


func _on_peer_disconnected(id: int) -> void:
	print("🔥 client disconnected: %d" % id)
	_main_scene.remove_player(id)
	# _player.show_chat_message("🔥 client disconnected: %d" % id)


static func start(node: Node) -> void:
	var server := WebSocketServer.new()
	node.add_child(server)
