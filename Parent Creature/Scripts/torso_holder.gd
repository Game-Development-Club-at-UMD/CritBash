class_name TorsoHolder extends BaseBodyPartHolder

## Triggers when a new torso is instanced under this node
signal instancing_new_torso(new_torso : Torso)

func set_body_part(new_part : PackedScene):
	var instanced_part = new_part.instantiate()
	
	if !instanced_part is Torso:
		push_error("Error in node ", name, ": Attempted to set node of type ", instanced_part.get_class(), " to torso body part.")
		instanced_part.queue_free()
		return null
	
	add_child(instanced_part)
	instanced_part.owner = self.get_parent()
	instanced_part.global_transform = global_transform
	
	if body_part != null:
		body_part.queue_free()
	body_part = instanced_part
	instancing_new_torso.emit(body_part)

func get_body_part() -> BaseBodyPart:
	return body_part
