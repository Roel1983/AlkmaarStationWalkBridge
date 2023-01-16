include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>

use <Misc/WallSupport.scad>

walk_bridge_config = WalkBridgeConfig();
WallSupportRight_Part(walk_bridge_config);

module WallSupportRight_Part(
    walk_bridge_config,
    is_printable = false
) {
    WallSupport(
        walk_bridge_config,
        is_printable = is_printable,
        mirror_x = true
    );
}