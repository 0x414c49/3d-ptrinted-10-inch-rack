one_unit_width = 30;
// one_unit_width = 44.45; // standard size for one unit
one_unit_lenght = 254;
holder_width = 19;

keystone_width = 14.9;
keystone_length = 19.80;
keystone_x_position = 4;
keystone_wall_depth = 1.50;

depth = 10;

cable_holder_width = 40;


module keystone_hole(length = keystone_length, width = keystone_width, depth = 20) {    
    cube([length, width, depth]);
}

module keystone_holes(padding_length = 3, start_with = holder_width) {
    keystone_gap = (
        (one_unit_lenght - holder_width* 2) - (keystone_width * 12 ) - padding_length
    ) / 12;
    
    for (i = [0: 11]){              
        gap = keystone_gap * i; 

        keystone_y_position = start_with + gap + keystone_gap + (i * keystone_width) ;
        
        // front hole
        translate([keystone_x_position , keystone_y_position, 0]) 
        keystone_hole(length = 17);
        
        // back hole
        translate([keystone_x_position, keystone_y_position, 1]) 
        keystone_hole(depth=20);
                           
        // middle space
        translate([keystone_x_position-3, keystone_y_position, 1]) 
        keystone_hole(depth = depth - keystone_wall_depth - 1 , length = keystone_length  + 6);        
    }
}

module holder(position = 0) {
   translate([0, position, keystone_wall_depth])
   cube([one_unit_width, holder_width, 10]);    
    
   translate([6, position + 5, 0]) 
   cube([6, 10, 20]);
    
   translate([21, position + 5, 0]) 
   cube([6, 10, 20]);
}

module patch_panel() {
  difference() {       
    cube([one_unit_width, one_unit_lenght, depth]);
         
    holder();
    holder(one_unit_lenght - holder_width);
    
    keystone_holes();        
   } // end differene
} // end module


patch_panel();

