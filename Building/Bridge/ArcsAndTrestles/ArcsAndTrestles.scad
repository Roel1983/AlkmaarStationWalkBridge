include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/TransformCopy.inc>

use <../Wall/Wall.scad>
use <Arc_Part.scad>
use <Trestle_Part.scad>

walk_bridge_config = WalkBridgeConfig();
ArcsAndTrestles(
    walk_bridge_config
);

module ArcsAndTrestles(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        WallSegmentWindowsSides(walk_bridge_config, "even") {
            Arc_Part(walk_bridge_config);
        }
        WallSegmentWindowsSides(walk_bridge_config, "odd") {
            rotate_copy(180, VEC_Z) {
                Trestle_Part(walk_bridge_config);
            }
        }
    }
}
