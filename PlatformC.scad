include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

PlatformC(walk_bridge_config);

module PlatformC(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    text("PlatformC", valign="center", halign="center", size = distance_platform_a_b / 8);
}
