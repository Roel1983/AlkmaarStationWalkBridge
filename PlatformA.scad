include <WalkBridge.inc>
include <../Utils/Constants.inc>
include <../Utils/Box.inc>
include <../Utils/LinearExtrude.inc>
include <../Utils/Scaled.inc>
include <../Utils/TransformCopy.inc>
include <../Utils/Units.inc>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

PlatformA(walk_bridge_config);

module PlatformA(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    abri_base_size         = scaled(m([9.25, 3.05, 5.2]));
    abri_position_x        = scaled(m(-2.075));
    abri_support_width     = scaled(m(5.1));
    abri_support_height    = scaled(m(4.9));
    abri_support_beam_size = scaled(m([.6, 0.32]));
    abri_support_wall      = scaled(m(.25));
    
    abri_head_size         = scaled(m([9.75, 4.1, 4.2]));
    abri_head_roof_r       = scaled(m(3.9));
    abri_head_position_y   = scaled(m(-0.475));
    abri_head_overhang_z   = scaled(m(1.3));
    abri_head_overhand_r   = scaled(m(3.0)); // ???
    
    tower1_position_x      = scaled(m(-8.32));
    tower1_base_size       = scaled(m([2.74, 2.46, 7.8]));
    tower1_head_size       = scaled(m([3.24, 2.96, 3.6]));
    tower1_head_roof_r     = scaled(m(5.5)); // ?
        
    tower2_position_x      = scaled(m(4.17)); // ???
    tower2_base_size       = scaled(m([2.74, 2.46, 9.6])); // ???
    tower2_head_size       = scaled(m([3.68, 3.4, 3.3]));
    tower2_roof_size       = scaled(m([4.28, 4.0, 0.35]));
    
    Abri();
    Tower1();
    Tower2();

    module Abri() {
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
                LinearExtrude(
                    x_size = abri_head_size[X]
                ) {
                    A(
                        size   = [abri_head_size[Y], abri_head_size[Z]],
                        roof_r = abri_head_roof_r
                    );
                    difference() {
                        Box(
                            x_from = -abri_head_size[Y]/ 2,
                            x_to   = 0,
                            y_from = -abri_head_overhand_r,
                            y_to   = 0
                        );
                        translate([
                            -abri_head_size[Y] / 2,
                            -abri_head_overhand_r - abri_head_overhang_z
                        ]) {
                            circle(r=abri_head_overhand_r);
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
                LinearExtrude(
                    x_size = tower1_head_size[X]
                ) A(
                    size   = [tower1_head_size[Y], tower1_head_size[Z]],
                    roof_r = tower1_head_roof_r
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