include <WalkBridge.inc>
include <../Utils/Constants.inc>
include <../Utils/Box.inc>
include <../Utils/LinearExtrude.inc>
include <../Utils/Scaled.inc>
include <../Utils/TransformCopy.inc>
include <../Utils/TransformIf.inc>
include <../Utils/Units.inc>

$fn = 64;

module Platform(walk_bridge_config, platform_config, mirror_y = false) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    assert(is_config(platform_config,    "PlatformConfig"));
    
    abri_config = ConfigGet(platform_config, "abri_config");
    assert(is_config(abri_config, "AbriConfig"));
    
    tower1_config = ConfigGet(platform_config, "tower1_config");
    assert(is_config(tower1_config, "Tower1Config"));
    
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
    tower1_head_roof_r     = ConfigGet(tower1_config, "head_roof_r");
        
    tower2_position_x      = ConfigGet(tower2_config, "position_x");
    tower2_base_size       = ConfigGet(tower2_config, "base_size");
    tower2_head_size       = ConfigGet(tower2_config, "head_size");
    tower2_roof_size       = ConfigGet(tower2_config, "roof_size");
    
    %render() union() {
        Abri();
        Tower1();
        Tower2();
    }

    module Abri() {
        mirror_if(mirror_y, VEC_Y) {
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