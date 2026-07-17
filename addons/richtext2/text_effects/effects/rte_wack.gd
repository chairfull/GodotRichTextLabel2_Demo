@tool
extends RichTextEffectBase
## Wacky random animations.
## Randomly scales and rotates characters.

## [wack freq=1.0]
var bbcode := "wack"

func _process_custom_fx(c: CharFXTransform):
	var freq: float = c.env.get("freq", 1.0)
	var cs := get_char_size(c) * Vector2(0.5, -0.3)
	c.transform *= Transform2D.IDENTITY.translated(cs)
	c.transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 + cos(get_rand(c) * .5 + c.relative_index * 3.0 + c.elapsed_time * 1.3 * freq) * .15) * weight)
	c.transform *= Transform2D.IDENTITY.translated(-cs)
	return true
