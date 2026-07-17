@tool
extends RichTextEffectBase
## Fades words in one at a time.

## Syntax: [fader][]
var bbcode = "fader"

func _process_custom_fx(c: CharFXTransform):
	c.color.a *= get_char_delta(c)
	send_back_transform(c)
	return true
