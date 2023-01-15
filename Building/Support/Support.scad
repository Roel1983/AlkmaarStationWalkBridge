include <../../WalkBridgeConfig.inc>

include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>

walk_bridge_config = WalkBridgeConfig();
Support(
    walk_bridge_config
);

module Support(
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
        bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");
        bridge_clearance = ConfigGet(walk_bridge_config, "bridge_clearance");
        
        translate([0, bridge_support_position_y]) {
            Box(
                x_size = scaled(m(4.5)),
                y_size = mm(5.5) + nozzle(2),
                z_from = mm(-12),
                z_to   = bridge_clearance
            );
        }
    }
}