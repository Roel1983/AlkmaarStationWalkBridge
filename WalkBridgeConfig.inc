SCALED_SCALE = "H0";
UNITS_LAYER  = mm(0.1);
include <../Utils/Scaled.inc>
include <../Utils/Config.inc>
include <../Utils/Constants.inc>
include <../Utils/Units.inc>
include <../FlatChain/Floor.inc>
include <Building/Misc/WindowConfig.inc>

_abri_wall = layer(10);

function AbriConfig(
    front_bounds_x       = [scaled(m(-6.890)) + _abri_wall, scaled(m(2.400)) - _abri_wall],
    back_bounds_x        = [scaled(m(-6.890)) + _abri_wall, scaled(m(2.550)) - _abri_wall],
    base_left_bounds_y   = [scaled(m(-1.525)) + _abri_wall, scaled(m(1.855)) - _abri_wall],
    base_right_bounds_y  = [scaled(m(-1.525)) + _abri_wall, scaled(m(1.525)) - _abri_wall],
    head_front_y         =  scaled(m(-2.475)) + _abri_wall,
    head_height          = scaled(m(4.1)),
    roof_bound_x         = scaled(m([-7.200, 2.710])),
    backwall_to_bridge_z = scaled(m(0.3)),
    base_size         = scaled(m([9.29, 3.05, 5.2])), // TODO remove
    position_x        = scaled(m(-2.075)),            // TODO remove
    support_width     = scaled(m(5.1)),
    support_height    = scaled(m(4.9)),
    support_beam_size = scaled(m([.6, 0.32])),
    support_wall      = scaled(m(.25)),
    head_size         = scaled(m([9.75, 4.1, 4.2])), // TODO remove
    head_roof_r       = scaled(m(3.9)),
    head_position_y   = scaled(m(-0.475)),
    head_overhang_z   = scaled(m(0.3)),
    head_overhang_r   = scaled(m(3.0)),
    roof_seam_position = mm(30)
) = Config(undef,
    "AbriConfig",
    let(
        head_bounds_y = [
            head_position_y + head_size[Y] / 2,
            head_position_y - head_size[Y] / 2
        ]
    )[
        ["front_bounds_x",      front_bounds_x],
        ["back_bounds_x",       back_bounds_x],
        ["base_left_bounds_y",  base_left_bounds_y],
        ["base_right_bounds_y", base_right_bounds_y],
        ["head_front_y",        head_front_y],
        ["head_height",         head_height],
        ["roof_bound_x",        roof_bound_x],
        ["backwall_to_bridge_z", backwall_to_bridge_z],
    
        ["base_size",         base_size],
        ["position_x",        position_x],
        ["support_width",     support_width],
        ["support_height",    support_height],
        ["support_beam_size", support_beam_size],
        ["support_wall",      support_wall],
        ["head_size",         head_size],
        ["head_roof_r",       head_roof_r],
        ["head_position_y",   head_position_y],
        ["head_overhang_z",   head_overhang_z],
        ["head_overhang_r",   head_overhang_r],
        ["roof_seam_position", roof_seam_position],
        /* Derived */
        ["head_bounds_y",     head_bounds_y]
    ]
);

function Tower1Config(
    position_x      = scaled(m(-8.32)),
    base_size       = scaled(m([2.54, 2.26, 7.8])),
    head_size       = scaled(m([3.24, 2.96, 3.6])),
    head_roof_r     = scaled(m(5.5)) // ?
) = Config(undef,
    "Tower1Config",
    [
        ["position_x",  position_x],
        ["base_size",   base_size],
        ["head_size",   head_size],
        ["head_roof_r", head_roof_r]
    ]
);

function Tower2Config(
    position_x      = scaled(m(4.17)), // ???
    base_size       = scaled(m([2.54, 2.26, 9.6])), // ???
    head_size       = scaled(m([3.68, 3.4, 3.3])),
    roof_overhang   = scaled(m(0.3)),
    roof_height     = scaled(m(0.35))
) = Config (undef,
    "Tower2Config",
    let(
        roof_size  = [
            head_size[X] + 2 * roof_overhang,
            head_size[Y] + 2 * roof_overhang,
            roof_height
        ]
    )[
        ["position_x",    position_x],
        ["base_size",     base_size],
        ["head_size",     head_size],
        ["roof_overhang", roof_overhang],
        ["roof_height",   roof_height],
        /* Derived */
        ["roof_size",     roof_size]
    ]
);

