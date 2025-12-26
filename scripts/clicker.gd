extends Control
@onready var among_us: Button = $AmongUs
@onready var shop_panel: Panel = $ShopPanel
@onready var clicker_shop: Button = $ShopPanel/ClickerShop
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var user_shop: Button = $ShopPanel/UserShop
@onready var achievements: Button = $ShopPanel/Achievements
@onready var panel: Panel = $SaveMenu/Panel
@onready var save: CanvasLayer = $SaveMenu

# Shops

# Clicker Shop
@onready var clickers_upgrades: ScrollContainer = $ShopPanel/ClickersUpgrades
@onready var item_label: Label = $ShopPanel/ItemLabel
@onready var cost_label: Label = $ShopPanel/CostLabel

# User Shop
@onready var user_upgrades: ScrollContainer = $ShopPanel/UserUpgrades


var playlist : Array = [load("res://assets/audio/Lost Sky, Shiah Maisel - Lost pt. II [NCS Release].mp3"), load("res://assets/audio/Matt Pridgyn - Second Wind [NCS Release].mp3"), load("res://assets/audio/Irokz - Goodbye My Love [NCS Release].mp3") , load("res://assets/audio/noaa! - HYPNOTIZED! [NCS Release].mp3"), load	("res://assets/audio/Spektrem - Stutterfly [NCS Release].mp3")]
var current_track := 0
var is_playing := false

func _ready() -> void:
	_play_track(0)
	user_upgrades.hide()
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
