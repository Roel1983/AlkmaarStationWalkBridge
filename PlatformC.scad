include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

PlatformC(walk_bridge_config);

    hub_center_y             = 20;
hub_base_size            = [38, 100, 50];
hub_head_size            = [60, 100, 45];
hub_head_center_x        = -8;            
hub_head_roof_radius     = 70;

tower_a_base_size        = [35, 35, 90];

tower_b_base_size        = [35, 35, 90];
tower_b_head_size        = [40, 40, 40];
tower_b_roof_size        = [50, 50, 5];

module PlatformC(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
    
    rotate(-90) {
        translate([0, -hub_center_y]) {
            translate([0, -hub_head_size[1] / 2 - tower_a_base_size[1] / 2]) TowerWithFlatRoof(103);
            translate([0,  hub_head_size[1] / 2 + tower_b_base_size[1] / 2]) TowerWithFlatRoof(103);
            
            h1 = 45;
            linear_extrude(h1) {
                square([hub_base_size[0], hub_base_size[1]], true);
            }
            translate([-5, 0, h1]) {
                h2 = 50;
                linear_extrude(h2) {
                    square([50, hub_base_size[1]], true);
                }
                translate([0, 0, h2]) {
                    linear_extrude(5) {
                        square([58, hub_base_size[1] + 8], true);
                    }
                }
                translate([-30, 25, 0]) {
                    linear_extrude(100) {
                        square(13, true);
                    }
                }
            }
            
        }
    }
}
module TowerWithFlatRoof(tower_base_size_z = tower_b_base_size[2]) {
    linear_extrude(tower_base_size_z) {
        square([tower_b_base_size[0], tower_b_base_size[1]], true);
    }
    translate([0,0,tower_base_size_z]) {
        linear_extrude(tower_b_head_size[2]) {
            square([tower_b_head_size[0], tower_b_head_size[1]], true);
        }   
        translate([0,0,tower_b_head_size[2]]) {
            linear_extrude(tower_b_roof_size[2]) {
                square([tower_b_roof_size[0], tower_b_roof_size[1]], true);
            }   
        }
    }
}