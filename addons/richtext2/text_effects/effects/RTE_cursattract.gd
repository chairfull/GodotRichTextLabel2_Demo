@tool
extends RichTextEffectBase
## Pulls characters towards the cursor.

## Syntax: [cursattract][]
const bbcode = "cursattract"

func _process_custom_fx(c: CharFXTransform):
	var dif := c.transform.origin - get_label().get_local_mouse_position()
	var dis := dif.length()
	var nrm := dif.normalized()
	c.transform.origin -= nrm * clampf(pow(dis * .1, 4.0), 0.1, 4.0)
	return true
