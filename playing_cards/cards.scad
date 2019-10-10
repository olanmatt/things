// the thickness of the card
thickness = 0.35;

// the layer height you will print with
layer_height = 0.05;

card_style = "poker"; // [poker,bridge]
card_value = "A"; // [A,1,2,3,4,5,6,7,8,9,10,J,Q,K]
card_suit = "\u2660"; // [\u2660:Spade,\u2665:Heart,\u2666:Diamond,\u2663:Club]

font = "";
font_size = 10;

// how far the markings are offset from the edges of the card
text_offset = 5;

difference() {
    $fn=64;
    length = card_style == "poker" ? 88.9 : 88.9;
    width  = card_style == "poker" ? 63.50 : 57.15;
    radius = 6;
    
    // base shape
    cube([width, length, thickness]);
    
    // round bottom left
    difference() {
        cube([radius, radius, thickness]);
        translate([radius, radius, 0]) cylinder(h = thickness, r = radius);
    }
    
    // round top left
    translate([0, length - (radius * 2), 0]) difference() {
        translate([0, radius, 0]) cube([radius, radius, thickness]);
        translate([radius, radius, 0]) cylinder(h = thickness, r = radius);
    }
    
    // round bottom right
    translate([width - (radius * 2), 0, 0]) difference() {
        translate([radius, 0, 0]) cube([radius, radius, thickness]);
        translate([radius, radius, 0]) cylinder(h = thickness, r = radius);
    }
    
    // round top right
    translate([width - (radius * 2), length - (radius * 2), 0]) difference() {
        translate([radius, radius, 0]) cube([radius, radius, thickness]);
        translate([radius, radius, 0]) cylinder(h = thickness, r = radius);
    }

    // markings
    translate([text_offset, length - text_offset - font_size, thickness - layer_height]) 
        linear_extrude(height = layer_height)
        text(str(card_value, card_suit), font = font, size = font_size);
    translate([width - text_offset , text_offset + font_size, thickness - layer_height]) 
        linear_extrude(height = layer_height)
        rotate ([0, 0, 180]) 
        text(str(card_value, card_suit), font = font, size = font_size);
}