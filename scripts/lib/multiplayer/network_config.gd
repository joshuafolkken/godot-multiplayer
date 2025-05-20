class_name NetworkConfig
extends Node

const DEV_ADDRESS: String = "localhost"
const DEV_PORT: int = 50000

const PROD_ADDRESS: String = "34.83.21.101"
const PROD_PORT: int = 50000


static func get_address() -> String:
	if OS.is_debug_build():
		return DEV_ADDRESS
	return PROD_ADDRESS


static func get_port() -> int:
	if OS.is_debug_build():
		return DEV_PORT
	return PROD_PORT


static func get_websocket_url() -> String:
	return "ws://%s:%s" % [get_address(), get_port()]
