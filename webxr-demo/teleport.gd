extends XRController3D

@onready var ray: RayCast3D = $TeleportRay
@onready var marker: MeshInstance3D = $TeleportMarker
var xr_origin: XROrigin3D
var xr_camera: XRCamera3D

func _ready() -> void:
	xr_origin = get_parent() as XROrigin3D
	xr_camera = xr_origin.get_node("XRCamera3D") as XRCamera3D
	marker.visible = false

func _process(_delta: float) -> void:
	if ray.is_colliding():
		marker.global_transform.origin = ray.get_collision_point()
		marker.visible = true
	else:
		marker.visible = false

func teleport_now() -> void:
	if not ray.is_colliding():
		return

	var target: Vector3 = ray.get_collision_point()

	var origin_pos := xr_origin.global_transform.origin
	var camera_pos := xr_camera.global_transform.origin

	var offset := camera_pos - origin_pos
	offset.y = 0.0

	xr_origin.global_transform.origin = target - offset
