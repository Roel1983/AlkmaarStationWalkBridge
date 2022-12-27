include <../Utils/Config.inc>
include <../Utils/Units.inc>
use<WalkBridge.scad>

function WalkBridgeConfig(
    distance_platform_a_b = cm(60),
    distance_platform_b_c = cm(25),
    bridge_clearance      = cm(10)
) = Config(undef,
    "WalkBridgeConfig",
    [
        ["distance_platform_a_b", distance_platform_a_b],
        ["distance_platform_b_c", distance_platform_b_c]
    ]
);
