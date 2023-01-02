include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/Box.inc>
include <../../../../Utils/TransformCopy.inc>

use <Parts/BridgeSideWalkSegment1Left.scad>
use <Parts/BridgeSideWalkSegment1Right.scad>
use <Parts/BridgeSideWalkSegment2Left.scad>
use <Parts/BridgeSideWalkSegment2Right.scad>
use <Parts/BridgeSideWalkSegment3Left.scad>
use <Parts/BridgeSideWalkSegment3Right.scad>

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