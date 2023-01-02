include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/LinearExtrude.inc>
include <../../../../../Utils/TransformCopy.inc>

use <BridgeTrestle.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeArc(
    walk_bridge_config,
    is_printable = true
);

module BridgeArc(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_height            = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    if (is_printable == false) {
        translate([0,0,bridge_height]) {
            rotate(90, VEC_X) BridgeArc(
                walk_bridge_config = walk_bridge_config,
                is_printable = true
            );
        }
    } else {
        LinearExtrude(z_size = layer(5)) {
            BridgeArc2D(walk_bridge_config);
        }
    }
}

module BridgeArc2D(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    bridge_wall              = ConfigGet(walk_bridge_config, "bridge_wall");
        
    h = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0]/2, 2));
    
    SingleArc();
    scale([1, .8]) SingleArc();
    mirror_copy(VEC_X) Box(
        x_to   = bridge_size_xz[0] / 2 - bridge_wall,
        x_size = nozzle(3),
        y_to   = bridge_size_xz[1]
    );
    
    mirror_copy(VEC_X) BridgeTrestle2D(walk_bridge_config);
    
    module SingleArc() {
        BIAS = 0.1;
        intersection() {
            translate([
                0,
                h
            ]) {
                difference() {
                    circle(r=bridge_roof_radius);
                    circle(r=bridge_roof_radius - nozzle(3));
                }
            }
            Box(
                x_size = bridge_size_xz[0] - 2 * bridge_wall,
                y_to   = h + bridge_roof_radius
            );
        }
    }
}
