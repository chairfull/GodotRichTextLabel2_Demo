@tool
extends RichTextEffect
class_name RichTextEffectBase

const c1 := 1.70158
const c3 := c1 + .5

var label_richtext: RichTextLabel:
	get:
		if not label_richtext:
			var rtid := get_meta(&"rt")
			if rtid:
				label_richtext = instance_from_id(rtid)
		return label_richtext

var label: RicherTextLabel:
	get: return label_richtext

var label_anim: RichTextAnimation:
	get: return label_richtext

var text: String:
	get: return label.get_parsed_text()

var weight: float:
	get: return label.effect_weight if label else 1.0

var font_size: int:
	get: return label.font_size
#func ease_back(x):
	#return c3 * x * x * x - c1 * x * x

func ease_back_in(t: float, s: float = 1.70158) -> float:
	return t * t * ((s + 1) * t - s)

func ease_back_out(t: float, s: float = 1.70158) -> float:
	t -= 1
	return t * t * ((s + 1) * t + s) + 1

func ease_back_in_out(t: float, s: float = 1.70158) -> float:
	s *= 1.525
	if t < 0.5:
		t *= 2
		return 0.5 * (t * t * ((s + 1) * t - s))
	t -= 1
	t *= 2
	return 0.5 * (t * t * ((s + 1) * t + s) + 2)

func ease_back(t: float, s: float = 1.70158) -> float:
	t -= 1
	return t * t * ((s + 1) * t + s) + 1

func get_mouse_pos(c: CharFXTransform) -> Vector2:
	var lbl := label
	var frame := lbl.get_tree().get_frame()
	if frame != lbl.get_meta(&"frame", 0):
		var mp := lbl.get_local_mouse_position()
		lbl.set_meta(&"mouse_position", mp)
		lbl.set_meta(&"frame", frame)
		return mp
	return lbl.get_meta(&"mouse_position")

func get_char(c: CharFXTransform) -> String:
	return text[c.range.x]

func set_char(c: CharFXTransform, new_char: String):
	var text_server = TextServerManager.get_primary_interface()
	c.glyph_index = text_server.font_get_glyph_index(c.font, 16, new_char.unicode_at(0), 0)

func get_char_size(c: CharFXTransform) -> Vector2:
	return label.get_normal_font().get_string_size(get_char(c))

func rand2(c: CharFXTransform, wrap := 1.0) -> float:
	return fmod(c.relative_index * .25 + label._get_character_random(c.range.x) * .03, wrap)

func rand(c: CharFXTransform, wrap := 1.0) -> float:
	return fmod(c.relative_index * .25 + label._get_character_random(c.range.x) * .01, wrap)

func rand_anim(c: CharFXTransform, anim_speed := 1.0, wrap := 1.0) -> float:
	return fmod(c.elapsed_time * anim_speed + c.relative_index * .25 + label._get_character_random(c.range.x) * .01, wrap)

func get_rand(c: CharFXTransform) -> int:
	return label._get_character_random(c.range.x)

# Only works for RichTextAnimation effects.
func get_char_delta(c: CharFXTransform) -> float:
	var lbl := label_anim
	return 1.0 if not lbl else lbl._get_character_alpha(c.range.x)

func is_animation_fading_out() -> bool:
	return label_anim.fade_out

# Returns the last characters transformation so we can use it for end of text animations.
func send_back_transform(c: CharFXTransform):
	var lbl := label_anim
	var index := c.relative_index
	if index > 0 and index < len(lbl._transforms):
		var ts := TextServerManager.get_primary_interface()
		var font_size := lbl.font_size
		var off_x := ts.font_get_glyph_size(c.font, Vector2i(font_size, 0), c.glyph_index).x
		var off_y := ts.font_get_ascent(c.font, font_size) - ts.font_get_descent(c.font, font_size)
		lbl._char_size[index] = Vector2(off_x, off_y)
		lbl._transforms[index] = c.transform
