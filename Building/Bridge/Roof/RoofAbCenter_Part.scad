include <../../../WalkBridgeConfig.inc>

use <Misc/RoofSection.scad>

walk_bridge_config = WalkBridgeConfig();
RoofAbCenter_Part(
    walk_bridge_config,
    is_printable = true
);

module RoofAbCenter_Part(
    walk_bridge_config,
    index        = 0,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
    RoofSectionCenter(
        roof_segment_config,
        index        = index,
        is_printable = is_printable
    );
}
