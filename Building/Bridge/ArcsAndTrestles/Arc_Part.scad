include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/LinearExtrude.inc>
include <../../../../Utils/TransformCopy.inc>
include <../../../../Utils/Units.inc>

use <Trestle_Part.scad>
use <../LedStrip/LedStripSegment.scad>

walk_bridge_config = WalkBridgeConfig();
Arc_Part(
    walk_bridge_config = walk_bridge_config,
    is_printable = true
);

module Oval(r) {
    r_max = max(r[X], r[Y]);
    scale([r[X]/r_max, r[Y]/r_max]) circle(d=r_max);
}

module Arc_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    bridge_clearance   = ConfigGet(walk_bridge_config, "bridge_clearance");
    arc_thickness      = ConfigGet(walk_bridge_config, "arc_thickness");
    bridge_roof_radius = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    bridge_size_xz     = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_wall        = ConfigGet(walk_bridge_config, "bridge_wall");
    arc_to_roof        = scaled(m(0.35));
    inner_arc_height   = scaled(m(1.7));
    arc_bar_intersect_point = scaled(m([0.3, 1.6]));
    arc_bar_angles     = degree([15.3, 38.3, 52.5]);
    inner_bridge_width = bridge_size_xz[0] - 2 * bridge_wall;
    
    if(is_printable) {
        $fn = $preview ? 64 : 128;
        Part();
    } else {
        $fn = 32;
        color("#81cdc6") {
            translate([0, 0, bridge_clearance]) rotate(90, VEC_X) Part();
        }
    }
    module Part() {
        BIAS = .01;
        roof_radius_center_y = (
            bridge_size_xz[1]
            - sqrt(pow(bridge_roof_radius, 2) - pow(inner_bridge_width / 2, 2))
        );
        roof_height = (
            roof_radius_center_y
            + bridge_roof_radius
        );
        inner_arc_radius_center_y = (
            roof_height
            - arc_to_roof
            - inner_arc_height
        );
        
        LinearExtrude(
            z_size = arc_thickness
        ) {
            ContourBar();
            Bars();
            mirror_copy(VEC_X) {
                BridgeTrestle2D(walk_bridge_config);
            }
        }
        
        module Bars() {
            intersection() {
                Contour();
                union() {
                    Bar();
                    mirror_copy(VEC_X) translate(
                        arc_bar_intersect_point
                    ) {
                        for(a = arc_bar_angles) rotate(-a) Bar();
                    }
                }
            }
            module Bar() {
                Box(
                    x_size = arc_thickness,
                    y_to   = roof_height
                );
            }
        }
        
        module ContourBar() {
            difference() {
                Contour(with_gutter_support = true);
                offset(-arc_thickness) Contour();
            }
        }           
        
        module Contour(with_gutter_support) {
            difference() {
                Outer(with_gutter_support);
                Inner();
            }
            
            module Outer(with_gutter_support) {
                difference() {
                    intersection() {
                        Box(
                            x_size = inner_bridge_width,
                            y_to   = roof_height
                        );
                        translate([
                            0,
                            roof_radius_center_y
                        ]) {
                            circle(
                                r = bridge_roof_radius
                            );
                        }
                    }
                    LedStripArcCutOut_2D(walk_bridge_config);
                }
                if (with_gutter_support) {
                    mirror_copy(VEC_X) GutterSupport();
                }
                
                module GutterSupport() {
                    bridge_wall_top_height = ConfigGet(walk_bridge_config, "bridge_wall_top_height");
                    bridge_wall_to_roof    = ConfigGet(walk_bridge_config, "bridge_wall_to_roof");
                    bridge_wall            = ConfigGet(walk_bridge_config, "bridge_wall");
                    gutter_width           = ConfigGet(walk_bridge_config, "gutter_width");
                    
                    BIAS = 0.1;
                    polygon([
                        [
                            inner_bridge_width / 2 - BIAS,
                            bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                        ], [
                            inner_bridge_width / 2 + bridge_wall + gutter_width,
                            bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                        ], [
                            inner_bridge_width / 2 + bridge_wall + gutter_width,
                            bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height - nozzle(1)
                        ], [
                            inner_bridge_width / 2 + bridge_wall,
                            bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height - gutter_width
                        ], [
                            inner_bridge_width / 2 - BIAS,
                            bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height - gutter_width
                        ]
                    ]);
                }
            }
            
            module Inner() {
                inner_arc_width = inner_bridge_width - 2 * arc_thickness;
                Box(
                    x_size = inner_arc_width,
                    y_from = -BIAS,
                    y_to   = inner_arc_radius_center_y
                );
                translate([
                    0,
                    inner_arc_radius_center_y
                ]) {
                    Oval([inner_arc_width, 2 * inner_arc_height]);
                }
            }
        }
    }
}