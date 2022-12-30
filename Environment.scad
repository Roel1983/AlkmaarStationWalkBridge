include <../Utils/Box.inc>
include <../Utils/Config.inc>
include <../Utils/LinearExtrude.inc>
include <../Utils/TransformCopy.inc>
include <../Utils/Units.inc>

include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();
Environment(walk_bridge_config);

module Environment(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_width = mm(79);
    platform_b_width = mm(141);
        
    distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
    bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");

    PlatformA();
    PlatformB();
    PlatformC();
    Rails();

    module PlatformA() {
        Platform(platform_a_width);
    }

    module PlatformB() {
        translate([0, distance_platform_a_b]) {
            Platform(platform_b_width);
        }
    }

    module PlatformC() {
        Box(
            x_size = mm(200),
            y_from = distance_platform_a_b + mm(230),
            y_size = mm(100),
            z_from = mm(-12),
            z_to   = mm(60)
        );
    }

    module Rails() {
        for(i = [1,2,3,4,5,6, 9, 10]) translate([0, mm(61.9) * i ]) {
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

    module Platform(width) {
        LinearExtrude(x_size = mm(350)) {
            Box(
                x_size = width,
                y_from = mm(-1.0)
            );
            Box(
                x_size = width - mm(2.0),
                y_from = mm(-12.0)
            );
        }
    }
}