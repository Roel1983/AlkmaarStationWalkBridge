include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <AbriRoof_Part.scad>

walk_bridge_config = WalkBridgeConfig();
AbriRoof(
    walk_bridge_config
);

module AbriRoof(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        AbriRoof_Part(walk_bridge_config);
    }
}