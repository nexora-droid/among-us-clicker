extends Control
@onready var label: Label = $Label
@onready var label_animation_player: AnimationPlayer = $Label/AnimationPlayer
@onready var panel_animation_player: AnimationPlayer = $Panel/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel_animation_player.play("slidein")
	label.visible = false
	await get_tree().create_timer(5).timeout
	label.visible = true
	label_animation_player.play("load_in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("Switching scenes to Clicker...")
	get_tree().change_scene_to_file("res://scenes/clicker.tscn")
