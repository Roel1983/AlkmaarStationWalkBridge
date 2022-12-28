include <WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

BridgeBC(walk_bridge_config);

bridge_size              = [40, 35];
bridge_roof_radius       = 40;

module BridgeBC(WalkBridgeConfig) {
    assert(is_config(WalkBridgeConfig, "WalkBridgeConfig"));
    
    distance_platform_b_c = ConfigGet(WalkBridgeConfig, "distance_platform_b_c");
    bridge_height         = ConfigGet(WalkBridgeConfig, "bridge_clearance");
    
    translate([0, 0, bridge_height]) {
        rotate(90) A([bridge_size[0], distance_platform_b_c, bridge_size[1]], bridge_roof_radius);
    }
}

module A(size, roof_r) {
    rotate(90) rotate(90, [1, 0, 0])linear_extrude(size[1], center = true) {
        hull() {
            translate([-size[0] / 2, 0]) {
                square([size[0], size[2]]);
            }
            intersection() {
                h = size[2] - sqrt(pow(roof_r, 2) - pow(size[0]/2, 2));
                translate([
                    0,
                    h
                ]) {
                    circle(r=roof_r);
                }
                translate([-size[0] / 2, 0]) {
                    square([size[0], h + roof_r]);
                }
            }
        }
    }
}
