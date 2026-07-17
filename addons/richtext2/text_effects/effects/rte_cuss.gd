@tool
extends RichTextEffectBase
## "Censors" a word by replacing vowels with symbols.

## Syntax: [cuss][]
const bbcode = "cuss"

const VOWELS := "aeiouAEIOU"
const CUSS_CHARS := "&$!@*#%"
const IGNORE := " !?.,;\""

func _process_custom_fx(c: CharFXTransform):
	var txt := text
	var clr_name: String = c.env.get("cuss", "")
	var clr := RicherTextLabel.to_color(clr_name, c.color) if clr_name else c.color
	
	# Never censor first letter.
	if c.relative_index != 0:
		# Always censor vowels.
		if get_char(c) in VOWELS:
			set_char(c, CUSS_CHARS[int(rand_anim(c, 5.0, len(CUSS_CHARS)))])
			c.color = clr
	
	return true
