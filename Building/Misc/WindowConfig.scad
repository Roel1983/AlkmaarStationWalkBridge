UNITS_NOZZLE = mm(.4);
UNITS_LAYER  = mm(0.15);
SCALED_SCALE = "H0";
include <../../../Utils/Units.inc>
include <../../../Utils/Scaled.inc>
include <../../../Utils/Config.inc>

function WindowConfig(
    size               = scaled(m([1.1, 1.3])),
    radius             = scaled(m(1.45)),
    slat_count_x       = 2,
    slat_positions_y   = [scaled(m(.68))],
    radius_center      = 0,
    slat_size          = [nozzle(1), layer(2)],
    different_top_slat = false
) = Config(undef,
    "WindowConfig",
    [
        ["size",               size],
        ["radius",             radius],
        ["slat_count_x",       slat_count_x],
        ["slat_positions_y",   slat_positions_y],
        ["slat_size",          slat_size],
        ["radius_center",      radius_center],
        ["different_top_slat", different_top_slat]
    ]
);
