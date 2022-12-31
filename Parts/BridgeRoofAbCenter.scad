UNITS_NOZZLE = mm(.4);
include <../../Utils/Box.inc>
include <../../Utils/LinearExtrude.inc>
include <../WalkBridge.inc>
include <misc/BridgeRoofSection.inc>

walk_bridge_config = WalkBridgeConfig();
BridgeRoofAbCenter(
    walk_bridge_config,
    is_printable = true
);

module BridgeRoofAbCenter(
    walk_bridge_config,
    index        = 0,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
    BridgeRoofSectionCenter(
        roof_segment_config,
        index        = index,
        is_printable = is_printable
    );
}