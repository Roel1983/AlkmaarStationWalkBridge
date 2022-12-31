include <../WalkBridge.inc>
include <../../Utils/GlueTogether.inc>
include <../../Utils/Constants.inc>
include <../../Utils/Box.inc>
include <../../Utils/LinearExtrude.inc>
include <../../Utils/Scaled.inc>
include <../../Utils/TransformCopy.inc>
include <../../Utils/TransformIf.inc>
include <../../Utils/Units.inc>
include <../WalkBridge.inc>
include <Platform.inc>

walk_bridge_config = WalkBridgeConfig();
PlatformC(
    walk_bridge_config
);

module PlatformC(
    walk_bridge_config,
    colorize = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_c_config");
    assert(is_config(platform_config,    "PlatformConfig"));
    
    abri_config = ConfigGet(platform_config, "abri_config");
    assert(is_config(abri_config, "AbriConfig"));
    
    tower1_config = ConfigGet(platform_config, "tower1_config");
    assert(is_config(tower1_config, "Tower2Config"));
    
    tower2_config = ConfigGet(platform_config, "tower2_config");
    assert(is_config(tower2_config, "Tower2Config"));
    
    abri_base_size         = ConfigGet(abri_config, "base_size");
    abri_position_x        = ConfigGet(abri_config, "position_x");
    abri_support_width     = ConfigGet(abri_config, "support_width");
    abri_support_height    = ConfigGet(abri_config, "support_height");
    abri_support_beam_size = ConfigGet(abri_config, "support_beam_size");
    abri_support_wall      = ConfigGet(abri_config, "support_wall");
    
    abri_head_size         = ConfigGet(abri_config, "head_size");
    abri_head_roof_r       = ConfigGet(abri_config, "head_roof_r");
    abri_head_position_y   = ConfigGet(abri_config, "head_position_y");
    abri_head_overhang_z   = ConfigGet(abri_config, "head_overhang_z");
    abri_head_overhang_r   = ConfigGet(abri_config, "head_overhang_r");
    
    tower1_position_x      = ConfigGet(tower1_config, "position_x");
    tower1_base_size       = ConfigGet(tower1_config, "base_size");
    tower1_head_size       = ConfigGet(tower1_config, "head_size");
    tower1_roof_size       = ConfigGet(tower1_config, "roof_size");
        
    tower2_position_x      = ConfigGet(tower2_config, "position_x");
    tower2_base_size       = ConfigGet(tower2_config, "base_size");
    tower2_head_size       = ConfigGet(tower2_config, "head_size");
    tower2_roof_size       = ConfigGet(tower2_config, "roof_size");
    
    distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
    
    translate([0, distance_platform_a_b + distance_platform_b_c]) {
        render() union() {
            Abri();
            Tower1();
            Tower2();
        }
    }

    module Abri() {
        mirror(VEC_Y) {
            translate([abri_position_x, 0]) {
                Box(
                    x_size = abri_base_size[X],
                    y_size = abri_base_size[Y],
                    z_to   = abri_base_size[Z]
                );
                translate([(abri_base_size[X] - abri_support_width) / 2, abri_base_size[Y] / 2]) {
                    mirror_copy(VEC_X) {
                        Box(
                        x_to = abri_support_width / 2,
                        x_size = abri_support_beam_size[X],
                        y_from = 0,
                        y_size  = abri_support_beam_size[Y],
                        z_to   = abri_support_height
                    );
                    }
                    Box(
                        x_size = abri_support_width,
                        y_from = 0,
                        y_size = abri_support_wall,
                        z_to   = abri_support_height
                    );
                }
                translate([0, abri_head_position_y, abri_base_size[Z]]) {
                    Box(
                        x_size = abri_head_size[X],
                        y_size = abri_head_size[Y],
                        z_to   = abri_head_size[Z]
                    );
                    Box(
                        x_size = abri_head_size[X],
                        y_size = abri_head_size[Y] + 2 * mm(4),
                        z_to   = abri_head_size[Z],
                        z_size = mm(3)
                    );
                    translate([30, -25, 0]) {
                            linear_extrude(100) {
                                square(13, true);
                            }
                        }
                }
                
                
            }
        }   
    }
    
    module Tower1 () {
        translate([tower1_position_x,   0]) {
            Box(
                x_size = tower1_base_size[X],
                y_size = tower1_base_size[Y],
                z_to   = tower1_base_size[Z]
            );
            translate([0,0, tower1_base_size[Z]]) {
                Box(
                    x_size = tower1_head_size[X],
                    y_size = tower1_head_size[Y],
                    z_to   = tower1_head_size[Z]
                );
                Box(
                    x_size = tower1_roof_size[X],
                    y_size = tower1_roof_size[Y],
                    z_to   = tower1_head_size[Z],
                    z_size = tower1_roof_size[Z]
                );
            }
        }
    }
    
    module Tower2() {
        translate([tower2_position_x, 0]) {
            Box(
                x_size = tower2_base_size[X],
                y_size = tower2_base_size[Y],
                z_to   = tower2_base_size[Z]
            );
            translate([0,0, tower2_base_size[Z]]) {
                Box(
                    x_size = tower2_head_size[X],
                    y_size = tower2_head_size[Y],
                    z_to   = tower2_head_size[Z]
                );
                Box(
                    x_size = tower2_roof_size[X],
                    y_size = tower2_roof_size[Y],
                    z_to   = tower2_head_size[Z],
                    z_size = tower2_roof_size[Z]
                );
            }
        }
    }
}

