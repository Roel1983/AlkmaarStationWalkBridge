include <../../../../Utils/Units.inc>
include <../../../../Utils/TransformCopy.inc>
include <../../../../Utils/Constants.inc>
include <../../../../Utils/LinearExtrude.inc>
include <../../../../Utils/Box.inc>
include <../../../WalkBridgeConfig.inc>
use <../Wall/Wall.scad>

walk_bridge_config = WalkBridgeConfig();
LedStripSegment(
    walk_bridge_config
);

led_strip_bottom          = layer(5);
led_strip_keep_out_height = mm(2.1);
led_strip_width           = mm(9.5);
led_strip_wall            = nozzle(2.5);
led_strip_clearance       = mm(.1);
led_strip_indent          = nozzle(.5);

module LedStripSegment(
    walk_bridge_config,
    index = 0
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    led_strip_thickness       = mm(0.5);
    led_strip_keep_out_width  = mm(7.5);
    led_strip_tangent         = 2;

    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    
    distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
    bridge_clearance      = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    total_length = distance_platform_a_b + distance_platform_b_c;
    
    led_strip_length = total_length / 4;
    
    h1 = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0]/2, 2));
    h  = h1 + sqrt(pow(bridge_roof_radius, 2) - pow(led_strip_width/2, 2));
    
    led_strip_width2  = led_strip_width + 2 * (led_strip_clearance + led_strip_wall);
    led_strip_height = led_strip_bottom + led_strip_keep_out_height;
    
    color("DimGrey") translate([0, 0, bridge_clearance + h]) {
        translate([0, index * led_strip_length, 0]) {
            difference() {
                ExtrudedPart();
                WallSegmentWindowsSides(walk_bridge_config, "even") {
                    ArcGap();
                }
            }
        }
    }
    
    module ArcGap() {
        arc_thickness = ConfigGet(walk_bridge_config, "arc_thickness");
        BIAS = 0.1;
        mirror_copy(VEC_X) {
            Box(
                x_from = led_strip_width2 / 2 - led_strip_indent,
                x_size = led_strip_indent * 1.1,
                y_size = arc_thickness,
                z_from = -led_strip_height - BIAS,
                z_to   = BIAS
            );
        }
    }
    
    module ExtrudedPart() {
        LinearExtrude(y_to = led_strip_length, convexity=2) {
            rotate(180) mirror_copy(VEC_X) polygon([
                [
                    0,
                    0
                ], [
                    led_strip_width2 / 2,
                    0
                ], [
                    led_strip_width2 / 2,
                    -led_strip_height
                ], [
                    led_strip_keep_out_width / 2,
                    -led_strip_height
                ], [
                    led_strip_keep_out_width / 2,
                    (
                        - led_strip_bottom - led_strip_thickness 
                        - (led_strip_width / 2 + led_strip_clearance - led_strip_keep_out_width / 2) / led_strip_tangent
                    )
                ], [
                    led_strip_width / 2 + led_strip_clearance,
                    -led_strip_bottom - led_strip_thickness
                ], [
                    led_strip_width / 2 + led_strip_clearance,
                    -led_strip_bottom
                ], [
                    0,
                    -led_strip_bottom
                ]
            ]);
        }
    }
}

module LedStripArcCutOut_2D(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    
    h1 = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0]/2, 2));
    h  = h1 + sqrt(pow(bridge_roof_radius, 2) - pow(led_strip_width/2, 2));
    
    led_strip_height = led_strip_bottom + led_strip_keep_out_height;
    
    intersection() {
        Box(
            x_size = led_strip_width + 2 * (led_strip_clearance + led_strip_wall - led_strip_indent),
            y_to   = h + 1,
            y_size = led_strip_height + 1
        );
        translate([0,0,h1]) circle(r=bridge_roof_radius);
    }
}
