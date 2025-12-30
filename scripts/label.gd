extends Label

@onready var clicker: Control = $".."
@onready var cps: Label = $"../CPS"
@onready var save: CanvasLayer = $"../SaveMenu"
@onready var panel: Panel = $"../OverlayPanel"
@onready var claim_1: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel/Claim1"
@onready var claim_2: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel/Claim2"
@onready var claim_prompt: Label = $"../ShopPanel/Badges/VBoxContainer/BadgePanel/ClaimPrompt"
@onready var claim_2_b_2: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel2/Claim2_B2"
@onready var claim_prompt_b_2: Label = $"../ShopPanel/Badges/VBoxContainer/BadgePanel2/ClaimPrompt_B2"
@onready var claim_1_b_2: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel2/Claim1_B2"
@onready var claim_1_b_4: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel4/Claim1_B4"
@onready var claim_2_b_4: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel4/Claim2_B4"
@onready var claim_prompt_b_4: Label = $"../ShopPanel/Badges/VBoxContainer/BadgePanel4/ClaimPrompt_B4"
@onready var claim_1_b_5: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel5/Claim1_B5"
@onready var claim_2_b_5: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel5/Claim2_B5"
@onready var claim_prompt_b_5: Label = $"../ShopPanel/Badges/VBoxContainer/BadgePanel5/ClaimPrompt_B5"
@onready var claim_2_b_3: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel3/Claim2_B3"
@onready var claim_prompt_b_3: Label = $"../ShopPanel/Badges/VBoxContainer/BadgePanel3/ClaimPrompt_B3"
@onready var claim_1_b_3: Panel = $"../ShopPanel/Badges/VBoxContainer/BadgePanel3/Claim1_B3"

var upgrades: Array
var upgrade_labels: Array
var upgrade_counts:= [0,0,0,0,0,0,0]

var score: float = 0.0
var clicks_this_second: float = 0.0
var time_passed: float = 0.0
var aps: float = 0.0

signal score_100()
signal score_500()
signal score_420()
signal score_69()
signal score_1000()
var emitted_100 := false
var emitted_500 := false
var emitted_420 := false
var emitted_69  := false
var emitted_1000:= false

func _ready() -> void:
	clicker.connect("among_pressed", Callable(self, "_on_among_pressed"))
	clicker.connect("blue_bought", Callable(self, "_on_blue_bought"))
	clicker.connect("orange_bought", Callable(self, "_on_orange_bought"))
	clicker.connect("yellow_bought", Callable(self, "_on_yellow_bought"))
	clicker.connect("purple_bought", Callable(self, "_on_purple_bought"))
	clicker.connect("cyan_bought", Callable(self, "_on_cyan_bought"))
	
	upgrades = [
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade1/U1_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade2/U2_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade3/U3_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade4/U4_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade5/U5_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade6/U6_Button", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade7/U7_Button"
	]

	upgrade_labels = [
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade1/U1_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade2/U2_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade3/U3_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade4/U4_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade5/U5_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade6/U6_Label", 
		$"../ShopPanel/ClickersUpgrades/VBoxContainer/Upgrade7/U7_Label"
	]
	panel.show()
	save.show()
	save.connect("continue_pressed", Callable(self, "_on_continue_pressed"))
	save.connect("new_pressed", Callable(self, "_on_new_pressed"))
	for i in range(upgrade_labels.size()):
		print(i, " -> ", upgrade_labels[i])
	var has_save := FileAccess.file_exists("user://save.json")
	save.get_node("Panel/Continue").disabled = not has_save
	_shop_control()
	
	
func _on_continue_pressed():
	save.hide()
	panel.hide()
	_load_system()
	
