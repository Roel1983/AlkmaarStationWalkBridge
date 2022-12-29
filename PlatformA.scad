include <WalkBridge.inc>
use <Platform.scad>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

PlatformA(walk_bridge_config);

module PlatformA(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config,    "PlatformConfig"));
    
    Platform(
        walk_bridge_config = walk_bridge_config,
        platform_config    = platform_config
    );
}
