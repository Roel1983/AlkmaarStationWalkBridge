include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Box.inc>
include <../../WalkBridge.inc>
include <Floor/FloorBegin.inc>
include <Floor/FloorCenter.inc>
include <Floor/FloorEnd.inc>

walk_bridge_config = WalkBridgeConfig();
Floor(
    walk_bridge_config
);

module Floor(
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
        FloorBegin (walk_bridge_config, colorize = false);
        FloorCenter(walk_bridge_config, colorize = false);
        FloorEnd   (walk_bridge_config, colorize = false);
    }
    
    module Ghost() {
        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
        
        bridge_size_xz        = ConfigGet(walk_bridge_config, "bridge_size_xz");
        
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
        bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
        bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
        
        bridge_length = distance_platform_a_b + distance_platform_b_c;
       
        Box(
            x_size = bridge_size_xz[0] - 2 * bridge_wall,
            y_from = 0,
            y_to   = distance_platform_a_b + distance_platform_b_c,
            z_from = bridge_height,
            z_size = mm(3.4)
        );
    }
}