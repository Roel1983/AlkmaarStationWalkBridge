include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>

use <Misc/BridgeWallSupport.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSupportLeft_Part(walk_bridge_config);

module BridgeWallSupportLeft_Part(
    walk_bridge_config,
    is_printable = false
) {
    BridgeWallSupport(
        walk_bridge_config,
        is_printable = is_printable,
        mirror_x = false
    );
}
