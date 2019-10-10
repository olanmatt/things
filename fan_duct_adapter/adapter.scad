fan_size = 6; // [0:40mm,1:50mm,2:60mm,3:70mm,4:80mm,5:92mm,6:120mm,7:140mm,8:200mm,9:220mm]

// in millimeters
duct_size = 100;

// length of duct adapter in millimeters
adapter_length = 50;

// thickness of adapter walls in millimeters
adapter_thickness = 3;

// thickness of fan interface in millimeters
fan_interface_thickness = 5;

union() {
    $fn = 64;
    
    // setting screw distance in a very ugly way... send help!
    fan_sizes = [40, 50, 60, 70, 80, 92, 120, 140, 200, 220];
    screw_distances = [32, 40, 50, 60, 72, 83, 105, 124.5, 154, 170];
    screw_distance = screw_distances[fan_size];
    fan_size = fan_sizes[fan_size];
    
    // setting some common values
    fan_radius = fan_size / 2;
    duct_radius = duct_size / 2;
    transition_length = abs(fan_size - duct_size);
     
    // fan interface
    difference() {
        z_offset = 0;
        
        cube([fan_size, fan_size, fan_interface_thickness]);
        
        translate([fan_radius, fan_radius, z_offset])
            cylinder(h = fan_interface_thickness, r = fan_radius - adapter_thickness);
        
        // screw holes
        screw_radius = 5.5 / 2;
        screw_offset = (fan_size - screw_distance) / 2;
        for (x_offset = [0:screw_distance:screw_distance]) {
            for (y_offset = [0:screw_distance:screw_distance]) {
                translate([screw_offset + x_offset, screw_offset + y_offset, z_offset])
                    cylinder(h = fan_interface_thickness, r = screw_radius);
                translate([screw_offset + x_offset, screw_offset + y_offset, z_offset + (fan_interface_thickness / 2)])
                    cylinder(h = fan_interface_thickness / 2, r = screw_radius * 2);
            }
        }
    }

    // transition
    difference() {
        z_offset = fan_interface_thickness;

        translate([fan_radius, fan_radius, z_offset])
            cylinder(h = transition_length, r1 = fan_radius, r2 = duct_radius);
            
        translate([fan_radius, fan_radius, z_offset])
            cylinder(h = transition_length, r1 = fan_radius - adapter_thickness, r2 = duct_radius - adapter_thickness);
    }
    
    // duct interface
    difference() {
        z_offset = fan_interface_thickness + transition_length;
        
        translate([fan_radius, fan_radius, z_offset])
            cylinder(h = adapter_length, r = duct_radius);
            
        translate([fan_radius, fan_radius, z_offset])
            cylinder(h = adapter_length, r = duct_radius - adapter_thickness);
    }
}