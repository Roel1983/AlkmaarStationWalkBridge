include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>
include <../../../Utils/TransformCopy.inc>
include <../../WalkBridge.inc>
include <Wall.inc>
include <../../Parts/BridgeArc.inc>
include <../../Parts/BridgeTrestle.inc>

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
            BridgeArc(walk_bridge_config);
        }
        BridgeWallSegmentWindowsSides(walk_bridge_config, "odd") {
            rotate_copy(180, VEC_Z) {
                BridgeTrestle(walk_bridge_config);
            }
        }
    }
}
