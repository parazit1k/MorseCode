extends Control

@onready var code = $Text/CodeText
@onready var letter = $Text/LetterText
@onready var button = $generateButton

@onready var dip = $dip
@onready var dah = $dah

var previous_letter = ""
var previous_type = ""
var random_letter: String = ""

var morse_letters = {
	"A": ".-",
	"B": "-...",
	"C": "-.-.",
	"D": "-..",
	"E": ".",
	"F": "..-.",
	"G": "--.",
	"H": "....",
	"I": "..",
	"J": ".---",
	"K": "-.-",
	"L": ".-..",
	"M": "--",
	"N": "-.",
	"O": "---",
	"P": ".--.",
	"Q": "--.-",
	"R": ".-.",
	"S": "...",
	"T": "-",
	"U": "..-",
	"V": "...-",
	"W": ".--",
	"X": "-..-",
	"Y": "-.--",
	"Z": "--.."
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_generate_button_pressed():
	button.disabled = true
	code.text = ""
	letter.text = ""
	while true:
		random_letter = morse_letters.keys()[randi_range(0, morse_letters.size()-1)]
		if previous_letter != random_letter:
			previous_letter = random_letter
			break
	
	# letter.text = random_letter
	write_code(morse_letters[random_letter])

func write_code(code_string: String):
	for dot in code_string:
		if dot == "-":
			dah.play()
		else:
			dip.play()
		code.text += dot
		await get_tree().create_timer(0.35).timeout
	
	button.disabled = false


func _on_letter_text_text_changed(new_text: String):
	if new_text.length() > 1:
		letter.text = new_text.replace(previous_type, "")
	if letter.text.to_lower() == random_letter.to_lower():
		letter.add_theme_color_override("font_color",Color(0,255,0))
	else:
		letter.add_theme_color_override("font_color",Color(255,0,0))
	
	previous_type = new_text
