extends Button

@onready var score: Label = $"../../../../Score"
@onready var badge_title: Label = $BadgeTitle
@onready var badge_detail: Label = $BadgeDetail
@onready var claim_1_b_2: Panel = $Claim1_B2
@onready var claim_2_b_2: Panel = $Claim2_B2
@onready var claim_prompt_b_2: Label = $ClaimPrompt_B2
func _ready() -> void:
	disabled = true
	badge_detail.hide()
	badge_title.hide()
	claim_1_b_2.hide()
	claim_2_b_2.hide()
	claim_prompt_b_2.hide()
	score.connect("score_500", Callable(self, "_on_score_reach_500"))
	score.connect("badge2_claimed", Callable(self, "_on_badge2_claimed"))
	
func _on_score_reach_500() -> void:
	disabled = false
	badge_title.show()
	badge_detail.show()
	claim_1_b_2.show()
	claim_2_b_2.show()
	claim_prompt_b_2.show()
func _on_badge2_claimed() -> void:
	disabled = true
	add_theme_stylebox_override("disabled", load("res://assets/button_styles/easy_badge.tres"))
	badge_title.position = Vector2(274, 23)
	badge_detail.position = Vector2(310, 67)
	custom_minimum_size = Vector2(878, 115)
