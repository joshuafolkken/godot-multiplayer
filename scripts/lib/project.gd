class_name Project
extends Node


static func get_app_name() -> String:
	return ProjectSettings.get_setting("application/config/name")


static func get_version() -> String:
	return ProjectSettings.get_setting("application/config/version")


static func get_name_version() -> String:
	return "%s %s" % [get_app_name(), get_version()]


static func get_role() -> String:
	return "Server" if ENetServer.is_server_mode() else "Client"


static func get_build_type() -> String:
	return "Debug" if OS.is_debug_build() else "Release"


static func get_info() -> String:
	return "%s v%s %s %s" % [get_app_name(), get_version(), get_role(), get_build_type()]
