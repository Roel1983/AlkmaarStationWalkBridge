include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <Front_Part.scad>
use <AbriBaseFront_Part.scad>
use <AbriHeadFront_Part.scad>
use <AbriFrontLeft_Part.scad>
use <AbriBackLeft_Part.scad>
use <AbriRight_Part.scad>
use <Tower2BaseRight_Part.scad>
use <Tower2BaseFront_Part.scad>
use <Tower2BaseLeft_Part.scad>

use <Back_Part.scad>
use <AbriHeadFront_Part.scad>
use <AbriHeadBack_Part.scad>
use <AbriHeadLeft_Part.scad>
use <AbriHeadRight_Part.scad>
use <AbriRoofPart2_Part.scad>
use <Tower1BaseSide_Part.scad>
use <Tower1HeadFront_Part.scad>
use <Tower1HeadBack_Part.scad>
use <Tower1HeadLeft_Part.scad>
use <Tower1HeadRight_Part.scad>
//use <Tower2BaseSide_Part.scad>

walk_bridge_config = WalkBridgeConfig();
Base(
    walk_bridge_config
);

module Base(
    walk_bridge_config,
    xray     = false,
    colorize = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        AbriRight_Part            (walk_bridge_config);
        AbriBaseFront_Part        (walk_bridge_config);
        AbriHeadFront_Part        (walk_bridge_config);
        AbriFrontLeft_Part        (walk_bridge_config);
        AbriBackLeft_Part         (walk_bridge_config);
        //AbriBack_Part             (walk_bridge_config);
        
        Tower2BaseRight_Part      (walk_bridge_config);
        Tower2BaseFront_Part      (walk_bridge_config);
        Tower2BaseLeft_Part       (walk_bridge_config);
        
        //Front_Part                (walk_bridge_config); // TODO remove
        //Back_Part                 (walk_bridge_config); // TODO remove
        AbriHeadBack_Part         (walk_bridge_config);
        //AbriHeadLeft_Part         (walk_bridge_config);
        //AbriHeadRight_Part        (walk_bridge_config);
        AbriRoofPart2_Part        (walk_bridge_config);
        Tower1BaseSide_Part       (walk_bridge_config);
        Tower1HeadFront_Part      (walk_bridge_config);
        Tower1HeadBack_Part       (walk_bridge_config);
        Tower1HeadLeft_Part       (walk_bridge_config);
        Tower1HeadRight_Part      (walk_bridge_config);
    }
}