use <LedStripSegment.scad>
include <../../../WalkBridgeConfig.inc>

walk_bridge_config = WalkBridgeConfig();
LedStripSegment4_Part(
    walk_bridge_config
);

module LedStripSegment4_Part(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    LedStripSegment(
        walk_bridge_config,
        3
    );
}
