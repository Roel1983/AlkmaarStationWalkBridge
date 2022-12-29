include <WalkBridge.inc>
use <Platform.scad>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

PlatformB(walk_bridge_config);

module PlatformB(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_b_config");
    assert(is_config(platform_config,    "PlatformConfig"));
    
    Platform(
        walk_bridge_config = walk_bridge_config,
        platform_config    = platform_config,
        mirror_y           = true
    );
}