func _on_new_pressed():
	save.hide()
	panel.hide()
	score = 0
	aps = 0
	clicks_this_second = 0
	time_passed = 0
	upgrade_counts = [0,0,0,0,0,0,0]
	for i in range(upgrades.size()):
		upgrades[i].remove_from_group("is_bought")
		upgrades[i].remove_from_group("is_unlocked")
	upgrade_labels[0].text = "15"
	upgrade_labels[1].text = "100"
	upgrade_labels[2].text = "500"
	upgrade_labels[3].text = "2000"
	upgrade_labels[4].text = "10000"
	upgrade_labels[5].text = "50000"
	upgrade_labels[6].text = "200000"
func _on_among_pressed() -> void:
	score += 1
	clicks_this_second += 1
	text = String.num(float(score), 1)
	_shop_control()
	
func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= 1.0:
		score += aps
		text = String.num(float(score), 1)
		var cps_value := float(clicks_this_second)
		cps.text = "Amongs per second: " + String.num(cps_value + aps, 2)
		clicks_this_second = 0
		time_passed = 0.0
		for i in range(upgrades.size()):
			var cost = int(upgrade_labels[i].text)
			if score >= cost:
				upgrades[i].add_to_group("is_unlocked")
				upgrades[i].disabled = false
	if score >= 100 and not emitted_100:
		emit_signal("score_100")
		emitted_100 = true
	if score >= 500 and not emitted_500:
		emit_signal("score_500")
		emitted_500 = true
	if score >= 420 and not emitted_420:
		emit_signal("score_420")
		emitted_420 = true
	if score >= 69 and not emitted_69:
		emit_signal("score_69")
		emitted_69 = true
	if score == 1000 and not emitted_1000:
		emit_signal("score_1000")
		emitted_1000 = true
	_shop_control()

func _shop_control() -> void:
	for i in range(upgrades.size()):
		var cost = int(upgrade_labels[i].text)
		if upgrades[i].is_in_group("is_bought") or upgrades[i].is_in_group("is_unlocked"):
			upgrades[i].disabled = false
		else:
			upgrades[i].disabled = score < cost


func _on_u_1_button_pressed() -> void:
	# Supposed to give 0.1 APS...
	if score < int(upgrade_labels[0].text):
		return
	score = score - int(upgrade_labels[0].text)
	text = String.num(float(score), 1)
	upgrade_counts[0] += 1
	aps += 0.1
	var button = upgrades[0]
	button.add_to_group("is_bought")
	var base_cost := 15
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[0])))
	upgrade_labels[0].text = str(next_cost)
func _on_u_2_button_pressed() -> void:
	if score < int(upgrade_labels[1].text):
		return
	score = score - int(upgrade_labels[1].text)
	text = String.num(float(score), 1)
	upgrade_counts[1] += 1
	aps += 1
	var button = upgrades[1]
	button.add_to_group("is_bought")
	var base_cost := 100
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[1])))
	upgrade_labels[1].text = str(next_cost)

func _on_u_3_button_pressed() -> void:
	if score < int(upgrade_labels[2].text):
		return
	score = score - int(upgrade_labels[2].text)
	text = String.num(float(score), 1)
	upgrade_counts[2] += 1
	aps += 5
	var button = upgrades[2]
	button.add_to_group("is_bought")
	var base_cost := 500
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[2])))
	upgrade_labels[2].text = str(next_cost)

func _on_u_4_button_pressed() -> void:
	if score < int(upgrade_labels[3].text):
		return
	score = score - int(upgrade_labels[3].text)
	text = String.num(float(score), 1)
	upgrade_counts[3]+= 1
	aps += 15
	var button = upgrades[3]
	button.add_to_group("is_bought")
	var base_cost := 2000
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[3])))
	upgrade_labels[3].text = str(next_cost)
	
func _on_u_5_button_pressed() -> void:
	if score < int(upgrade_labels[4].text):
		return
	score = score - int(upgrade_labels[4].text)
	text = String.num(float(score), 1)
	upgrade_counts[4] += 1
	aps += 80
	var button = upgrades[4]
	button.add_to_group("is_bought")
	var base_cost := 10000
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[4])))
	upgrade_labels[4].text = str(next_cost)
	
