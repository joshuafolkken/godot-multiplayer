class_name Player
extends CharacterBody2D

const SPEED: int = 1000

var _chat_timer := Timer.new()
var _message := "Hiya!"

@onready var _chat_label: Label = $ChatLabel


func set_message(message: String) -> void:
	_message = message


func _ready() -> void:
	var viewport_rect := get_viewport_rect()
	position = viewport_rect.size / 2

	_init_chat_timer()
	show_chat_message(_message)


func _init_chat_timer() -> void:
	_chat_timer.wait_time = 10.0
	_chat_timer.one_shot = true
	_chat_timer.timeout.connect(_on_chat_timer_timeout)
	add_child(_chat_timer)


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return

	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED
	move_and_slide()


func _on_chat_timer_timeout() -> void:
	_chat_label.visible = false


func show_chat_message(message: String) -> void:
	_chat_label.text = message
	_chat_label.visible = true
	_chat_timer.start()
