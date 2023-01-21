include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/LinearExtrude.inc>
include <../../../../Utils/TransformCopy.inc>
include <../../../../Utils/Units.inc>

use <Trestle_Part.scad>

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
    arc_thickness      = nozzle(2.5);
    bridge_roof_radius = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    bridge_size_xz     = ConfigGet(walk_bridge_config, "bridge_size_xz");
    arc_to_roof        = scaled(m(0.35));
    inner_arc_height   = scaled(m(1.7));
    arc_bar_intersect_point = scaled(m([0.3, 1.6]));
    arc_bar_angles     = degree([15.3, 38.3, 52.5]);
    
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
            - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0] / 2, 2))
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
                Contour();
                offset(-arc_thickness) Contour();
            }
        }           
        
        module Contour() {
            difference() {
                Outer();
                Inner();
            }
            
            module Outer() {
                // TODO: cut out gap for LED strip
                intersection() {
                    Box(
                        x_size = bridge_size_xz[0],
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
            }
            
            module Inner() {
                inner_arc_width = bridge_size_xz[0] - 2 * arc_thickness;
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