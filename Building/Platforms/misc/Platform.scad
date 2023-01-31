include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Constants.inc>
include <../../../../Utils/Box.inc>
include <../../../../Utils/LinearExtrude.inc>
include <../../../../Utils/Scaled.inc>
include <../../../../Utils/TransformCopy.inc>
include <../../../../Utils/TransformIf.inc>
include <../../../../Utils/Units.inc>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();
platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
Platform(
    walk_bridge_config = walk_bridge_config,
    platform_config    = platform_config
);

module Platform(walk_bridge_config, platform_config, mirror_y = false) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    assert(is_config(platform_config,    "PlatformConfig"));
    
    bridge_clearance = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    abri_config = ConfigGet(platform_config, "abri_config");
    assert(is_config(abri_config, "AbriConfig"));
    
    tower1_config = ConfigGet(platform_config, "tower1_config");
    assert(is_config(tower1_config, "Tower1Config"));
    
    tower2_config = ConfigGet(platform_config, "tower2_config");
    assert(is_config(tower2_config, "Tower2Config"));
    
    front_bounds_x         = ConfigGet(abri_config, "front_bounds_x");
    back_bounds_x          = ConfigGet(abri_config, "back_bounds_x");
    base_left_bounds_y     = ConfigGet(abri_config, "base_left_bounds_y");
    base_right_bounds_y    = ConfigGet(abri_config, "base_right_bounds_y");
    head_front_y           = ConfigGet(abri_config, "head_front_y");
    roof_bound_x           = ConfigGet(abri_config, "roof_bound_x");
    backwall_to_bridge_z   = ConfigGet(abri_config, "backwall_to_bridge_z");
    
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
    tower1_head_roof_r     = ConfigGet(tower1_config, "head_roof_r");
        
    tower2_position_x      = ConfigGet(tower2_config, "position_x");
    tower2_base_size       = ConfigGet(tower2_config, "base_size");
    tower2_head_size       = ConfigGet(tower2_config, "head_size");
    tower2_roof_size       = ConfigGet(tower2_config, "roof_size");
    
    render() union() {
        Abri();
        Tower1();
        Tower2();
    }

    module Abri() {
        module Base() {
            LinearExtrude(
                z_to = bridge_clearance - backwall_to_bridge_z
            ) {
                polygon([
                    [ front_bounds_x[1], base_right_bounds_y[0]],
                    [ front_bounds_x[1], 0],
                    [ back_bounds_x[1], 0],
                    [ back_bounds_x[1],  base_right_bounds_y[1]],
                    [-back_bounds_x[1], base_right_bounds_y[1]],
                    [-back_bounds_x[1], base_left_bounds_y[1]],
                    [ back_bounds_x[0], base_left_bounds_y[1]],
                    [ back_bounds_x[0], base_left_bounds_y[0]]
                ]);
            }
        }
        
        module Head() {
            LinearExtrude(
                z_from = bridge_clearance - backwall_to_bridge_z,
                z_size = abri_head_size[Z] + backwall_to_bridge_z
            ) {
                polygon([
                    [ front_bounds_x[1], head_front_y],
                    [ front_bounds_x[1], 0],
                    [ back_bounds_x[1], 0],
                    [ back_bounds_x[1],  base_left_bounds_y[1]],
                    [ back_bounds_x[0], base_left_bounds_y[1]],
                    [ back_bounds_x[0], head_front_y]
                ]);
            }
        }
        
        module Roof() {
            translate([
                0,
                (base_left_bounds_y[1] + head_front_y) / 2,
                abri_base_size[Z] + abri_head_size[Z]
            ]) {
                LinearExtrude(
                    x_from = roof_bound_x[0],
                    x_to   = roof_bound_x[1]
                ) {
                    A(
                        size   = [abri_head_size[Y], 0],
                        roof_r = abri_head_roof_r
                    );
                }
            }
        }
        
        mirror_if(mirror_y, VEC_Y) {
            Base();
            Head();
            Roof();
            
            
            
            /*translate([abri_position_x, 0]) {
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
                                y_from = -abri_head_overhang_r,
                                y_to   = 0
                            );
                            translate([
                                -abri_head_size[Y] / 2,
                                -abri_head_overhang_r - abri_head_overhang_z
                            ]) {
                                circle(r=abri_head_overhang_r);
                            }
                        }
                    }
                }
            }*/
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