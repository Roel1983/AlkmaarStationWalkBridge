include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/Box.inc>
include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/LinearExtrude.inc>

use <BridgeRoofAbBegin_Part.scad>
use <BridgeRoofAbCenter_Part.scad>
use <BridgeRoofAbEnd_Part.scad>
use <BridgeRoofBcBegin_Part.scad>
use <BridgeRoofBcEnd_Part.scad>

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
    
    section_count = ConfigGet(walk_bridge_config, ["roof_segment1_config", "section_count"]);
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BridgeRoofAbBegin_Part(walk_bridge_config);
        if(section_count >= 3) for (index = [0 : section_count - 3]) {
            BridgeRoofAbCenter_Part(walk_bridge_config, index = index);
        }
        BridgeRoofAbEnd_Part(walk_bridge_config);
        BridgeRoofBcBegin_Part(walk_bridge_config);
        BridgeRoofBcEnd_Part(walk_bridge_config);
    }
    
    module Ghost() {
        assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
        bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
        bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
        
        distance_platform_a_b = ConfigGet(walk_bridge_config, "distance_platform_a_b");
        distance_platform_b_c = ConfigGet(walk_bridge_config, "distance_platform_b_c");
        bridge_height         = ConfigGet(walk_bridge_config, "bridge_clearance");
        
        bridge_length = distance_platform_a_b + distance_platform_b_c;
       
        translate([0,0, bridge_height]) LinearExtrude(
            y_from = 0,
            y_to   = distance_platform_a_b + distance_platform_b_c
        ) {
            rotate(180) difference() {
                h = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0]/2, 2));
                intersection() {
                    
                    translate([
                        0,
                        h
                    ]) {
                        circle(r=bridge_roof_radius);
                    }
                    translate([-bridge_size_xz[0] / 2, 0]) {
                        square([bridge_size_xz[0], h + bridge_roof_radius]);
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