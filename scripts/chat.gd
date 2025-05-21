class_name Chat
extends Node2D

signal chat_message_sent(message: String)


func _on_send_button_pressed() -> void:
	var message_text_edit: TextEdit = $MessageTextEdit
	var message := message_text_edit.text.strip_edges(true, true)
	if message.is_empty():
		return

	message_text_edit.clear()
	message_text_edit.grab_focus()
	chat_message_sent.emit(message)


func _input_send(event: InputEvent) -> void:
	var message_text_edit: TextEdit = $MessageTextEdit
	if not message_text_edit.has_focus():
		return

	if not event is InputEventKey:
		return

	var key_event := event as InputEventKey

	if key_event.keycode == KEY_ENTER and key_event.pressed:
		get_viewport().set_input_as_handled()
		_on_send_button_pressed()


func _input(event: InputEvent) -> void:
	_input_send(event)
