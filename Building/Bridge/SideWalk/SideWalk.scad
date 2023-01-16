include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/Box.inc>
include <../../../../Utils/TransformCopy.inc>

use <SideWalkSegment1Left_Part.scad>
use <SideWalkSegment1Right_Part.scad>
use <SideWalkSegment2Left_Part.scad>
use <SideWalkSegment2Right_Part.scad>
use <SideWalkSegment3Left_Part.scad>
use <SideWalkSegment3Right_Part.scad>

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
        SideWalkSegment1Left_Part (walk_bridge_config);
        SideWalkSegment1Right_Part(walk_bridge_config);
        SideWalkSegment2Left_Part (walk_bridge_config);
        SideWalkSegment2Right_Part(walk_bridge_config);
        SideWalkSegment3Left_Part (walk_bridge_config);
        SideWalkSegment3Right_Part(walk_bridge_config);
    }
}