include <../../../../FlatChain/FloorHub.inc>
use <../../../../FlatChain/FloorStraight.scad>
include <../../../../FlatChain/Floor.inc>
include <../../../WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();

FloorCenter(walk_bridge_config);

module FloorCenter(
    walk_bridge_config,
    colorize = true
) {
    link_config     = LinkConfig();
    link_size       = ConfigGet(link_config, "size");
    abri_head_wall  = mm(1);

    distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
    distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c"); 
    b = ConfigGet(walk_bridge_config, ["platform_c_config", "abri_config", "head_bounds_y"])[1];
    from = (
        ConfigGet(walk_bridge_config, ["platform_a_config", "abri_config", "head_bounds_y"])[1]
        + abri_head_wall
    );
    to   = (
        ConfigGet(walk_bridge_config, "distance_platform_a_b")
        + ConfigGet(walk_bridge_config, "distance_platform_b_c")
        - ConfigGet(walk_bridge_config, ["platform_c_config", "abri_config", "head_bounds_y"])[1]
    );
    length              = to - from; 
    straight_link_count = round((length / 3) / link_size);

    hub_length = length - 2 * straight_link_count * link_size;
    
    bridge_size_xz        = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
    bridge_clearance         = ConfigGet(walk_bridge_config, "bridge_clearance");

    groove_config   = GrooveConfig(link_config = link_config);
    floor_config    = FloorConfig(
        groove_config = groove_config,
        hub_length          = hub_length,
        straight_link_count = straight_link_count,
        width = bridge_size_xz[0] - 2 * bridge_wall
    );
    
    floor_thickness = ConfigGet(floor_config, "thickness");

    translate([
        0,
        from + hub_length,
        bridge_clearance + floor_thickness
    ]) {
        rotate(90) FloorStraight(floor_config);;
    }
    
}
