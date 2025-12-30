extends Control

@onready var among_us: Button = $AmongUs
@onready var shop_panel: Panel = $ShopPanel
@onready var clicker_shop: Button = $ShopPanel/ClickerShop
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var user_shop: Button = $ShopPanel/UserShop
@onready var achievements: Button = $ShopPanel/Achievements
@onready var panel: Panel = $SaveMenu/Panel
@onready var save: CanvasLayer = $SaveMenu
@onready var score: Label = $Score
@onready var badges_panel: ScrollContainer = $ShopPanel/Badges
var current := "red"


# Shops

# Clicker Shop
@onready var clickers_upgrades: ScrollContainer = $ShopPanel/ClickersUpgrades
@onready var item_label: Label = $ShopPanel/ItemLabel
@onready var cost_label: Label = $ShopPanel/CostLabel

# User Shop
@onready var user_upgrades: ScrollContainer = $ShopPanel/UserUpgrades
@onready var blue: Button = $ShopPanel/UserUpgrades/VBoxContainer/User1/Blue
signal blue_bought()
@onready var orange: Button = $ShopPanel/UserUpgrades/VBoxContainer/User2/Orange
signal orange_bought()
@onready var yellow: Button = $ShopPanel/UserUpgrades/VBoxContainer/User3/Yellow
signal yellow_bought()
@onready var purple: Button = $ShopPanel/UserUpgrades/VBoxContainer/User4/Purple
signal purple_bought()
@onready var cyan: Button = $ShopPanel/UserUpgrades/VBoxContainer/User5/Cyan
signal cyan_bought()
@onready var red: Button = $ShopPanel/UserUpgrades/VBoxContainer/User0/Red
@onready var user_item_label: Label = $ShopPanel/UserItemLabel
@onready var user_cost_label: Label = $ShopPanel/UserCostLabel

# Badges
@onready var badges: ScrollContainer = $ShopPanel/Badges


var playlist : Array = [load("res://assets/audio/Lost Sky, Shiah Maisel - Lost pt. II [NCS Release].mp3"), load("res://assets/audio/Matt Pridgyn - Second Wind [NCS Release].mp3"), load("res://assets/audio/Irokz - Goodbye My Love [NCS Release].mp3") , load("res://assets/audio/noaa! - HYPNOTIZED! [NCS Release].mp3"), load	("res://assets/audio/Spektrem - Stutterfly [NCS Release].mp3")]
var current_track := 0
var is_playing := false

func _ready() -> void:
	_play_track(0)
	user_upgrades.hide()
	badges_panel.hide()
	# achievement upgrades to be hidden.

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
	achievements.toggle_mode = false
	
	clickers_upgrades.hide()
	item_label.hide()
	cost_label.hide()

	user_upgrades.show()
	user_item_label.show()
	user_cost_label.show()
	
	badges.hide()
	
func _on_clicker_shop_pressed() -> void:
	clicker_shop.toggle_mode = true
	clicker_shop.button_pressed = true
	achievements.toggle_mode = false
	user_shop.toggle_mode = false
	
	clickers_upgrades.show()
	item_label.show()
	cost_label.show()
	
	user_upgrades.hide()
	user_item_label.hide()
	user_cost_label.hide()
	
	badges.hide()

func _on_achievements_pressed() -> void:
	achievements.toggle_mode = true
	achievements.button_pressed = true
	user_shop.toggle_mode = false
	clicker_shop.toggle_mode = false
	
	clickers_upgrades.hide()
	item_label.hide()
	cost_label.hide()
	
	user_upgrades.hide()
	user_item_label.hide()
	user_cost_label.hide()
	
	badges.show()

func _play_track(index: int) -> void:
	if (index < 0) or index >= playlist.size():
		return
	current_track = index
	audio_stream_player.stream = playlist[current_track]
	audio_stream_player.play()
	is_playing = true

func _on_previous_pressed() -> void:
	current_track -= 1
	if current_track <= 0:
		current_track = playlist.size() - 1
	_play_track(current_track)


func _on_next_pressed() -> void:
	current_track += 1
	if current_track >= playlist.size():
		current_track = 0
	_play_track(current_track)


func _on_play_pause_pressed() -> void:
	if audio_stream_player.is_playing():
		audio_stream_player.stop()
		is_playing = false
	else:
		audio_stream_player.play()
		is_playing = true



func _on_audio_stream_player_finished() -> void:
	_on_next_pressed()


func _on_blue_pressed() -> void:
	if current == "blue"  or (int(score.text) - 100) < 0:
		return
	if current != "blue":
		current = "blue"
	emit_signal("blue_bought")
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/blue_amongus.tres") )
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/blue_amongus.tres") )
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/blue_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/blue_amongus.tres"))


func _on_orange_pressed() -> void:
	if current == "orange" or (int(score.text) - 100) < 0:
		return
	if current != "orange":
		current = "orange"
	emit_signal("orange_bought")
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/orange_amongus.tres"))


func _on_yellow_pressed() -> void:
	if current == "yellow" or (int(score.text) - 100) < 0:
		return
	if current != "yellow":
		current = "yellow"
	emit_signal("yellow_bought")
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/yellow_amongus.tres"))

func _on_purple_pressed() -> void:
	if current == "purple"  or (int(score.text) - 100) < 0:
		return
	if current != "purple":
		current = "purple"
	emit_signal("purple_bought")
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/purple_amongus.tres"))


func _on_red_pressed() -> void:
	if current != "red":
		current = "red"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/red_amongus.tres"))


func _on_cyan_pressed() -> void:
	if (int(score.text) - 100) < 0 or current == "cyan":
		return
	if current != "cyan":
		current = "cyan"
	emit_signal("cyan_bought")
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/cyan_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/cyan_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/cyan_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/cyan_amongus.tres"))
