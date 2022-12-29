include <WalkBridge.inc>
include <../Utils/Config.inc>
include <../Utils/Box.inc>

walk_bridge_config = WalkBridgeConfig();

BridgeSupport(walk_bridge_config);

module BridgeSupport(walk_bridge_config = WalkBridgeConfig()) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");
    bridge_clearance      = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    %Box(
        x_size = scaled(m(4.3)),
        y_size = mm(5.5),
        z_from = mm(-12),
        z_to   = bridge_clearance
    );
}