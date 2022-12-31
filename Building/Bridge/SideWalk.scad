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
    
    //color(alpha = .2)  Ghost();
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
    
    module Ghost() {
        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
        
        bridge_size              = scaled(m([4.5, 3.0]));
        
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
        bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
        bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
        
        bridge_length = distance_platform_a_b + distance_platform_b_c;
       
        mirror_copy(VEC_X) Box(
            x_from = bridge_size[0] / 2 + mm(2),
            x_to   = bridge_size[0] / 2 + scaled(m(1)),
            y_from = 0,
            y_to   = distance_platform_a_b + distance_platform_b_c,
            z_from = bridge_height + scaled(m(.5)),
            z_size = mm(1)
        );
    }
}