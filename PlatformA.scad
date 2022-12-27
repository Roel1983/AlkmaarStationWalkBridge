include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

PlatformA(walk_bridge_config);

module PlatformA(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    translate([-hub_center_y,0]) {
        Hub();
        translate([-hub_head_size[1] / 2 - tower_a_base_size[1] / 2,0]) TowerWithCurvedRoof();
        translate([hub_head_size[1] / 2 + tower_b_base_size[1] / 2,0]) TowerWithFlatRoof();
    };
    
    distance_platform_a_b = ConfigGet(WalkBridgeConfig, "distance_platform_a_b");
}

hub_center_y             = 20;
hub_base_size            = [38, 100, 50];
hub_head_size            = [60, 100, 45];
hub_head_center_x        = -8;            
hub_head_roof_radius     = 70;
tower_a_base_size        = [35, 35, 78];
tower_a_head_size        = [40, 40, 50];
tower_a_head_roof_radius = 40;
tower_b_base_size        = [35, 35, 90];
tower_b_head_size        = [40, 40, 40];
tower_b_roof_size        = [50, 50, 5];

module TowerWithCurvedRoof() {
    linear_extrude(tower_a_base_size[2]) {
        square([tower_a_base_size[0], tower_a_base_size[1]], true);
    }
    translate([0,0,tower_a_base_size[2]]) A(tower_a_head_size, tower_a_head_roof_radius);
}

module A(size, roof_r) {
    rotate(90) rotate(90, [1, 0, 0])linear_extrude(size[1], center = true) {
        hull() {
            translate([-size[0] / 2, 0]) {
                square([size[0], size[2]]);
            }
            intersection() {
                h = size[2] - sqrt(pow(roof_r, 2) - pow(size[0]/2, 2));
                translate([
                    0,
                    h
                ]) {
                    circle(r=roof_r);
                }
                translate([-size[0] / 2, 0]) {
                    square([size[0], h + roof_r]);
                }
            }
        }
    }
}

module Hub() {
    linear_extrude(hub_base_size[2]) {
        square([hub_base_size[1], hub_base_size[0]], true);
    }
    translate([0,hub_head_center_x, hub_base_size[2]]) {
        A(hub_head_size, hub_head_roof_radius);
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
