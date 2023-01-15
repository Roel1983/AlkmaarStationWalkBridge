use <Environment.scad>
use <Building/Building.scad>

$fn = 64;

IS_IMAGE = 0;
$vpt = (IS_IMAGE == 1)?[ -60.09, 329.70, 31.84 ]:undef;
$vpr = (IS_IMAGE == 1)?[ 77.70, 0.00, 50.40 ]:undef;
$vpf = (IS_IMAGE == 1)?22.50:undef;
$vpd = (IS_IMAGE == 1)?1151.54:undef;

walk_bridge_config = WalkBridgeConfig();

WalkBridge(walk_bridge_config);

module WalkBridge(walk_bridge_config) {
    Environment(walk_bridge_config);
    Building(walk_bridge_config);
}
