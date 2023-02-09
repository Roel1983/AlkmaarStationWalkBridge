include <../../../../../WalkBridgeConfig.inc>

include <../../../../../../Utils/Box.inc>
include <../../../../../../Utils/LinearExtrude.inc>
use     <../../../../../../Utils/Chamfered.scad>

walk_bridge_config = WalkBridgeConfig();
platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
tower2_base_size     = ConfigGet(platform_a_config, ["tower2_config", "base_size"]);
Tower2Panels(
    walk_bridge_config = walk_bridge_config,
    width  = tower2_base_size[0],
    height = tower2_base_size[2],
    left_bevel = 45,
    right_bevel = 0,
    beams       = "horizontals"
);

module Tower2Panels(
    walk_bridge_config,
    width,
    height,
    left_bevel,
    right_bevel,
    beams
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    tower2_base_size     = ConfigGet(platform_a_config, ["tower2_config", "base_size"]);
    tower2_position_x    = ConfigGet(platform_a_config, ["tower2_config", "position_x"]);
    
    panel_count = 4;
    diagonal_beam = [layer(2), nozzle(6)];
    diagonal_diff = layer(2);
    step     = layer(4);
    chamfer_angle = [0, left_bevel, 0, right_bevel];

    for(i=[0:panel_count - 1]) {
        ChamferedSquare(
            thickness = (i + 1) * step,
            x_from    = -width / 2 - (1 - tan(right_bevel)) * (i + 1) * step,
            x_to      = width / 2 + (1 - tan(left_bevel)) * (i + 1) * step,
            y_from    = height / 4 * i,
            y_to      = height,
            chamfer_angle = chamfer_angle,
            align     = "inner"
        );
        if(beams == "crosses") {
            LinearExtrude(
                z_from = (i + 1) * step,
                z_to   = (i + 1) * step + diagonal_beam[0]
            ) {
                Diagonal(i);
            }
            LinearExtrude(
                z_from = (i + 1) * step,
                z_to   = (i + 1) * step + diagonal_beam[0] + diagonal_diff
            ) {
                mirror(VEC_X) Diagonal(i);
            }
        } else if(beams == "horizontals") {
            relative_positions = [
                [],
                [],
                [0.47, 0.53, 0.75],
                [0.25, 0.47, 0.52]
            ];
            for(relative_pos = relative_positions[i]) {
                translate([
                    0,
                    height / 4 * (i + relative_pos)
                ])
                Box(
                    x_size = width + 2 * (i + 1) * step,
                    y_size = nozzle(2),
                    z_from = (i + 1) * step,
                    z_size = nozzle(1)
                );
            }
        }
    }
    hor_beam = [layer(6), nozzle(3)];
    for(i=[1:panel_count - 1]) {
        ChamferedSquare(
            thickness = (i + 1) * step + hor_beam[0],
            x_from    = -width / 2 - (1 - tan(right_bevel)) * (i + 1) * step,
            x_to      = +width / 2 + (1 - tan(left_bevel)) * (i + 1) * step,
            y_from    = height / 4 * i - hor_beam[1] / 2,
            y_to      = height / 4 * i + hor_beam[1] / 2,
            chamfer_angle = chamfer_angle,
            align     = "inner"
        );
    }
    
    module Diagonal(i) {
        polygon([
            [
                -width / 2 - (i + 1) * step,
                height / 4 * i
            ], [
                -width / 2 - (i + 1) * step + diagonal_beam[1],
                height / 4 * i
            ], [
                width / 2 + (i + 1) * step,
                height / 4 * (i + 1)
            ], [
                width / 2 + (i + 1) * step - diagonal_beam[1],,
                height / 4 * (i + 1)
            ]
        ]);
    } 
}
