@tool
extends RichTextEffectBase

## Syntax: [rain][]
var bbcode = "rain"

func _process_custom_fx(c: CharFXTransform):
	var rand := get_rand(c)
	var r := fmod(sin(c.relative_index) + c.glyph_index + c.elapsed_time * .8, 1.0) * weight
	c.offset.y += (r - .25) * 8.0
	c.color.a = lerp(c.color.a, 0.0, r)
	return true
