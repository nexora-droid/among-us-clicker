extends Control
@onready var among_us: Button = $AmongUs
@onready var shop_panel: Panel = $ShopSystem/ShopPanel
@onready var clicker_shop: Button = $ShopSystem/ShopPanel/ClickerShop
@onready var user_shop: Button = $ShopSystem/ShopPanel/UserShop
@onready var achievements: Button = $ShopSystem/ShopPanel/Achievements
func _ready() -> void:
	pass

signal among_pressed()
func _on_among_us_button_down() -> void:
	among_us.scale = Vector2(0.95, 0.95)
	emit_signal("among_pressed")
	


func _on_among_us_button_up() -> void:
	among_us.scale = Vector2(1, 1)


func _on_user_shop_pressed() -> void:
	user_shop.toggle_mode = true
	user_shop.button_pressed = true
	clicker_shop.toggle_mode = false
	achievements	.toggle_mode = false


func _on_clicker_shop_pressed() -> void:
	clicker_shop.toggle_mode = true
	clicker_shop.button_pressed = true
	achievements.toggle_mode = false
	user_shop.toggle_mode = false


func _on_achievements_pressed() -> void:
	achievements.toggle_mode = true
	achievements.button_pressed = true
	user_shop.toggle_mode = false
	clicker_shop.toggle_mode = false
