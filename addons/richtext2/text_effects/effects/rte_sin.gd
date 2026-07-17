@tool
extends RichTextEffectBase
## Sine wave effect.

## Syntax: [sin][]
var bbcode = "sin"

func _process_custom_fx(c: CharFXTransform):
	var scale: float = c.env.get("sin", 1.0) * font_size * .125 * weight
	var freq: float = c.env.get("freq", 1.0)
	var speed: float = c.env.get("speed", 12.0)
	c.offset.y += weight * sin(c.elapsed_time * speed + c.range.x * freq) * scale
	return true
