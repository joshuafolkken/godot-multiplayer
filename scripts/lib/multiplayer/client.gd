class_name Client
extends Node

var _peer := ENetMultiplayerPeer.new()


func _ready() -> void:
	_peer.create_client(NetworkConfig.get_address(), NetworkConfig.get_port())
	multiplayer.multiplayer_peer = _peer


static func start(node: Node) -> void:
	var client := Client.new()
	node.add_child(client)
