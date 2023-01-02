include <../../WalkBridgeConfig.inc>

include <../../../Utils/Box.inc>
include <../../../Utils/TransformIf.inc>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSupport(walk_bridge_config);

module BridgeWallSupport(
    walk_bridge_config,
    is_printable = false,
    mirror_x = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    bridge_clearance                = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_support_position_y       = ConfigGet(walk_bridge_config, "bridge_support_position_y");
    bridge_wall_support_panel_width = ConfigGet(walk_bridge_config, "bridge_wall_support_panel_width");
    bridge_wall                     = ConfigGet(walk_bridge_config, "bridge_wall");
    bridge_size_xz                  = ConfigGet(walk_bridge_config, "bridge_size_xz");
    
    mirror_if(mirror_x, VEC_X) {
        translate([0, bridge_support_position_y]) {
            Box(
                x_from = bridge_size_xz[0] / 2 - bridge_wall,
                x_size = 2 * bridge_wall,
                y_size = bridge_wall_support_panel_width,
                z_from = bridge_clearance,
                z_size = bridge_size_xz[1]
            );
        }
    }
}