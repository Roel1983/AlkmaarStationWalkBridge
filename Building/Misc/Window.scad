SCALED_SCALE = "H0";
UNITS_NOZZLE = mm(.4);
UNITS_LAYER  = mm(0.15);
include <../../../Utils/LinearExtrude.inc>
include <../../../Utils/Box.inc>
include <../../../Utils/Constants.inc>
include <../../../Utils/Config.inc>
include <WindowConfig.inc>

$fn = 128;

translate([-15, 0]) {
    bridge_window_config = WindowConfig(
        width            = scaled(m(1.1)),
        height           = scaled(m(1.3)),
        radius           = scaled(m(1.45)),
        slat_count_x     = 2,
        slat_positions_y = [scaled(m(.68))]
    );
    Window(
        bridge_window_config
    );
}

translate([15, 0]) {
    abri_window_config = WindowConfig(
        width              = scaled(m(1.4)),
        height             = scaled(m(2.1)),
        radius             = scaled(m(3.8)),
        slat_count_x       = 2,
        slat_positions_y   = scaled(m([.7, 1.35])),
        different_top_slat = true
    );
    Window(
        abri_window_config
    );
}

module Window(
    window_config,
    border = mm(2),
    thickness = mm(1)
) {
    assert(is_config(window_config, "WindowConfig"));
    width            = ConfigGet(window_config, "width");
    height           = ConfigGet(window_config, "height");
    radius           = ConfigGet(window_config, "radius");
    slat_size        = ConfigGet(window_config, "slat_size");
    slat_count_x     = ConfigGet(window_config, "slat_count_x");
    slat_positions_y = ConfigGet(window_config, "slat_positions_y");
    
    difference() {
        Box(
            x_size = width + 2 * border,
            y_from = -border,
            y_to   = height + border,
            z_to   = thickness
        );
        WindowGap(
            window_config,
            thickness = thickness,
            extra     = 0.1
        );
    }
    WindowSlats(window_config);
}
    
module WindowSlats(
    window_config,
    extra =  0.1
) {
    assert(is_config(window_config, "WindowConfig"));
    width            = ConfigGet(window_config, "width");
    height           = ConfigGet(window_config, "height");
    radius             = ConfigGet(window_config, "radius");
    slat_size          = ConfigGet(window_config, "slat_size");
    slat_count_x       = ConfigGet(window_config, "slat_count_x");
    slat_positions_y   = ConfigGet(window_config, "slat_positions_y");
    different_top_slat = ConfigGet(window_config, "different_top_slat");
    
    period_x = (
        width + slat_size[X]
    ) / (slat_count_x + 1);
    for (i=[-(slat_count_x - 1) / 2 : (slat_count_x - 1) / 2]) {
        translate([
            i * period_x,
            0
        ]) {
            Box(
                x_size = slat_size[X],
                y_from = -extra,
                y_to   = extra + height,
                z_to   = slat_size[Y]
            );
        }
    }
    for (i = [0 : len(slat_positions_y) - 1]) {
        y = slat_positions_y[i];
        translate([
            0,
            y
        ]) {
            if (different_top_slat && i == len(slat_positions_y) - 1 ) {
                Box(
                    x_from = -width / 2 - extra,
                    x_to   = width /2 + extra,
                    y_size = 2 * slat_size[X],
                    z_to   = slat_size[Y]
                );
                Box(
                    x_from = -width / 2 - extra,
                    x_to   = width /2 + extra,
                    y_to   = slat_size[X],
                    z_to   = 2 * slat_size[Y]
                );
            } else {
                Box(
                    x_from = -width / 2 - extra,
                    x_to   = width /2 + extra,
                    y_size = slat_size[X],
                    z_to   = slat_size[Y]
                );
            }
        }
    }
}

module WindowGap(
    window_config,
    thickness = 1.0,
    extra     = 0.1
) {
    assert(is_config(window_config, "WindowConfig"));
    width              = ConfigGet(window_config, "width");
    height             = ConfigGet(window_config, "height");
    radius             = ConfigGet(window_config, "radius");
    slat_size          = ConfigGet(window_config, "slat_size");
    slat_count_x       = ConfigGet(window_config, "slat_count_x");
    slat_positions_y   = ConfigGet(window_config, "slat_positions_y");
    radius_center      = ConfigGet(window_config, "radius_center");
    
    LinearExtrude(z_from = -extra, z_to = thickness + extra) {
        intersection() {
            Box(
                x_size = width,
                y_to   = height
            );
            translate([
                radius_center,
                height - radius
            ]) {
                circle(r = radius);
            }
        }
    }
}
