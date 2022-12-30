include <../../Utils/GlueTogether.inc>
include <../WalkBridge.inc>
include <Platform.inc>

walk_bridge_config = WalkBridgeConfig();
PlatformB(
    walk_bridge_config
);

module PlatformB(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    color(alpha = .2) Ghost();
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        
    }
    
    module Ghost() {
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        platform_config = ConfigGet(walk_bridge_config, "platform_b_config");
        assert(is_config(platform_config,    "PlatformConfig"));
        
        
        translate([0, distance_platform_a_b]) {
            Platform(
                walk_bridge_config = walk_bridge_config,
                platform_config    = platform_config,
                mirror_y           = true
            );
        }
    }
}