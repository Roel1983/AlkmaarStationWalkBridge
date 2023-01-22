include <../../Utils/Constants.inc>

ViewEF();

module ViewEF() {
    translate([0, -30]) rotate(90, VEC_X) {
        scale(10/87) {
            color("red") import("ViewEF.svg", convexity=3);
        }
    }
}