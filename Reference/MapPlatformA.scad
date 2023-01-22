include <../../Utils/Constants.inc>

MapPlatformA();

module MapPlatformA() {
    translate([0, 0, ($vpr[X] + 270) % 360 > 180 ? 160 : -1])
    scale(10/87) {
        color("red") import("MapPlatformA.svg", convexity=3);
    }
}

echo(($vpr[X] + 270) % 360 > 180);