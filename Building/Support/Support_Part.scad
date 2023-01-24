include <../../WalkBridgeConfig.inc>
include <../../../Utils/LinearExtrude.inc>
include <../../../Utils/Constants.inc>
include <../../../Utils/Points.inc>
include <../../../Utils/Shapes.inc>
include <../../../Utils/TransformCopy.inc>

$fn = 32;

walk_bridge_config = WalkBridgeConfig();
SupportPart(
    walk_bridge_config,
    is_printable = true
);

module SupportPart(
    walk_bridge_config,
    is_printable
) {
    bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");
    
    if(is_printable) {
        rotate(-90, VEC_X) translate([0, -bridge_support_position_y]) Part();
    } else {
        color("DimGray") Part();
    }
    
    module Part() {
        platform_height   = ConfigGet(walk_bridge_config, "platform_height"); 
        bridge_clearance  = ConfigGet(walk_bridge_config, "bridge_clearance"); 
        bridge_size_xz    = ConfigGet(walk_bridge_config, "bridge_size_xz"); 
        
        support_vertical_beam_thickness   = scaled(m(0.6));
        support_horizontal_beam_thickness = scaled(m(0.6));
        
        support_foot_width              = scaled(m(1.2));
        support_foot_height             = scaled(m(0.3));
        
        
        support_rest_z                  = scaled(m(0.2));
        support_outer_slope_pos_z       = scaled(m(0.6));
        support_outer_slope             = scaled([m(0.2), m(0.4)]);
        support_inner_slope             = scaled([m(0.3), m(0.3)]);
        
        hex_wall_z                      = nozzle(4);
        hex_nut_size                    = mm([5.47, 2.28]);
        hex_nut_tolerance               = mm(.1);
        screw_shaft_diameter            = mm(3.1);
        
        support_thickness               = hex_nut_size[0] + hex_nut_tolerance + nozzle(4);
        
        support_foot_slope = (support_foot_width - support_vertical_beam_thickness) / 2;
        
        translate([0, bridge_support_position_y]) {
            difference() {
                BasicShape();
                translate([0, 0, bridge_clearance - hex_wall_z]) {
                    mirror(VEC_Z) HexNutInsert();
                }
                
                translate([0, 0, bridge_clearance - support_horizontal_beam_thickness + hex_wall_z]) {
                    cylinder(
                        d = screw_shaft_diameter,
                        h = support_horizontal_beam_thickness
                    );
                }
                
                mirror_copy(VEC_X) {
                    translate([
                        (bridge_size_xz[0] - support_vertical_beam_thickness)/2,
                        0,
                        -platform_height + hex_wall_z
                    ]) {
                        HexNutInsert(-90);
                        cylinder(
                            d = screw_shaft_diameter,
                            h = mm(20),
                            center = true
                        );
                    }
                }
            }
        }
        
        module HexNutInsert(angle = 0) {
            BIAS = .1;
            
            LinearExtrude(
                z_to = hex_nut_size[1]
            ) hull() {
                rotate(30) Hex(hex_nut_size[0]);
                rotate(angle) {
                    translate([0, -2*hex_nut_size[0]]) rotate(30 - angle) Hex(hex_nut_size[0]);
                }
            }
            LinearExtrude(
                z_to = hex_nut_size[1]
            ) hull() rotate(30) Hex(hex_nut_size[0] + hex_nut_tolerance);
        }
        
        module BasicShape() {
            LinearExtrude(y_size = support_thickness, convexity=3) rotate(180) {
                polygon(points_mirror_copy(VEC_X, [
                    [
                        bridge_size_xz[X] / 2 - support_vertical_beam_thickness - support_inner_slope[0],
                        bridge_clearance - support_horizontal_beam_thickness
                    ], [
                        bridge_size_xz[X] / 2 - support_vertical_beam_thickness,
                        bridge_clearance - support_horizontal_beam_thickness - support_inner_slope[1]
                    ], [ // Foot
                        bridge_size_xz[X] / 2 - support_vertical_beam_thickness,
                        -platform_height + support_foot_height + support_foot_slope
                    ], [
                        bridge_size_xz[X] / 2 - support_vertical_beam_thickness - support_foot_slope,
                        -platform_height + support_foot_height
                    ], [
                        bridge_size_xz[X] / 2 - support_vertical_beam_thickness - support_foot_slope,
                        -platform_height
                    ], [
                        bridge_size_xz[X] / 2 + support_foot_slope,
                        -platform_height
                    ], [
                        bridge_size_xz[X] / 2 + support_foot_slope,
                        -platform_height + support_foot_height
                    ], [
                        bridge_size_xz[X] / 2,
                        -platform_height + support_foot_height + support_foot_slope,
                    ], [ // Vertical beam outer 
                        bridge_size_xz[X] / 2,
                        bridge_clearance - support_outer_slope_pos_z - support_outer_slope[1]
                    ], [
                        bridge_size_xz[X] / 2 + support_outer_slope[0],
                        bridge_clearance - support_outer_slope_pos_z
                    ], [
                        bridge_size_xz[X] / 2 + support_outer_slope[0],
                        bridge_clearance - support_rest_z
                    ], [
                        bridge_size_xz[X] / 2,
                        bridge_clearance - support_rest_z
                    ], [
                        bridge_size_xz[X] / 2,
                        bridge_clearance
                    ]
                ]));
            }
        }
    }
}
