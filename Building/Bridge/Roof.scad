include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>
include <../../../Utils/LinearExtrude.inc>

include <../../WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();
Roof(
    walk_bridge_config
);

module Roof(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    color(alpha = .2)  Ghost();
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
    }
    
    module Ghost() {
        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
        bridge_size              = scaled(m([4.5, 3.0]));
        bridge_roof_radius       = 40;
        
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
        bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
        
        bridge_length = distance_platform_a_b + distance_platform_b_c;
       
        translate([0,0, bridge_height]) LinearExtrude(
            y_from = 0,
            y_to   = distance_platform_a_b + distance_platform_b_c
        ) {
            rotate(180) difference() {
                h = bridge_size[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size[0]/2, 2));
                intersection() {
                    
                    translate([
                        0,
                        h
                    ]) {
                        circle(r=bridge_roof_radius);
                    }
                    translate([-bridge_size[0] / 2, 0]) {
                        square([bridge_size[0], h + bridge_roof_radius]);
                    }
                }
                translate([
                        0,
                        h
                    ]) {
                        circle(r=bridge_roof_radius - mm(1.5));
                    }
            }
        }
    }
}