extends Button

@onready var score: Label = $"../../../../Score"
@onready var badge_title: Label = $BadgeTitle
@onready var badge_detail: Label = $BadgeDetail
@onready var claim_1: Panel = $Claim1
@onready var claim_2: Panel = $Claim2
@onready var claim_prompt: Label = $ClaimPrompt
func _ready() -> void:
	disabled = true
	badge_detail.hide()
	badge_title.hide()
	claim_1.hide()
	claim_2.hide()
	claim_prompt.hide()
	score.connect("score_100", Callable(self, "_on_score_reach_100"))
	score.connect("badge1_claimed", Callable(self, "_on_badge1_claimed"))
	
func _on_score_reach_100() -> void:
	disabled = false
	badge_title.show()
	badge_detail.show()
	claim_1.show()
	claim_2.show()
	claim_prompt.show()
func _on_badge1_claimed() -> void:
	disabled = true
	add_theme_stylebox_override("disabled", load("res://assets/button_styles/easy_badge.tres"))
	badge_title.position = Vector2(274, 23)
	badge_detail.position = Vector2(310, 67)
	custom_minimum_size = Vector2(878, 115)
