include <../WalkBridgeConfig.inc>

use <misc/BridgeRoofSection.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeRoofAbEnd(
    walk_bridge_config,
    is_printable = true
);

module BridgeRoofAbEnd(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
    platform_config         = ConfigGet(walk_bridge_config, "platform_b_config");
    
    BridgeRoofSectionEnd(
        roof_segment_config,
        is_printable = is_printable,
        platform_config = platform_config
    );
}
