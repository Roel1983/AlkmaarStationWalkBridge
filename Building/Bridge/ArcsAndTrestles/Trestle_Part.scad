include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
Trestle_Part(
    walk_bridge_config,
    is_printable = false
);

module Trestle_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_height            = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    if (is_printable == false) {
        translate([0,0,bridge_height]) {
            rotate(90, VEC_X) Trestle_Part(
                walk_bridge_config = walk_bridge_config,
                is_printable = true
            );
        }
    } else {
        arc_thickness = ConfigGet(walk_bridge_config, "arc_thickness");
        color("#81cdc6") {
            LinearExtrude(z_size = arc_thickness) {
                BridgeTrestle2D(walk_bridge_config);
            }
        }
    }
}

module BridgeTrestle2D(
    walk_bridge_config
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_wall              = ConfigGet(walk_bridge_config, "bridge_wall");
    
    polygon([
        [
            bridge_size_xz[0] / 2 - bridge_wall,
            0
        ], [
            bridge_size_xz[0] / 2 + scaled(m(1.0)),
            scaled(m(0.5) - layer(5))
        ], [
            bridge_size_xz[0] / 2 - bridge_wall,
            scaled(m(0.5) - layer(5))
        ]
        
    ]);
}