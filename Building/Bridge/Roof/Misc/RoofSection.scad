include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/LinearExtrude.inc>
include <../../../../../Utils/TransformCopy.inc>

walk_bridge_config = WalkBridgeConfig();
roof_segment_config     = ConfigGet(walk_bridge_config, "roof_segment1_config");
platform_config         = ConfigGet(walk_bridge_config, "platform_a_config");

$fn = $preview?32:256;

RoofSectionBegin(
    roof_segment_config,
    is_printable = true,
    platform_config = platform_config,
    roof_length = 10
);

module RoofSectionBegin(
    roof_segment_config,
    is_printable,
    platform_config,
    roof_length = undef
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    _roof_length = optional(roof_length, size_y / section_count);
    
    translate([0, pos_y]) {
        RoofSection(
            walk_bridge_config,
            _roof_length, 
            cap1            = "wall",
            cap2            = "seam",
            platform_config = platform_config
        );
    }
}

module RoofSectionCenter(
    roof_segment_config,
    index = 0,
    is_printable,
    roof_length = undef
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    _roof_length = optional(roof_length, size_y / section_count);
    
    translate([0, pos_y + (index + 1) * roof_length]) {
        RoofSection(
            walk_bridge_config,
            _roof_length,
            cap1="none",
            cap2="seam"
        );
    }
}

module RoofSectionEnd(
    roof_segment_config,
    is_printable,
    platform_config,
    roof_length = undef
) {
    assert(is_config(roof_segment_config, "RoofSegmentConfig"));
    pos_y                    = ConfigGet(roof_segment_config, "pos_y");
    size_y                   = ConfigGet(roof_segment_config, "size_y");
    section_count            = ConfigGet(roof_segment_config, "section_count");
    
    _roof_length = optional(roof_length, size_y / section_count);
    
    translate([0, pos_y + size_y]) {
        mirror(VEC_Y) RoofSection(
            walk_bridge_config,
            _roof_length,
            cap1            = "wall",
            cap2            = "none",
            platform_config = platform_config
        );
    }
}

