include <../Utils/Config.inc>
include <../Utils/Constants.inc>
include <../Utils/Box.inc>
include <../Utils/TransformCopy.inc>
include <../Utils/Units.inc>
include <WalkBridge.inc>
include <PlatformA.inc>
include <PlatformB.inc>
include <PlatformC.inc>
include <BridgeAB.inc>
include <BridgeBC.inc>
include <../Utils/Box.inc>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

WalkBridge(walk_bridge_config);

module WalkBridge(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(WalkBridgeConfig, "distance_platform_b_c");
    
    PlatformA(WalkBridgeConfig);
    Box(
        x_size = mm(300),
        y_size = mm(89.2),
        z_from = mm(-12)
        
    );
    
    translate([0, distance_platform_a_b / 2]) {
        BridgeAB (WalkBridgeConfig);
    }
    
    translate([0, distance_platform_a_b]) {
        PlatformB(WalkBridgeConfig);
        Box(
            x_size = mm(300),
            y_size = mm(129.2),
            z_from = mm(-12)
        );
    }
    
    translate([0, distance_platform_a_b + distance_platform_b_c / 2]) {
        BridgeBC (WalkBridgeConfig);
    }
    
    translate([0, distance_platform_a_b + distance_platform_b_c]) {
        PlatformC(WalkBridgeConfig);
        Box(
            x_size = mm(300),
            y_size = mm(80.2),
            z_to   = mm(-11.5),
            z_from = mm(-12)
        );
    }
    for(i = [1,2,3,4,5,6, 9, 10]) translate([0, mm(61.9) * i]) {
        mirror_copy(VEC_Y) {
            Box(
                x_size = mm(350),
                y_from = mm(8.25),
                y_size = mm(2),
                z_size = mm(2),
                z_from = mm(-12)
            );
        }
    }
}
