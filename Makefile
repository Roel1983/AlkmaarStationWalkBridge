PART_SOURCE_EXTENSION =_Part.scad

IMAGES  = WalkBridge

IMAGE_SOURCE_EXTENSION = .scad
OPENSCAD_ADDITION_ARGS = --imgsize 1920,1080

include build.mk

include ../Utils/build.mk

WalkBridge.png: $(IMAGESDIR)/WalkBridge.png
	cp $(IMAGESDIR)/WalkBridge.png WalkBridge.png
all: WalkBridge.png
