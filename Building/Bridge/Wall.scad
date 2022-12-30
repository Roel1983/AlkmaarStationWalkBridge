include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>
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
    
    //color(alpha = .2)  Ghost();
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
    
    module Ghost() {
        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
        
        bridge_size              = scaled(m([4.5, 3.0]));
        
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
        bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
        bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
        
        bridge_length = distance_platform_a_b + distance_platform_b_c;
       
        mirror_copy(VEC_X) Box(
            x_to   = bridge_size[0] / 2,
            x_size = bridge_wall,
            y_from = 0,
            y_to   = distance_platform_a_b + distance_platform_b_c,
            z_from = bridge_height,
            z_size = bridge_size[1]
        );
    }
}