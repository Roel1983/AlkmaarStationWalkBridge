include <../../../../../WalkBridgeConfig.inc>

include <../../../../../../Utils/Box.inc>
include <../../../../../../Utils/Constants.inc>
include <../../../../../../Utils/LinearExtrude.inc>
use <../../../../../../Utils/Chamfered.scad>

walk_bridge_config = WalkBridgeConfig();
abri_wall          = ConfigGet(walk_bridge_config, "abri_wall");
tower2_config      = ConfigGet(walk_bridge_config, ["platform_a_config", "tower2_config"]);
head_size          = ConfigGet(tower2_config, "head_size");
    
Tower2Wall(
    tower2_config = tower2_config,
    wall_width    = head_size[X],
    wall_height   = head_size[Z],
    abri_wall     = abri_wall
);

module Tower2Wall(
    tower2_config,
    wall_width,
    wall_height,
    abri_wall
) {
    assert(is_config(tower2_config, "Tower2Config"));
    roof_height   = ConfigGet(tower2_config, "roof_height");
    roof_overhang = ConfigGet(tower2_config, "roof_overhang");
    
    roof_width    = wall_width + 2 * roof_overhang;
    roof_indent   = (roof_width - wall_width) / 6;
    
    rotate(90, VEC_X) {
        BIAS = 0.1;
        ChamferedSquare(
            x_size    = wall_width,
            y_to      = wall_height + BIAS,
            thickness = abri_wall,
            chamfer_angle = [0, 45, 0, 45]
        );
        difference() {
            ChamferedSquare(
                x_size    = wall_width,
                y_from    = wall_height,
                y_size    = roof_height,
                thickness = (roof_width - wall_width) / 2,
                chamfer_angle = [0, 45, 0, 45]
            );
            LinearExtrude(x_size = roof_width, convexity= 2) {
                square(10);
                polygon([
                    [
                        wall_height + roof_height +BIAS,
                        -BIAS
                    ], [
                        wall_height + roof_height +BIAS,
                        (roof_width - wall_width) / 2 - layer(3),
                    ], [
                        wall_height + roof_height,
                        (roof_width - wall_width) / 2 - layer(3),
                    ], [
                        wall_height + roof_height - roof_indent,
                        (roof_width - wall_width) / 2 - layer(3) - roof_indent,
                    ], [
                        wall_height + roof_height - roof_indent,
                        -BIAS
                    ]
                ]);
            }
        }
        beam = nozzle([4, 1]);
        for (x = [-2/5, 2/5]) translate([wall_width * x, 0]) {
            Box(
                x_size    = beam[0],
                y_to      = wall_height,
                y_size    = beam[1],
                z_to      = (roof_width - wall_width) / 2
            );
        }
    }
}