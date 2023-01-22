use <LedStripSegment.scad>
include <../../../WalkBridgeConfig.inc>

walk_bridge_config = WalkBridgeConfig();
LedStripSegment3_Part(
    walk_bridge_config
);

module LedStripSegment3_Part(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    LedStripSegment(
        walk_bridge_config,
        2
    );
}
