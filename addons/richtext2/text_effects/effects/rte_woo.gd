@tool
extends RichTextEffectBase
## Best with a monospaced font. Sarcasm effect that alternates upper and lower case.
 
## Syntax: [woo][]
var bbcode = "woo"

func _process_custom_fx(c: CharFXTransform):
	
	if sin(c.elapsed_time * 6.0 + c.relative_index * 2.0) * 2.0 < 0.0:
		var ch := get_char(c)
		if ch == ch.to_lower():
			set_char(c, ch.to_upper())
		elif ch == ch.to_upper():
			set_char(c, ch.to_lower())
	return true
