PART_SOURCE_EXTENSION =_Part.scad

PARTS  += Building/Bridge/ArcsAndTrestles/Arc
PARTS  += Building/Bridge/ArcsAndTrestles/Trestle
PARTS  += Building/Bridge/Roof/RoofAbBegin
PARTS  += Building/Bridge/Roof/RoofAbCenter
PARTS  += Building/Bridge/Roof/RoofAbEnd
PARTS  += Building/Bridge/Roof/RoofBcBegin
PARTS  += Building/Bridge/Roof/RoofBcEnd
PARTS  += Building/Bridge/SideWalk/SideWalkSegment1Left
PARTS  += Building/Bridge/SideWalk/SideWalkSegment1Right
PARTS  += Building/Bridge/SideWalk/SideWalkSegment2Left
PARTS  += Building/Bridge/SideWalk/SideWalkSegment2Right
PARTS  += Building/Bridge/SideWalk/SideWalkSegment3Left
PARTS  += Building/Bridge/SideWalk/SideWalkSegment3Right
PARTS  += Building/Bridge/Wall/WallSegment1Left
PARTS  += Building/Bridge/Wall/WallSegment1Right
PARTS  += Building/Bridge/Wall/WallSegment2Left
PARTS  += Building/Bridge/Wall/WallSegment2Right
PARTS  += Building/Bridge/Wall/WallSegment3Left
PARTS  += Building/Bridge/Wall/WallSegment3Right
PARTS  += Building/Bridge/Wall/WallSupportLeft
PARTS  += Building/Bridge/Wall/WallSupportRight
PARTS  += Building/Platforms/PlatformA/AbriRoof/AbriRoof
PARTS  += Building/Platforms/PlatformA/Base/AbriHeadBack
PARTS  += Building/Platforms/PlatformA/Base/AbriHeadFront
PARTS  += Building/Platforms/PlatformA/Base/AbriHeadLeft
PARTS  += Building/Platforms/PlatformA/Base/AbriHeadRight
PARTS  += Building/Platforms/PlatformA/Base/AbriRoofPart2
PARTS  += Building/Platforms/PlatformA/Base/Back
PARTS  += Building/Platforms/PlatformA/Base/Front
PARTS  += Building/Platforms/PlatformA/Base/Tower1BaseSide
PARTS  += Building/Platforms/PlatformA/Base/Tower1HeadBack
PARTS  += Building/Platforms/PlatformA/Base/Tower1HeadFront
PARTS  += Building/Platforms/PlatformA/Base/Tower1HeadLeft
PARTS  += Building/Platforms/PlatformA/Base/Tower1HeadRight
PARTS  += Building/Platforms/PlatformA/Base/Tower2BaseSide

IMAGES  = WalkBridge

IMAGE_SOURCE_EXTENSION = .scad
OPENSCAD_ADDITION_ARGS = --imgsize 1920,1080

include ../Utils/build.mk

WalkBridge.png: $(IMAGESDIR)/WalkBridge.png
	cp $(IMAGESDIR)/WalkBridge.png WalkBridge.png
all: WalkBridge.png
