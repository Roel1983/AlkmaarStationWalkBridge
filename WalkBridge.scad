include <../Utils/Config.inc>
include <../Utils/Units.inc>
include <WalkBridge.inc>
include <PlatformA.inc>
include <PlatformB.inc>
include <PlatformC.inc>
include <BridgeAB.inc>
include <BridgeBC.inc>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

WalkBridge(walk_bridge_config);

module WalkBridge(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(WalkBridgeConfig, "distance_platform_b_c");
    
    PlatformA(WalkBridgeConfig);
    translate([0, distance_platform_a_b / 2]) BridgeAB (WalkBridgeConfig);
    translate([0, distance_platform_a_b])     PlatformB(WalkBridgeConfig);
    translate([0, distance_platform_a_b + distance_platform_b_c / 2]) BridgeBC (WalkBridgeConfig);
    translate([0, distance_platform_a_b + distance_platform_b_c])     PlatformC(WalkBridgeConfig);
}
