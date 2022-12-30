include <../../Utils/Box.inc>
include <../WalkBridge.inc>
include <misc/BridgeWallSupport.inc>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSupportRight(walk_bridge_config);

module BridgeWallSupportRight(
    walk_bridge_config,
    is_printable = false
) {
    BridgeWallSupport(
        walk_bridge_config,
        is_printable = is_printable,
        mirror_x = true
    );
}