extends Button

@onready var score: Label = $"../../../../Score"
@onready var badge_title: Label = $BadgeTitle
@onready var badge_detail: Label = $BadgeDetail
@onready var claim_1_b_6: Panel = $Claim1_B6
@onready var claim_2_b_6: Panel = $Claim2_B6
@onready var claim_prompt_b_6: Label = $ClaimPrompt_B6
func _ready() -> void:
	disabled = true
	badge_detail.hide()
	badge_title.hide()
	claim_1_b_6.hide()
	claim_2_b_6.hide()
	claim_prompt_b_6.hide()
	score.connect("score_5000", Callable(self, "_on_score_reach_5000"))
	score.connect("badge6_claimed", Callable(self, "_on_badge6_claimed"))
	if score.badges_unlocked[5]:
		_on_score_reach_5000()
	if score.badges_claimed[5]:
		_on_badge6_claimed()
func _on_score_reach_5000() -> void:
	if score.badges_claimed[5]:
		disabled = true
		badge_title.show()
		badge_detail.show()
		return
	disabled = false
	badge_title.show()
	badge_detail.show()
	claim_1_b_6.show()
	claim_2_b_6.show()
	claim_prompt_b_6.show()
func _on_badge6_claimed() -> void:
	disabled = true
	add_theme_stylebox_override("disabled", load("res://assets/button_styles/mid_badge.tres"))
	badge_title.position = Vector2(274, 23)
	badge_detail.position = Vector2(310, 67)
	custom_minimum_size = Vector2(878, 115)
	