module A(size, roof_r) {
    hull() {
        translate([-size[X] / 2, 0]) {
            square([size[X], size[Y]]);
        }
        intersection() {
            h = size[Y] - sqrt(pow(roof_r, 2) - pow(size[X]/2, 2));
            translate([
                0,
                h
            ]) {
                circle(r=roof_r);
            }
            translate([-size[X] / 2, 0]) {
                square([size[X], h + roof_r]);
            }
        }
    }
}

//walk_bridge_config = WalkBridgeConfig();
//PlatformC(
//    walk_bridge_config
//);
//
//
//   hub_center_y             = 20;
//        hub_base_size            = [38, 100, 50];
//        hub_head_size            = [60, 100, 45];
//        hub_head_center_x        = -8;            
//        hub_head_roof_radius     = 70;
//
//        tower_a_base_size        = [35, 35, 90];
//
//        tower_b_base_size        = [35, 35, 90];
//        tower_b_head_size        = [40, 40, 40];
//        tower_b_roof_size        = [50, 50, 5];
//module Platform5C(
//    walk_bridge_config,
//    xray     = false,
//    colorize = true
//) {
//    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
//    
//    color(alpha = .2) Ghost();
//    GlueTogether(
//        xray     = xray,
//        colorize = colorize
//    ) {
//        
//    }
//    
//    module Ghost() {
//        
//        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
//    
//        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
//        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
//        
//        translate([0, distance_platform_a_b + distance_platform_b_c]) {
//            rotate(-90) {
//                translate([0, -hub_center_y]) {
//                    translate([0, -hub_head_size[1] / 2 - tower_a_base_size[1] / 2]) TowerWithFlatRoof(103);
//                    translate([0,  hub_head_size[1] / 2 + tower_b_base_size[1] / 2]) TowerWithFlatRoof(103);
//                    
//                    h1 = 45;
//                    linear_extrude(h1) {
//                        square([hub_base_size[0], hub_base_size[1]], true);
//                    }
//                    translate([-5, 0, h1]) {
//                        h2 = 50;
//                        linear_extrude(h2) {
//                            square([50, hub_base_size[1]], true);
//                        }
//                        translate([0, 0, h2]) {
//                            linear_extrude(5) {
//                                square([58, hub_base_size[1] + 8], true);
//                            }
//                        }
//                        translate([-30, 25, 0]) {
//                            linear_extrude(100) {
//                                square(13, true);
//                            }
//                        }
//                    }
//                    
//                }
//            }
//        }
//    }
//}
//
//module TowerWithFlatRoof(tower_base_size_z = tower_b_base_size[2]) {
//    linear_extrude(tower_base_size_z) {
//        square([tower_b_base_size[0], tower_b_base_size[1]], true);
//    }
//    translate([0,0,tower_base_size_z]) {
//        linear_extrude(tower_b_head_size[2]) {
//            square([tower_b_head_size[0], tower_b_head_size[1]], true);
//        }   
//        translate([0,0,tower_b_head_size[2]]) {
//            linear_extrude(tower_b_roof_size[2]) {
//                square([tower_b_roof_size[0], tower_b_roof_size[1]], true);
//            }   
//        }
//    }
//}