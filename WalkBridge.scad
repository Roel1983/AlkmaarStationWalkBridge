use <Environment.scad>
use <Building/Building.scad>

$fn = 64;

walk_bridge_config = WalkBridgeConfig();

WalkBridge(walk_bridge_config);

module WalkBridge(walk_bridge_config) {
    Environment(walk_bridge_config);
    Building(walk_bridge_config);
}
