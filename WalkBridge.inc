SCALED_SCALE = "H0";
include <../Utils/Scaled.inc>
include <../Utils/Config.inc>
include <../Utils/Units.inc>
use<WalkBridge.scad>

function WalkBridgeConfig(
    distance_platform_a_b = mm(464.25), // ??? Assumption based on H0 space distance
    distance_platform_b_c = mm(215.7),  // ??? Assumption based on H0 space distance
    bridge_clearance      = scaled(m(5.2))
) = Config(undef,
    "WalkBridgeConfig",
    [
        ["distance_platform_a_b", distance_platform_a_b],
        ["distance_platform_b_c", distance_platform_b_c],
        ["bridge_clearance",      bridge_clearance]
    ]
);
