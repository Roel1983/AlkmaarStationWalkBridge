include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Box.inc>
include <../../WalkBridge.inc>
include <Floor/FloorBegin.inc>
include <Floor/FloorCenter.inc>
include <Floor/FloorEnd.inc>

walk_bridge_config = WalkBridgeConfig();
Floor(
    walk_bridge_config,
    xray = false
);

module Floor(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        FloorBegin (walk_bridge_config, colorize = false);
        FloorCenter(walk_bridge_config, colorize = false);
        FloorEnd   (walk_bridge_config, colorize = false);
    }
}