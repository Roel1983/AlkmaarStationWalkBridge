include <../../../WalkBridgeConfig.inc>

use <Misc/RoofSection.scad>

walk_bridge_config = WalkBridgeConfig();
RoofAbBegin_Part(
    walk_bridge_config,
    is_printable = true
);

module RoofAbBegin_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
    platform_config         = ConfigGet(walk_bridge_config, "platform_a_config");
    
    RoofSectionBegin(
        roof_segment_config,
        is_printable = is_printable,
        platform_config = platform_config
    );
}
