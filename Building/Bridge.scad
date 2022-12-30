include <../../Utils/GlueTogether.inc>
include <../WalkBridge.inc>
include <Bridge/Floor.inc>
include <Bridge/Wall.inc>
include <Bridge/Roof.inc>
include <Bridge/Arcs.inc>
include <Bridge/SideWalk.inc>
include <Bridge/LedStrip.inc>

walk_bridge_config = WalkBridgeConfig();
Bridge(
    walk_bridge_config,
    xray = false
);

module Bridge(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        Floor   (walk_bridge_config, colorize = false);
        Wall    (walk_bridge_config, colorize = false);
        Roof    (walk_bridge_config, colorize = false);
        Arcs    (walk_bridge_config, colorize = false);
        SideWalk(walk_bridge_config, colorize = false);
        LedStrip(walk_bridge_config, colorize = false);
    }
}

module A(size, roof_r) {
    rotate(90) rotate(90, [1, 0, 0])linear_extrude(size[1], center = true) {
        hull() {
            translate([-size[0] / 2, 0]) {
                square([size[0], size[2]]);
            }
            intersection() {
                h = size[2] - sqrt(pow(roof_r, 2) - pow(size[0]/2, 2));
                translate([
                    0,
                    h
                ]) {
                    circle(r=roof_r);
                }
                translate([-size[0] / 2, 0]) {
                    square([size[0], h + roof_r]);
                }
            }
        }
    }
}