module RoofSection(
    walk_bridge_config,
    length,
    cap1 = "none",
    cap2 = "none",
    platform_config
) {
    echo("Print settings");
    echo("- Layer Height = 0.15mm");
    echo("- Perimeters   = 1");
    echo("- Infill       = 0%");
        
    bridge_size_xz           = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_roof_radius       = ConfigGet(walk_bridge_config, "bridge_roof_radius");
    bridge_height            = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_wall_to_roof      = ConfigGet(walk_bridge_config, "bridge_wall_to_roof");
    bridge_wall_top_height   = ConfigGet(walk_bridge_config, "bridge_wall_top_height");
    bridge_wall_top_rim_size = ConfigGet(walk_bridge_config, "bridge_wall_top_rim_size");
    bridge_wall              = ConfigGet(walk_bridge_config, "bridge_wall");
    gutter_width             = ConfigGet(walk_bridge_config, "gutter_width");
    gutter_height            = scaled(cm(10));
    
    inner_bridge_width = bridge_size_xz[0] - 2 * bridge_wall;
    h = bridge_size_xz[1] - sqrt(pow(bridge_roof_radius, 2) - pow(inner_bridge_width/2, 2));
    
    Gutter();
    RoofSurface();
    Cap(cap1);
    translate([0, length]) mirror(VEC_Y) {
        Cap(cap2);
    }
    
    module Gutter() {
        color("DimGrey") {
            translate([0,0, bridge_height]) LinearExtrude(
                y_to   = length
            ) {
                
                rotate(180) mirror_copy(VEC_X) polygon([
                    [
                        inner_bridge_width / 2,
                        bridge_size_xz[1] - bridge_wall_to_roof
                    ], [
                        inner_bridge_width / 2 + bridge_wall + bridge_wall_top_rim_size[1],
                        bridge_size_xz[1] - bridge_wall_to_roof
                    ], [
                        inner_bridge_width / 2 + bridge_wall + bridge_wall_top_rim_size[1],
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_rim_size[0]
                    ], [
                        inner_bridge_width / 2 + bridge_wall,
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_rim_size[0]
                    ], [
                        inner_bridge_width / 2 + bridge_wall,
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                    ], [
                        inner_bridge_width / 2 + bridge_wall + gutter_width,
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                    ], [
                        inner_bridge_width / 2 + bridge_wall + gutter_width,
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height + gutter_height
                    ], [
                        inner_bridge_width / 2 + bridge_wall + gutter_width - nozzle(1),
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height + gutter_height
                    ], [
                        inner_bridge_width / 2 + bridge_wall + gutter_width - nozzle(1),
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height + nozzle(1)
                    ], [
                        inner_bridge_width / 2 + bridge_wall + bridge_wall_top_rim_size[1] + nozzle(2),
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height + nozzle(1)
                    ], [
                        inner_bridge_width / 2 + bridge_wall + bridge_wall_top_rim_size[1] + nozzle(2),
                        bridge_size_xz[1] - bridge_wall_to_roof + nozzle(2)
                    ], [
                        inner_bridge_width / 2 - nozzle(2),
                        bridge_size_xz[1] - bridge_wall_to_roof + nozzle(2)
                    ], [
                        inner_bridge_width / 2 - nozzle(2),
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                    ], [
                        inner_bridge_width / 2,
                        bridge_size_xz[1] - bridge_wall_to_roof - bridge_wall_top_height
                    ]
                ]);
            }
        }
    }
    roof_surface_thickness = nozzle(2);
    roof_width = inner_bridge_width + 2*(bridge_wall + bridge_wall_top_rim_size[1] + nozzle(2));
    module RoofSurface() {
        color("Silver") {
            translate([0,0, bridge_height]) LinearExtrude(
                y_to   = length
            ) {
                rotate(180) difference() {
                    intersection() {
                        translate([
                            0,
                            h
                        ]) {
                            circle(r=bridge_roof_radius + roof_surface_thickness);
                        }
                        translate([-inner_bridge_width / 2 - (bridge_wall + bridge_wall_top_rim_size[1] + nozzle(2)), 0]) {
                            square([
                                roof_width,
                                h + bridge_roof_radius + nozzle(2)
                            ]);
                        }
                    }
                    translate([
                        0,
                        h
                    ]) {
                        circle(r=bridge_roof_radius);
                    }
                }
            }
        }
    }
    
    module Cap(cap) {
        if(cap == "wall") {
            Wallcap();
        } else if (cap == "seam") {
            SeamCap();
        }
        
        module Wallcap() {
            assert(is_config(platform_config, "PlatformConfig"));
            head_height = ConfigGet(platform_config, ["abri_config", "head_height"]);
            
            /*color("#81cdc6") {
                translate([0,0, bridge_height]) LinearExtrude(
                    y_from = -layer(5)
                ) {
                    mirror(VEC_Y)difference() {
                        Box(
                            x_size = bridge_size_xz[0],
                            y_from = h,
                            y_to   = head_height
                        );
                        translate([
                            0,
                            h
                        ]) {
                            circle(r=bridge_roof_radius);
                        }
                    }
                }
            }*/
        }
        
        module SeamCap() {
            tolerance = mm(0.1);
            color("DarkGray") {
                rotate(90, VEC_X) translate([0, h + bridge_height]) {
                    intersection() {
                        rotate_extrude() {
                            translate([
                                    bridge_roof_radius + roof_surface_thickness, 
                                    0
                            ]) polygon([
                                [tolerance, 0],
                                [-nozzle(1), 0],
                                [nozzle(-1), -mm(1)],
                                [nozzle(.5), -mm(1)],
                                [nozzle(2) + tolerance, -mm(1) + nozzle(1)],
                                [nozzle(2) + tolerance,  mm(1) - nozzle(1)],
                                [tolerance + nozzle(.5), mm(1)],
                                [tolerance, mm(1)],
                            ]);
                        }
                        Box(
                            x_size = roof_width,
                            y_to   = bridge_roof_radius + roof_surface_thickness + nozzle(3),
                            z_size = mm(3)
                        );
                    }
                }
            }
        }
    }   
}