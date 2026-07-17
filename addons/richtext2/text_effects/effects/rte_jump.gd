@tool
extends RichTextEffectBase #Changed from "extends RichTextEffect" to take advantage of RichTextEffectBase's "get_char()"

## Syntax: [jump scale=][]
var bbcode = "jump"

const SPLITTERS := " .,"

var _w_char = 0
var _last = 999

func _process_custom_fx(c:CharFXTransform):
	var lbl := label
	var scale: float = c.env.get("scale", 1.0) * .25 * lbl.font_size * weight
	var angle: float = deg_to_rad(c.env.get("angle", 0))
	var speed: float = c.env.get("speed", 6.0)
	
	if c.range.x < _last or get_char(c) in SPLITTERS:
		_w_char = c.range.x
	
	_last = c.range.x
	var s = sin(-c.elapsed_time * speed + _w_char * .2)
	s = -maxf(0.0, s)
	s *= scale
	c.offset.x += sin(angle) * s
	c.offset.y += cos(angle) * s
	return true
