include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

BridgeAB(walk_bridge_config);

module BridgeAB(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    rotate(90) {
        text("BridgeAB", valign="center", halign="center", size = distance_platform_a_b / 8);
    }
}