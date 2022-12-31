UNITS_NOZZLE = mm(.4);
include <../../Utils/Box.inc>
include <../../Utils/LinearExtrude.inc>
include <../WalkBridge.inc>
include <misc/BridgeRoofSection.inc>

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
    BridgeRoofSectionEnd(roof_segment_config, is_printable = is_printable);
}
