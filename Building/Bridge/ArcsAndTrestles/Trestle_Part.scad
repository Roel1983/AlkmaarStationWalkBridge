include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
Trestle_Part(
    walk_bridge_config,
    is_printable = true
);

module Trestle_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_height = ConfigGet(walk_bridge_config, "bridge_clearance");
    arc_thickness      = ConfigGet(walk_bridge_config, "arc_thickness");
    bridge_size_xz     = ConfigGet(walk_bridge_config, "bridge_size_xz");
    
    if(is_printable) {
        rotate(-90, VEC_X) {
            translate([-bridge_size_xz[0] / 2, 0, -bridge_height]) Part();
        }
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([0,0,bridge_height]) {
            rotate(90, VEC_X) {
                LinearExtrude(z_size = arc_thickness) {
                    BridgeTrestle2D(walk_bridge_config);
                }
            }
        }
    }
}

module BridgeTrestle2D(
    walk_bridge_config,
    cutout = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_size_xz            = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_wall               = ConfigGet(walk_bridge_config, "bridge_wall");
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    floor_thickness           = ConfigGet(bridge_chain_floor_config, "thickness");
    
    inner_bridge_width = bridge_size_xz[0] - 2 * bridge_wall;
    
    height = scaled(m(0.5));
    triangle_size             = (scaled(m(0.5)) - floor_thickness);
    
    polygon([
        [
            inner_bridge_width / 2 + bridge_wall,
            0
        ], [
            inner_bridge_width / 2 + scaled(m(1.0)),
            cutout?0:height - nozzle(1)
        ], [
            inner_bridge_width / 2 + scaled(m(1.0)),
            height
        ], [
            inner_bridge_width / 2,
            height
        ], [
            inner_bridge_width / 2 - triangle_size,
            floor_thickness
        ], [
            inner_bridge_width / 2 - triangle_size,
            4/5 * floor_thickness 
        ], [
            inner_bridge_width / 2 - (triangle_size - bridge_wall) / 2 - bridge_wall,
            4/5 * floor_thickness
        ], [
            inner_bridge_width / 2 - (triangle_size - bridge_wall) / 2 - bridge_wall,
            0
        ]
    ]);
}

module Trestle_Part_cutout(walk_bridge_config, tolerance = mm(0.1)) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    bridge_height = ConfigGet(walk_bridge_config, "bridge_clearance");
    arc_thickness = ConfigGet(walk_bridge_config, "arc_thickness");
   
    translate([0,0,bridge_height]) rotate(90, VEC_X) {
        LinearExtrude(z_size = arc_thickness + 2 * tolerance) {
            Trestle_Part_cutout2D(walk_bridge_config, tolerance);
        }
    }
}

module Trestle_Part_cutout2D(walk_bridge_config, tolerance) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    offset(delta=tolerance) BridgeTrestle2D(walk_bridge_config, cutout=true);
}
