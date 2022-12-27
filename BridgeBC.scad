include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

BridgeBC(walk_bridge_config);

module BridgeBC(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    rotate(90) {
        text("BridgeBC", valign="center", halign="center", size = distance_platform_a_b / 8);
    }
}