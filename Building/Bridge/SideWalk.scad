include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Box.inc>
include <../../../Utils/TransformCopy.inc>
include <../../WalkBridge.inc>
include <../../Parts/BridgeSideWalkSegment1Left.inc>
include <../../Parts/BridgeSideWalkSegment1Right.inc>
include <../../Parts/BridgeSideWalkSegment2Left.inc>
include <../../Parts/BridgeSideWalkSegment2Right.inc>
include <../../Parts/BridgeSideWalkSegment3Left.inc>
include <../../Parts/BridgeSideWalkSegment3Right.inc>

walk_bridge_config = WalkBridgeConfig();
SideWalk(
    walk_bridge_config
);

module SideWalk(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BridgeSideWalkSegment1Left (walk_bridge_config);
        BridgeSideWalkSegment1Right(walk_bridge_config);
        BridgeSideWalkSegment2Left (walk_bridge_config);
        BridgeSideWalkSegment2Right(walk_bridge_config);
        BridgeSideWalkSegment3Left (walk_bridge_config);
        BridgeSideWalkSegment3Right(walk_bridge_config);
    }
}