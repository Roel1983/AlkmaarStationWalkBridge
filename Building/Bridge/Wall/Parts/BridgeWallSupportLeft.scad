include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>

use <Misc/BridgeWallSupport.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSupportLeft(walk_bridge_config);

module BridgeWallSupportLeft(
    walk_bridge_config,
    is_printable = false
) {
    BridgeWallSupport(
        walk_bridge_config,
        is_printable = is_printable,
        mirror_x = false
    );
}
