use <LedStripSegment.scad>
include <../../../WalkBridgeConfig.inc>

walk_bridge_config = WalkBridgeConfig();
LedStripSegment3_Part(
    walk_bridge_config,
    is_printable = true
);

module LedStripSegment3_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    LedStripSegment(
        walk_bridge_config = walk_bridge_config,
        is_printable       = is_printable,
        index              = 2
    );
}
