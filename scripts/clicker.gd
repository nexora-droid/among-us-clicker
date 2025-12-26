extends Control
@onready var among_us: Button = $AmongUs
@onready var shop_panel: Panel = $ShopPanel
@onready var clicker_shop: Button = $ShopPanel/ClickerShop
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var user_shop: Button = $ShopPanel/UserShop
@onready var achievements: Button = $ShopPanel/Achievements
@onready var panel: Panel = $SaveMenu/Panel
@onready var save: CanvasLayer = $SaveMenu
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
@onready var red: Button = $ShopPanel/UserUpgrades/VBoxContainer/User0/Red


var playlist : Array = [load("res://assets/audio/Lost Sky, Shiah Maisel - Lost pt. II [NCS Release].mp3"), load("res://assets/audio/Matt Pridgyn - Second Wind [NCS Release].mp3"), load("res://assets/audio/Irokz - Goodbye My Love [NCS Release].mp3") , load("res://assets/audio/noaa! - HYPNOTIZED! [NCS Release].mp3"), load	("res://assets/audio/Spektrem - Stutterfly [NCS Release].mp3")]
var current_track := 0
var is_playing := false

func _ready() -> void:
	_play_track(0)
	user_upgrades.hide()
	blue.remove_from_group("colour_bought")
	orange.remove_from_group("colour_bought")
	yellow.remove_from_group("colour_bought")
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
	

func _on_clicker_shop_pressed() -> void:
	clicker_shop.toggle_mode = true
	clicker_shop.button_pressed = true
	achievements.toggle_mode = false
	user_shop.toggle_mode = false
	
	clickers_upgrades.show()
	item_label.show()
	cost_label.show()
	
	user_upgrades.hide()


func _on_achievements_pressed() -> void:
	achievements.toggle_mode = true
	achievements.button_pressed = true
	user_shop.toggle_mode = false
	clicker_shop.toggle_mode = false
	
	clickers_upgrades.hide()
	item_label.hide()
	cost_label.hide()
	
	user_upgrades.hide()

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
	if blue.is_in_group("colour_bought"):
		return
	if not blue.is_in_group("colour_bought"):
		blue.add_to_group("colour_bought")
	if current != "blue":
		current = "blue"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/blue_amongus.tres") )
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/blue_amongus.tres") )
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/blue_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/blue_amongus.tres"))
	emit_signal("blue_bought")


func _on_orange_pressed() -> void:
	if orange.is_in_group("colour_bought"):
		return
	if not orange.is_in_group("colour_bought"):
		orange.add_to_group("colour_bought")
	if current != "orange":
		current = "orange"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/orange_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/orange_amongus.tres"))
	emit_signal("orange_bought")


func _on_yellow_pressed() -> void:
	if yellow.is_in_group("colour_bought"):
		return
	if not yellow.is_in_group("colour_bought"):
		yellow.add_to_group("colour_bought")
	if current != "yellow":
		current = "yellow"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/yellow_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/yellow_amongus.tres"))
	emit_signal("yellow_bought")

func _on_purple_pressed() -> void:
	if purple.is_in_group("colour_bought"):
		return
	if not purple.is_in_group("colour_bought"):
		purple.add_to_group("colour_bought")
	if current != "purple":
		current = "purple"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/purple_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/purple_amongus.tres"))
	emit_signal("purple_bought")


func _on_red_pressed() -> void:
	if red.is_in_group("colour_bought"):
		return
	if not red.is_in_group("colour_bought"):
		red.add_to_group("colour_bought")
	if current != "purple":
		current = "purple"
	among_us.add_theme_stylebox_override("normal", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("hover", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("pressed", load("res://assets/button_styles/red_amongus.tres"))
	among_us.add_theme_stylebox_override("focus", load("res://assets/button_styles/red_amongus.tres"))
