include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/Optional.inc>
include <../../../../Utils/TransformCopy.inc>

use <WallSegment1Left_Part.scad>
use <WallSegment1Right_Part.scad>
use <WallSegment2Left_Part.scad>
use <WallSegment2Right_Part.scad>
use <WallSegment3Left_Part.scad>
use <WallSegment3Right_Part.scad>
use <WallSupportLeft_Part.scad>
use <WallSupportRight_Part.scad>

walk_bridge_config = WalkBridgeConfig();
Wall(
    walk_bridge_config,
    colorize = false
);

module Wall(
    walk_bridge_config,
    xray     = false,
    colorize = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        WallSegment1Left_Part (walk_bridge_config);
        WallSegment1Right_Part(walk_bridge_config);
        WallSupportLeft_Part  (walk_bridge_config);
        WallSupportRight_Part (walk_bridge_config);
        WallSegment2Left_Part (walk_bridge_config);
        WallSegment2Right_Part(walk_bridge_config);
        WallSegment3Left_Part (walk_bridge_config);
        WallSegment3Right_Part(walk_bridge_config);
    }
}

module WallSegmentWindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    WallSegment1WindowsSides(walk_bridge_config, what, vec) children();
    WallSegment2WindowsSides(walk_bridge_config, what, vec) children();
    WallSegment3WindowsSides(walk_bridge_config, what, vec) children();
}

module WallSegment1WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    WallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children(); 
}

module WallSegment2WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment2_config");
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    WallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children(); 
}

module WallSegment3WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment3_config");
    WallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children();
}


module WallSegmentNWindowsSides(wall_segment_config, what, vec = VEC_Y) {
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    pos_y              = ConfigGet(wall_segment_config, "pos_y");
    window_panel_count = ConfigGet(wall_segment_config, "window_panel_count");
    window_panel_width = ConfigGet(wall_segment_config, "window_panel_width");
    offset_begin       = ConfigGet(wall_segment_config, "offset_begin");
    
    _vec = optional(vec, VEC_Y);
    
    for(i = [0:window_panel_count]) {
        translate(_vec * (offset_begin + pos_y + window_panel_width * i)) {
            if (what == "even") {
                if (i % 2 == 0) children();
            } else if (what == "odd") {
                if (i % 2 == 1) children();
            } else {
                children();
            }
        }
    }
}