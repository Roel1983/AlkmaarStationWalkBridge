include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/TransformCopy.inc>

use <../Wall/Wall.scad>
use <BridgeArc_Part.scad>
use <BridgeTrestle_Part.scad>

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
        BridgeWallSegmentWindowsSides(walk_bridge_config, "even") {
            BridgeArc_Part(walk_bridge_config);
        }
        BridgeWallSegmentWindowsSides(walk_bridge_config, "odd") {
            rotate_copy(180, VEC_Z) {
                BridgeTrestle_Part(walk_bridge_config);
            }
        }
    }
}
