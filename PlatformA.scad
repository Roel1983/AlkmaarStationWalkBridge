include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

PlatformA(walk_bridge_config);

module PlatformA(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    text("PlatformA", valign="center", halign="center", size = distance_platform_a_b / 8);
}
