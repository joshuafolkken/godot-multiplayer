class_name NetworkConfig
extends Node

const IS_LOCAL_DEBUG: bool = false

const DEV_ADDRESS: String = "localhost"
const DEV_PORT: int = 50000

const PROD_ADDRESS: String = "joshuafolkken.duckdns.org"
const PROD_PORT: int = 50000


static func get_address() -> String:
	return DEV_ADDRESS if IS_LOCAL_DEBUG else PROD_ADDRESS


static func get_port() -> int:
	return DEV_PORT if IS_LOCAL_DEBUG else PROD_PORT


static func get_websocket_url() -> String:
	if IS_LOCAL_DEBUG:
		return "ws://%s:%s" % [get_address(), get_port()]

	return "wss://%s" % get_address()
