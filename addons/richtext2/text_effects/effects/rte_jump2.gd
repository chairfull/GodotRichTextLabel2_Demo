@tool
extends RichTextEffectBase

## Syntax: [jump2 scale=1.0 angle=0 speed=6.0][]
var bbcode = "jump2"

func _process_custom_fx(c: CharFXTransform):
	var lbl := label
	var scale: float = c.env.get("scale", 1.0) * .25 * lbl.font_size * weight
	var angle := deg_to_rad(c.env.get("angle", 0))
	var speed: float = c.env.get("speed", 6.0)
	
	var s := sin(-c.elapsed_time * speed + c.relative_index * PI * .125)
	s = -maxf(0.0, s)
	s *= scale
	c.offset.x += sin(angle) * s
	c.offset.y += cos(angle) * s
	return true