function PlatformConfig(
    abri_config   = AbriConfig(),
    tower1_config = Tower1Config(),
    tower2_config = Tower2Config()
) = Config(undef,
    "PlatformConfig",
    [
        ["abri_config",   abri_config],
        ["tower1_config", tower1_config],
        ["tower2_config", tower2_config]
    ]
);

function WallSegmentConfig(
    pos_y,
    size_y,
    offset_begin = 0,
    offset_end = 0,
    window_panel_count
) = Config(undef,
    "WallSegmentConfig",
    let(
        window_panel_width = ((size_y-offset_begin-offset_end)/window_panel_count)
    )[
        ["pos_y",              pos_y],
        ["size_y",             size_y],
        ["offset_begin",       offset_begin],
        ["offset_end",         offset_end],
        ["window_panel_count", window_panel_count],
        /* Derived */
        ["window_panel_width", window_panel_width]
    ]
);

function RoofSegmentConfig(
    pos_y,
    size_y,
    section_count
) = Config(undef,
    "RoofSegmentConfig",
    [
        ["pos_y",              pos_y],
        ["size_y",             size_y],
        ["section_count",      section_count],
    ]
);

function WalkBridgeConfig(
    platform_height           = mm(12),
    distance_platform_a_b     = mm(461), // ??? Assumption based on H0 space distance
    distance_platform_b_c     = mm(212.5),  // ??? Assumption based on H0 space distance
    bridge_support_position_y = mm(214.5),    // ???
    bridge_clearance          = scaled(m(5.1)),
    platform_a_config         = PlatformConfig(
        abri_config = AbriConfig(
            head_overhang_z   = scaled(m(1.3))
        )
    ),
    platform_b_config         = PlatformConfig(),
    platform_c_config         = PlatformConfig(
        tower1_config = Tower2Config(
            base_size       = scaled(m([2.74, 2.46, 10.0])), // ???
            position_x = scaled(m(-8.32))
        ),
        tower2_config = Tower2Config(
            base_size       = scaled(m([2.74, 2.46, 10.0])) // ???
        )
    ),
    bridge_size_xz            = scaled(m([4.5, 3.0])), // ???
    bridge_roof_radius        = scaled(m(3.85)),
    bridge_wall               = layer(4),
    bridge_wall_support_panel_width  = scaled(m(0.5)), // ???
    wall_segmment_offset_y    = scaled(m(.3)), // ???
    abri_wall                 = _abri_wall,
    bridge_wall_to_roof       = mm(1),
    bridge_wall_top_height    = nozzle(3.1),
    bridge_wall_top_rim_size  = [nozzle(1), layer(1)],
    bridge_window_config      = WindowConfig(
        width            = scaled(m(1.1)), // Will be overruled
        height           = scaled(m(1.3)), // Will be overruled
        radius           = scaled(m(1.45)),
        slat_count_x     = 2,
        slat_positions_y = [scaled(m(.68))]
    ),
    window_clearance_yz       = nozzle([.5, 1]),
    bridge_window_position_z  = scaled(m(1.60)),
    gutter_width              = scaled(cm(25)),
    arc_thickness             = nozzle(2.5)
) = Config(undef,
    "WalkBridgeConfig",
    let(
        wall_segment1_config = WallSegmentConfig(
            pos_y  = ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"])[1],
            size_y = (
                bridge_support_position_y
                - bridge_wall_support_panel_width / 2
                - ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"])[1]
            ),
            offset_begin       = wall_segmment_offset_y,
            window_panel_count = 14
        ),
        wall_segment2_config = WallSegmentConfig(
            pos_y  = bridge_support_position_y + bridge_wall_support_panel_width / 2,
            size_y = (
                distance_platform_a_b
                - ConfigGet(platform_b_config, ["abri_config", "head_bounds_y"])[0]
                - bridge_support_position_y
                - bridge_wall_support_panel_width / 2
            ),
            offset_end         = wall_segmment_offset_y,
            window_panel_count = 16
        ), wall_segment3_config = WallSegmentConfig(
            pos_y  = (
                distance_platform_a_b
                - ConfigGet(platform_b_config, ["abri_config", "head_bounds_y"])[1]
            ), size_y = (
                distance_platform_b_c
                + ConfigGet(platform_b_config, ["abri_config", "head_bounds_y"])[1]
                - ConfigGet(platform_c_config, ["abri_config", "head_bounds_y"])[0]
            ),
            offset_begin       = wall_segmment_offset_y,
            offset_end         = wall_segmment_offset_y,
            window_panel_count = 10
        ), roof_segment1_config = RoofSegmentConfig(
            pos_y  = ConfigGet(platform_b_config, ["abri_config", "base_right_bounds_y"])[1],
            size_y = (
                distance_platform_a_b
                - ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"])[1]
                - ConfigGet(platform_b_config, ["abri_config", "base_right_bounds_y"])[1]
            ),
            section_count = 4
        ), roof_segment2_config = RoofSegmentConfig(
            pos_y  = (
                distance_platform_a_b
                - ConfigGet(platform_c_config, ["abri_config", "head_bounds_y"])[1]
            ), size_y = (
                distance_platform_b_c
                + ConfigGet(platform_b_config, ["abri_config", "head_bounds_y"])[1]
                - ConfigGet(platform_c_config, ["abri_config", "head_bounds_y"])[0]
            ),
            section_count = 2
        ), link_config     = (
            LinkConfig()
        ), link_size = (
            ConfigGet(link_config, "size")
        ), bridge_floor_from = (
            ConfigGet(platform_a_config, ["abri_config", "head_front_y"])
            + abri_wall
        ), bridge_floor_to = (
            distance_platform_a_b
            + distance_platform_b_c
            - ConfigGet(platform_c_config, ["abri_config", "head_bounds_y"])[1]
            - abri_wall
        ), bridge_floor_length = (
            bridge_floor_to - bridge_floor_from
        ), bridge_floor_straight_link_count = (
            round((bridge_floor_length / 3) / link_size)
        ), bridge_floor_hub_length = (
            (bridge_floor_length
             - bridge_floor_straight_link_count * link_size) / 2
        ), bridge_chain_floor_config    = FloorConfig(
            groove_config       = GrooveConfig(link_config = link_config),
            hub_length          = bridge_floor_hub_length,
            straight_link_count = bridge_floor_straight_link_count,
            width               = bridge_size_xz[0] - 2 * bridge_wall,
            slot_width          = mm(3.0),
            slot_edge_distance  = mm(4.0)
        ) 
    ) [
        ["platform_height",           platform_height],
        ["distance_platform_a_b",     distance_platform_a_b],
        ["distance_platform_b_c",     distance_platform_b_c],
        ["bridge_support_position_y", bridge_support_position_y],
        ["bridge_clearance",          bridge_clearance],
        ["platform_a_config",         platform_a_config],
        ["platform_b_config",         platform_b_config],
        ["platform_c_config",         platform_c_config],
        ["bridge_size_xz",            bridge_size_xz],
        ["bridge_roof_radius",        bridge_roof_radius],
        ["bridge_wall",               bridge_wall],
        ["bridge_wall_support_panel_width",  bridge_wall_support_panel_width],
        ["abri_wall",                 abri_wall],
        ["bridge_wall_to_roof",       bridge_wall_to_roof],
        ["bridge_wall_top_height",    bridge_wall_top_height],
        ["bridge_wall_top_rim_size",  bridge_wall_top_rim_size],
        ["bridge_window_config",      bridge_window_config],
        ["window_clearance_yz",       window_clearance_yz],
        ["bridge_window_position_z",  bridge_window_position_z],
        ["gutter_width",              gutter_width],
        ["arc_thickness",             arc_thickness],
        /* Derived */
        ["wall_segment1_config",      wall_segment1_config],
        ["wall_segment2_config",      wall_segment2_config],
        ["wall_segment3_config",      wall_segment3_config],
        ["roof_segment1_config",      roof_segment1_config],
        ["roof_segment2_config",      roof_segment2_config],
        ["bridge_floor_from",         bridge_floor_from],
        ["bridge_floor_to",           bridge_floor_to],
        ["bridge_floor_length",       bridge_floor_length],
        ["bridge_chain_floor_config", bridge_chain_floor_config]
    ]
);