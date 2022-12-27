include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

PlatformB(walk_bridge_config);

module PlatformB(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    text("PlatformB", valign="center", halign="center", size = distance_platform_a_b / 8);
}
