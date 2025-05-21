class_name Chat
extends Node2D

signal chat_message_sent(message: String)

@onready var _message_text_edit: TextEdit = $MessageTextEdit


func _send_message() -> void:
	var message := _message_text_edit.text.strip_edges(true, true)
	if message.is_empty():
		return

	_message_text_edit.clear()
	_message_text_edit.grab_focus()
	chat_message_sent.emit(message)


func _on_send_button_pressed() -> void:
	_send_message()


func _input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return

	if not _message_text_edit.has_focus():
		return

	var input_event_key: InputEventKey = event
	if input_event_key.keycode == KEY_ENTER and input_event_key.pressed:
		get_viewport().set_input_as_handled()
		_send_message()
