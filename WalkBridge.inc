SCALED_SCALE = "H0";
include <../Utils/Scaled.inc>
include <../Utils/Config.inc>
include <../Utils/Constants.inc>
include <../Utils/Units.inc>
use<WalkBridge.scad>

function AbriConfig(
    base_size         = scaled(m([9.25, 3.05, 5.2])),
    position_x        = scaled(m(-2.075)),
    support_width     = scaled(m(5.1)),
    support_height    = scaled(m(4.9)),
    support_beam_size = scaled(m([.6, 0.32])),
    support_wall      = scaled(m(.25)),
    head_size         = scaled(m([9.75, 4.1, 4.2])),
    head_roof_r       = scaled(m(3.9)),
    head_position_y   = scaled(m(-0.475)),
    head_overhang_z   = scaled(m(0.3)),
    head_overhang_r   = scaled(m(3.0)),
) = Config(undef,
    "AbriConfig",
    let(
        head_outer_wall_position_y = [
            head_position_y + head_size[Y] / 2,
            head_position_y - head_size[Y] / 2
        ]
    )[
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
        /* Derived */
        ["head_outer_wall_position_y", head_outer_wall_position_y]
    ]
);

function Tower1Config(
    position_x      = scaled(m(-8.32)),
    base_size       = scaled(m([2.74, 2.46, 7.8])),
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
    base_size       = scaled(m([2.74, 2.46, 9.6])), // ???
    head_size       = scaled(m([3.68, 3.4, 3.3])),
    roof_size       = scaled(m([4.28, 4.0, 0.35]))
) = Config (undef,
    "Tower2Config",
    [
        ["position_x", position_x],
        ["base_size",  base_size],
        ["head_size",  head_size],
        ["roof_size",  roof_size]
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

function WalkBridgeConfig(
    distance_platform_a_b     = mm(464.25), // ??? Assumption based on H0 space distance
    distance_platform_b_c     = mm(215.7),  // ??? Assumption based on H0 space distance
    bridge_support_position_y = mm(217),    // ???
    bridge_clearance          = scaled(m(5.2)),
    platform_a_config         = PlatformConfig(
        abri_config = AbriConfig(
            head_overhang_z   = scaled(m(1.3))
        )
    ),
    platform_b_config      = PlatformConfig(),
) = Config(undef,
    "WalkBridgeConfig",
    [
        ["distance_platform_a_b", distance_platform_a_b],
        ["distance_platform_b_c", distance_platform_b_c],
        ["bridge_support_position_y", bridge_support_position_y],
        ["bridge_clearance",      bridge_clearance],
        ["platform_a_config",     platform_a_config],
        ["platform_b_config",     platform_b_config]
    ]
);