func _on_u_6_button_pressed() -> void:
	if score < int(upgrade_labels[5].text):
		return
	score = score - int(upgrade_labels[5].text)
	text = String.num(float(score), 1)
	upgrade_counts[5] += 1
	aps += 300
	var button = upgrades[5]
	button.add_to_group("is_bought")
	var base_cost := 50000
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[5])))
	upgrade_labels[5].text = str(next_cost)

func _on_u_7_button_pressed() -> void:
	if score < int(upgrade_labels[6].text):
		return
	score = score - int(upgrade_labels[6].text)
	text = String.num(float(score), 1)
	upgrade_counts[6] += 1
	aps += 1200
	var button = upgrades[6]
	button.add_to_group("is_bought")
	var base_cost := 200000
	@warning_ignore("unused_variable")
	var next_cost := 0
	next_cost = int(round(base_cost * pow(1.15, upgrade_counts[6])))
	upgrade_labels[6].text = str(next_cost)

func _save_system() -> void:
	var upgrades_data := []
	for i in range(upgrade_labels.size()):
		upgrades_data.append({
			"count": upgrade_counts[i],
			"price": int(upgrade_labels[i].text),
		})
	var save_data := {
		"clicks": score,
		"aps": aps,
		"upgrades_data": upgrades_data
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_system()

func _load_system() -> void:
	if not FileAccess.file_exists("user://save.json"):
		print("Save not found")
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(data) == TYPE_DICTIONARY:
		score = data.get("clicks", 0.0)
		text = String.num(score, 1)
		aps = data.get("aps", 0.0)
		var upgrades_data = data.get("upgrades_data", [])
		for i in range(upgrades_data.size()):
			upgrade_counts[i] = upgrades_data[i].get("count", 0)
			upgrade_labels[i].text = str(int(upgrades_data[i].get("price", upgrade_labels[i].text)))
			if upgrade_counts[i] > 0:
				upgrades[i].add_to_group("is_bought")
				upgrades[i].disabled = false
	elif typeof(data) != TYPE_DICTIONARY:
		print("Error")

# hey reviewer ik i could have just used one signal for all these but i realised after and im too 
# lazy to fix it so uh yeah
func _on_blue_bought() -> void:
	score -= 100
	text = String.num(float(score), 1)
func _on_yellow_bought() -> void:
	score -= 100
	text = String.num(float(score), 1)
func _on_orange_bought() -> void:
	score -= 100
	text = String.num(float(score), 1)
func _on_purple_bought() -> void:
	score -= 100
	text = String.num(float(score), 1)
func _on_cyan_bought() -> void:
	score -= 100
	text = String.num(float(score), 1)

signal badge1_claimed()
func _on_badge_panel_pressed() -> void:
	score += 25
	text = String.num(float(score), 1)
	claim_1.hide()
	claim_2.hide()
	claim_prompt.hide()
	emit_signal("badge1_claimed")

signal badge2_claimed()
func _on_badge_panel_2_pressed() -> void:
	score += 50
	text = String.num(float(score), 1)
	claim_1_b_2.hide()
	claim_2_b_2.hide()
	claim_prompt_b_2.hide()
	emit_signal("badge2_claimed")

signal badge4_claimed()
func _on_badge_panel_4_pressed() -> void:
	score += 42
	text = String.num(float(score), 1)
	claim_1_b_4.hide()
	claim_2_b_4.hide()
	claim_prompt_b_4.hide()
	emit_signal("badge4_claimed")

signal badge5_claimed()
func _on_badge_panel_5_pressed() -> void:
	score += 69
	text = String.num(float(score), 1)
	claim_1_b_5.hide()
	claim_2_b_5.hide()
	claim_prompt_b_5.hide()
	emit_signal("badge5_claimed")

signal badge3_claimed()
func _on_badge_panel_3_pressed() -> void:
	score += 500
	text = String.num(float(score), 1)
	claim_1_b_3.hide()
	claim_2_b_3.hide()
	claim_prompt_b_3.hide()
	emit_signal("badge3_claimed")
