extends Label

@onready var clicker: Control = $".."
@onready var cps: Label = $"../CPS"
var score: int = 0
var clicks_this_second: int = 0
var time_passed: float = 0.0

func _ready() -> void:
	clicker.connect("among_pressed", Callable(self, "_on_among_pressed"))
	
func _on_among_pressed() -> void:
	score += 1
	clicks_this_second += 1
	text = "Amongs: " + str(score)
	
func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= 1.0:
		var cps_value := float(clicks_this_second)
		cps.text = "Amongs per second: " + String.num(cps_value, 2)
		clicks_this_second = 0
		time_passed = 0.0
