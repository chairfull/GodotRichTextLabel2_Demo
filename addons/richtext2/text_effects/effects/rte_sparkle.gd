@tool
extends RichTextEffectBase

## Syntax: [sparkle][]
var bbcode = "sparkle"

func _process_custom_fx(c: CharFXTransform) -> bool:
	var s = 1.0 - c.color.s
	var speed := c.elapsed_time * 4.0
	c.color.h = wrapf(c.color.h + sin(-speed + c.glyph_index * 2.0) * s * .033 * weight, 0.0, 1.0)
	c.color.v = clamp(c.color.v + sin(speed + c.glyph_index) * .25 * weight, 0.0, 1.0)
	return true
