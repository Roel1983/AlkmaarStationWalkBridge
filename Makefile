PART_SOURCE_EXTENSION =_Part.scad

PARTS   = Building/Bridge/ArcsAndTrestles/BridgeArc
PARTS  += Building/Bridge/ArcsAndTrestles/BridgeTrestle
PARTS  += Building/Bridge/Roof/BridgeRoofAbBegin
PARTS  += Building/Bridge/Roof/BridgeRoofAbCenter
PARTS  += Building/Bridge/Roof/BridgeRoofAbEnd
PARTS  += Building/Bridge/Roof/BridgeRoofBcBegin
PARTS  += Building/Bridge/Roof/BridgeRoofBcEnd
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment1Left
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment1Right
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment2Left
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment2Right
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment3Left
PARTS  += Building/Bridge/SideWalk/BridgeSideWalkSegment3Right
PARTS  += Building/Bridge/Wall/BridgeWallSegment1Left
PARTS  += Building/Bridge/Wall/BridgeWallSegment1Right
PARTS  += Building/Bridge/Wall/BridgeWallSegment2Left
PARTS  += Building/Bridge/Wall/BridgeWallSegment2Right
PARTS  += Building/Bridge/Wall/BridgeWallSegment3Left
PARTS  += Building/Bridge/Wall/BridgeWallSegment3Right
PARTS  += Building/Bridge/Wall/BridgeWallSupportLeft
PARTS  += Building/Bridge/Wall/BridgeWallSupportRight
PARTS  += Building/Platforms/PlatformA/PlatformAAbriRoof/BuildingAAbriRoofPart1
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAAbriHeadBack
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAAbriHeadFront
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAAbriHeadLeft
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAAbriHeadRight
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAAbriRoofPart2
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingABack
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingAFront
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower1BaseSide
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower1HeadBack
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower1HeadFront
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower1HeadLeft
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower1HeadRight
PARTS  += Building/Platforms/PlatformA/PlatformABase/BuildingATower2BaseSide

IMAGES  = WalkBridge

IMAGE_SOURCE_EXTENSION = .scad
OPENSCAD_ADDITION_ARGS = --imgsize 1920,1080

include ../Utils/build.mk

WalkBridge.png: $(IMAGESDIR)/WalkBridge.png
	cp $(IMAGESDIR)/WalkBridge.png WalkBridge.png
all: WalkBridge.png
