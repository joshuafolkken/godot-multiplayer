class_name Player
extends CharacterBody2D

const CHAT_MESSAGE_DURATION: float = 10.0

var _chat_timer := Timer.new()
var _message := "Hiya!"

@onready var _tween := create_tween()
@onready var _chat_label: Label = $ChatLabel


func set_message(message: String) -> void:
	_message = message


func _ready() -> void:
	var viewport_rect := get_viewport_rect()
	position = viewport_rect.size / 2

	_init_chat_timer()
	show_chat_message(_message)


func _init_chat_timer() -> void:
	_chat_timer.wait_time = CHAT_MESSAGE_DURATION
	_chat_timer.one_shot = true
	_chat_timer.timeout.connect(_on_chat_timer_timeout)
	add_child(_chat_timer)


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func move(target_position: Vector2) -> void:
	_tween.kill()
	_tween = create_tween()
	# _tween.set_parallel(true)

	var distance := global_position.distance_to(target_position)
	var duration := distance / 750.0

	(
		_tween
		. tween_property(self, "position", target_position, duration)
		. set_trans(Tween.TRANS_SINE)
		. set_ease(Tween.EASE_IN_OUT)
	)

	_tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)


func _unhandled_input(event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return

	if event is InputEventMouseButton:
		var input_event_mouse_button: InputEventMouseButton = event

		if (
			input_event_mouse_button.pressed
			and input_event_mouse_button.button_index == MOUSE_BUTTON_LEFT
		):
			move(get_global_mouse_position())


func _on_chat_timer_timeout() -> void:
	_chat_label.visible = false


func show_chat_message(message: String) -> void:
	_chat_label.text = message
	_chat_label.visible = true
	_chat_timer.start()
