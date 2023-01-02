include <../../WalkBridgeConfig.inc>

include <../../../Utils/Box.inc>
include <../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
platform_config         = ConfigGet(walk_bridge_config, "platform_a_config");
BridgeRoofSectionBegin(
    roof_segment_config,
    is_printable = true,
    platform_config = platform_config
);

module BridgeRoofSectionBegin(
    roof_segment_config,
    is_printable,
    platform_config
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    roof_length = size_y / section_count;
    
    translate([0, pos_y]) {
        BridgeRoofSection(
            walk_bridge_config,
            roof_length, 
            cap1            = "wall",
            cap2            = "seam",
            platform_config = platform_config);
    }
}

module BridgeRoofSectionCenter(
    roof_segment_config,
    index = 0,
    is_printable
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    roof_length = size_y / section_count;
    
    translate([0, pos_y + (index + 1) * roof_length]) {
        BridgeRoofSection(walk_bridge_config, roof_length, cap1="none", cap2="seam");
    }
}

module BridgeRoofSectionEnd(
    roof_segment_config,
    is_printable,
    platform_config
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    roof_length = size_y / section_count;
    
    translate([0, pos_y + size_y]) {
        mirror(VEC_Y) BridgeRoofSection(
            walk_bridge_config,
            roof_length,
            cap1            = "wall",
            cap2            = "none",
            platform_config = platform_config
        );
    }
}

module BridgeRoofSection(
    walk_bridge_config,
    length,
    cap1 = "none",
    cap2 = "none",
    platform_config
) {
    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    bridge_height            = ConfigGet(walk_bridge_config, "bridge_clearance");
    
    h = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(bridge_size_xz[0]/2, 2));
    translate([0,0, bridge_height]) LinearExtrude(
        y_to   = length
    ) {
        rotate(180) difference() {
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
    
    Cap(cap1);
    translate([0, length]) mirror(VEC_Y) {
        Cap(cap2);
    }
    
    module Cap(cap) {
        if(cap == "wall") {
            Wallcap();
        } else if (cap == "seam") {
            SeamCap();
        }
        
        module Wallcap() {
            assert(is_config(platform_config, "PlatformConfig"));
            abri_head_size = ConfigGet(platform_config, ["abri_config", "head_size"]);
            
            translate([0,0, bridge_height]) LinearExtrude(
                y_from = -layer(5)
            ) {
                mirror(VEC_Y)difference() {
                    Box(
                        x_size = bridge_size_xz[0],
                        y_from = h,
                        y_to   = abri_head_size[Z]
                    );
                    translate([
                        0,
                        h
                    ]) {
                        circle(r=bridge_roof_radius - mm(1.5));
                    }
                }
            }
        }
        
        module SeamCap() {
            translate([0,0, bridge_height]) LinearExtrude(
                y_size   = mm(2)
            ) {
                rotate(180) difference() {
                    intersection() {
                        translate([
                            0,
                            h
                        ]) {
                            circle(r=bridge_roof_radius + nozzle(1));
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
}