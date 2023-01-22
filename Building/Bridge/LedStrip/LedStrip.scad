include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>
use <LedStripSegment1_Part.scad>
use <LedStripSegment2_Part.scad>
use <LedStripSegment3_Part.scad>
use <LedStripSegment4_Part.scad>

walk_bridge_config = WalkBridgeConfig();
LedStrip(
    walk_bridge_config
);

module LedStrip(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        LedStripSegment1_Part(walk_bridge_config);
        LedStripSegment2_Part(walk_bridge_config);
        LedStripSegment3_Part(walk_bridge_config);
        LedStripSegment4_Part(walk_bridge_config);
    }
}