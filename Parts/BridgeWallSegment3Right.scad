include <../WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSegment3Right(walk_bridge_config);

module BridgeWallSegment3Right(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
}