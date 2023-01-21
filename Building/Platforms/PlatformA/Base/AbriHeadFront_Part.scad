include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use <../../../Misc/Window.scad>

walk_bridge_config = WalkBridgeConfig();
AbriHeadFront_Part(
    walk_bridge_config,
    is_printable = false
);

module AbriHeadFront_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    if(is_printable) {
        rotate(90, VEC_X) Part();
    } else {
        Part();
    }
    
    module Part() {
        abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
        abri_head_position_x = ConfigGet(platform_a_config, ["abri_config", "position_x"]);
        abri_head_size       = ConfigGet(platform_a_config, ["abri_config", "head_size"]);
        bridge_size_xz       = ConfigGet(walk_bridge_config, "bridge_size_xz");
        abri_head_bounds_y   = ConfigGet(platform_a_config, ["abri_config", "head_bounds_y"]);
        abri_base_size       = ConfigGet(platform_a_config, ["abri_config", "base_size"]);
        
        window_config = WindowConfig(
            width              = scaled(m(1.4)),
            height             = scaled(m(2.1)),
            radius             = scaled(m(3.8)),
            slat_count_x       = 2,
            slat_positions_y   = scaled(m([.7, 1.35])),
            different_top_slat = true
        );
        
        translate([
            abri_head_position_x,
            abri_head_bounds_y[0],
            abri_base_size[Z]
        ]) {
            rotate(90, VEC_X) {
                difference() {
                    Box(
                        x_from  = abri_head_position_x - (abri_head_size[X] - bridge_size_xz[0])/2,
                        y_to    = abri_head_size[Z],
                        z_to    = abri_wall
                    );
                    AtEachWindowPosition() WindowGap(window_config);
                }
                AtEachWindowPosition() WindowSlats(window_config);
            }
        }
        
        module AtEachWindowPosition() {
            for(xi=[-1:1:1]) translate([scaled(m(-2.4)) + xi * scaled(m(1.55)), scaled(m(1.9))]) {
                children();
            }
        }
    }
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    abri_head_position_x = ConfigGet(platform_a_config, ["abri_config", "position_x"]);
    abri_head_size       = ConfigGet(platform_a_config, ["abri_config", "head_size"]);
    
    *if(!is_printable) {
        abri_head_bounds_y = ConfigGet(platform_a_config, ["abri_config", "head_bounds_y"]);
        abri_base_size     = ConfigGet(platform_a_config, ["abri_config", "base_size"]);
        translate([
            abri_head_position_x - abri_head_size[X]/2,
            abri_head_bounds_y[0] - abri_wall,
            abri_base_size[Z]
        ]) {
            rotate(-90, VEC_X) rotate(180, VEC_Z){
                AbriHeadFront_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        bridge_size_xz = ConfigGet(walk_bridge_config, "bridge_size_xz");
        LinearExtrude(
            z_to   = abri_wall
        ) {
            difference() {
                Box(
                    x_from  = abri_head_position_x - (abri_head_size[X] - bridge_size_xz[0])/2,
                    y_to   = abri_head_size[Z]
                );
                Box(
                    x_from  = abri_head_position_x - (abri_head_size[X] - bridge_size_xz[0])/2 + 2,
                    x_to    = -2,
                    y_from  = abri_head_size[Z] * 1/3,
                    y_to    = abri_head_size[Z] * 2/3
                );
            }
        }
    }
}