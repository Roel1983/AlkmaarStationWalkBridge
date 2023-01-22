use <LedStripSegment.scad>
include <../../../WalkBridgeConfig.inc>

walk_bridge_config = WalkBridgeConfig();
LedStripSegment2_Part(
    walk_bridge_config
);

module LedStripSegment2_Part(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    LedStripSegment(
        walk_bridge_config,
        1
    );
}
