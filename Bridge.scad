include <WalkBridge.inc>
include <../Utils/Box.inc>
include <../FlatChain/FloorHub.inc>
include <../FlatChain/Floor.inc>
use <../FlatChain/FloorStraight.scad>

walk_bridge_config = WalkBridgeConfig();
Bridge(walk_bridge_config);

bridge_wall_support_width = mm(5.5);
bridge_wall_panel_width   = mm(15);

bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");
distance_platform_a_b     = ConfigGet(walk_bridge_config, "distance_platform_a_b");
len_a_to_support = (
    bridge_support_position_y
    - bridge_wall_support_width / 2
    - ConfigGet(walk_bridge_config, [
        "platform_a_config",
        "abri_config",
        "head_outer_wall_position_y"
      ])[0]
);
len_support_to_b = (
    distance_platform_a_b
    - bridge_support_position_y
    - bridge_wall_support_width / 2
    - ConfigGet(walk_bridge_config, [
        "platform_b_config",
        "abri_config",
        "head_outer_wall_position_y"
      ])[0]
);
panel_count_a_to_support = floor(len_a_to_support / bridge_wall_panel_width);
panel_count_support_to_b = floor(len_support_to_b / bridge_wall_panel_width);

echo("A", len_support_to_b);

module Bridge(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    
    GhostBridge(walk_bridge_config);
    
    bridge_clearance          = ConfigGet(walk_bridge_config, "bridge_clearance");
    distance_platform_a_b     = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    bridge_support_position_y = ConfigGet(walk_bridge_config, "bridge_support_position_y");
    
    translate([0,0, bridge_clearance]) {
        translate([0, bridge_support_position_y - bridge_wall_support_width / 2]) {
            BridgeWallAToSupport(walk_bridge_config);
        }
        translate([0, bridge_support_position_y + bridge_wall_support_width / 2]) {
            BridgeWallSupportToB(walk_bridge_config);
        }
        translate([0, bridge_support_position_y])
        BridgeWallSupport(walk_bridge_config);
    }
    
    
    translate([0, -25, 63.57]) {
        rotate(90) FloorHub(FloorConfig(
            hub_length = 230
        ));
        translate([0,230]) rotate(90) FloorStraight(FloorConfig(
            straight_link_count = 32
        ));
        translate([0,716])  rotate(-90) FloorHub(FloorConfig(
            hub_length = 230
        ));
    }
}

module BridgeWallSupport(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    color("red", alpha = 0.25)Box(
        x_size = scaled(m(4.5)),
        y_size = bridge_wall_support_width,
        z_to   = scaled(m(3.0))
    );
}
module BridgeWallAToSupport(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    color("green", alpha = 0.25) Box(
        x_size = scaled(m(4.5)),
        y_from = -len_a_to_support,
        z_to   = scaled(m(3.0))
    );
}
module BridgeWallSupportToB(walk_bridge_config) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    color("green", alpha = 0.25) Box(
        x_size = scaled(m(4.5)),
        y_to   = len_support_to_b,
        z_to   = scaled(m(3.0))
    );
}


module GhostBridge(walk_bridge_config = WalkBridgeConfig()) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    bridge_size              = scaled(m([4.5, 3.0]));
    bridge_roof_radius       = 40;
    
    distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
    bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    bridge_length = distance_platform_a_b + distance_platform_b_c;
   
    %translate([0, bridge_length/2, bridge_height]) {
        rotate(90) A([bridge_size[0], bridge_length, bridge_size[1]], bridge_roof_radius);
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
