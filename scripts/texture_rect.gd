extends TextureRect

var time_spent := [
	{"timer": 3600, "callback": "play_event_1hr"}, # 1hr
	{"timer": 7200, "callback": "play_event_2hr"},
	{"timer": 36000, "callback": "play_event_10hr"}
]
var elapsed_time := 0.0
var testing_bool := false
func _ready() -> void:
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	for event in time_spent:
		if "triggered" not in event and elapsed_time >= event.timer:
			call(event.callback)
			event["triggered"] = true

func play_event_1hr() -> void:
	DialogueManager.show_dialogue_balloon_scene(load("res://scenes/lil_pink.tscn"),load("res://assets/dialogue/player_1hr.dialogue"))
