extends CanvasLayer

signal new_pressed()
signal continue_pressed()
func _on_continue_pressed() -> void:
	emit_signal("continue_pressed")


func _on_new_pressed() -> void:
	emit_signal("new_pressed")
