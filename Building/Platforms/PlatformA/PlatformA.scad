include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>

use <Base/Base.scad>
use <AbriRoof/AbriRoof.scad>
use <Tower2Head/Tower2Head.scad>

use <../misc/Platform.scad>

walk_bridge_config = WalkBridgeConfig();
PlatformA(
    walk_bridge_config
);

module PlatformA(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    //color(alpha = .2)  Ghost();
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        Base      (walk_bridge_config, colorize = false);
        AbriRoof  (walk_bridge_config, colorize = false);
        Tower2Head(walk_bridge_config, colorize = false);
    }
    
    module Ghost() {
        platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
        assert(is_config(platform_config,    "PlatformConfig"));
        
        Platform(
            walk_bridge_config = walk_bridge_config,
            platform_config    = platform_config
        );
    }
}