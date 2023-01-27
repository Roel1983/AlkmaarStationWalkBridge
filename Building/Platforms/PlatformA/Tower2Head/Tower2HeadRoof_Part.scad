include <../../../../WalkBridgeConfig.inc>
include <../../../../../Utils/Box.inc>
use     <../../../../../Utils/Chamfered.scad>

walk_bridge_config = WalkBridgeConfig();
Tower2HeadRoof_Part(
    walk_bridge_config,
    is_printable = true
);

module Tower2HeadRoof_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall     = ConfigGet(walk_bridge_config, "abri_wall");
    base_size     = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    head_size     = ConfigGet(platform_config, ["tower2_config", "head_size"]);
    position_x    = ConfigGet(platform_config, ["tower2_config", "position_x"]);
    roof_size     = ConfigGet(platform_config, ["tower2_config", "roof_size"]);
    roof_height   = ConfigGet(platform_config, ["tower2_config", "roof_height"]);
    roof_indent   = (roof_size[X] - head_size[X]) / 6;
    
    if(is_printable) {
        rotate(180, VEC_X)
        translate([
            -position_x,
            0,
            -base_size[Z] - head_size[Z] - roof_size[Z] + roof_indent/2
        ]) {
            Part();
        }
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([
            position_x,
            0,
            base_size[Z] + head_size[Z] + roof_size[Z] - roof_indent
        ]) {
            ChamferedSquare(
                x_size = roof_size[X] - 4 * roof_indent,
                y_size = roof_size[Y] - 4 * roof_indent,
                thickness = roof_indent / 2,
                chamfer_angle = -45
            );
            BIAS = 0.1;
            Box(
                x_size = head_size[X],
                y_size = head_size[Y],
                z_from = -roof_height + roof_indent,
                z_to   = BIAS
            );
            LiftingBeam();
        }
        
        module LiftingBeam() {
            length = scaled(m(1.0));
            BIAS = 0.1;
            hull() {
                Box(
                    y_size = nozzle(4),
                    x_to   = head_size[X] / 2,
                    x_size = nozzle(10),
                    z_to   = -roof_height + roof_indent,
                    z_size = nozzle(3)
                );
                Box(
                    y_size = nozzle(4),
                    x_to   = head_size[X] / 2,
                    x_size = head_size[X] / 4,
                    z_from = -roof_height + roof_indent,
                    z_size = BIAS
                );
            }
            translate([head_size[X]/2, 0]) {
                Box(
                    y_size = nozzle(2),
                    x_from = -BIAS,
                    x_to   = length,
                    z_to   = -roof_height + roof_indent,
                    z_size = nozzle(3)
                );
                Box(
                    y_size = nozzle(3),
                    x_from = -BIAS,
                    x_to   = length,
                    z_to   = -roof_height + roof_indent,
                    z_size = nozzle(1)
                );
                Box(
                    y_size = nozzle(3),
                    x_from = -BIAS,
                    x_to   = length,
                    z_from = -roof_height + roof_indent - nozzle(3),
                    z_size = nozzle(1)
                );
            }
            
        }
    }
}