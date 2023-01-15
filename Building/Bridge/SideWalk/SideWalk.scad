include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/Box.inc>
include <../../../../Utils/TransformCopy.inc>

use <BridgeSideWalkSegment1Left_Part.scad>
use <BridgeSideWalkSegment1Right_Part.scad>
use <BridgeSideWalkSegment2Left_Part.scad>
use <BridgeSideWalkSegment2Right_Part.scad>
use <BridgeSideWalkSegment3Left_Part.scad>
use <BridgeSideWalkSegment3Right_Part.scad>

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
        BridgeSideWalkSegment1Left_Part (walk_bridge_config);
        BridgeSideWalkSegment1Right_Part(walk_bridge_config);
        BridgeSideWalkSegment2Left_Part (walk_bridge_config);
        BridgeSideWalkSegment2Right_Part(walk_bridge_config);
        BridgeSideWalkSegment3Left_Part (walk_bridge_config);
        BridgeSideWalkSegment3Right_Part(walk_bridge_config);
    }
}