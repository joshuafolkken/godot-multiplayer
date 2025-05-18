class_name Client
extends Node

signal connected_to_server
signal connection_failed

var _peer := ENetMultiplayerPeer.new()


func _ready() -> void:
	_peer.create_client(NetworkConfig.get_address(), NetworkConfig.get_port())

	multiplayer.multiplayer_peer = _peer
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)


func _on_connected_to_server() -> void:
	connected_to_server.emit()


func _on_connection_failed() -> void:
	connection_failed.emit()


static func start(node: Node) -> Client:
	var client := Client.new()
	node.add_child(client)

	return client
