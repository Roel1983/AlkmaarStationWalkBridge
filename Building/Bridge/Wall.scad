include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Optional.inc>
include <../../../Utils/TransformCopy.inc>

include <../../WalkBridge.inc>
include <../../Parts/BridgeWallSegment1Left.inc>
include <../../Parts/BridgeWallSegment1Right.inc>
include <../../Parts/BridgeWallSegment2Left.inc>
include <../../Parts/BridgeWallSegment2Right.inc>
include <../../Parts/BridgeWallSegment3Left.inc>
include <../../Parts/BridgeWallSegment3Right.inc>
include <../../Parts/BridgeWallSupportLeft.inc>
include <../../Parts/BridgeWallSupportRight.inc>

walk_bridge_config = WalkBridgeConfig();
Wall(
    walk_bridge_config
);

module Wall(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BridgeWallSegment1Left (walk_bridge_config);
        BridgeWallSegment1Right(walk_bridge_config);
        BridgeWallSupportLeft  (walk_bridge_config);
        BridgeWallSupportRight (walk_bridge_config);
        BridgeWallSegment2Left (walk_bridge_config);
        BridgeWallSegment2Right(walk_bridge_config);
        BridgeWallSegment3Left (walk_bridge_config);
        BridgeWallSegment3Right(walk_bridge_config);
    }
}

module BridgeWallSegmentWindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    BridgeWallSegment1WindowsSides(walk_bridge_config, what, vec) children();
    BridgeWallSegment2WindowsSides(walk_bridge_config, what, vec) children();
    BridgeWallSegment3WindowsSides(walk_bridge_config, what, vec) children();
}

module BridgeWallSegment1WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    BridgeWallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children(); 
}

module BridgeWallSegment2WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment2_config");
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    BridgeWallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children(); 
}

module BridgeWallSegment3WindowsSides(walk_bridge_config, what, vec) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment3_config");
    BridgeWallSegmentNWindowsSides(
        wall_segment_config = wall_segment_config,
        what                = what,
        vec                 = vec
    ) children();
}


module BridgeWallSegmentNWindowsSides(wall_segment_config, what, vec = VEC_Y) {
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