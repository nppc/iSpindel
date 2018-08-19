//translate([0,-6,0])import("C:/src/Tennp/Git/iSpindel/drawer/drawer-combo-short-spring2.stl");
difference(){
    union(){
        rotate([-90,0,0])cylinder(d1=40,d2=38,h=40,$fn=50);
        rotate([-90,0,0])cylinder(d=38,h=120,$fn=50);
        translate([0,120,0])scale([1,1.7,1])sphere(d=38,$fn=50);
 
    }
    translate([0,130+25,0])cube([50,50,50],true);
    translate([0,100,-15])cube([50,200,20],true);
    translate([0,100,15])cube([50,200,20],true);
    translate([0,0,0])cube([24,100,20],true);
    translate([0,0,2])cube([25.5,100,2],true);
    translate([0,129,5])rotate([86,0,0])liion();
    for(i=[0:5.15:75])translate([11.3,47.5+i,-6])roundcut(8,3.9,7);
    for(i=[0:9.85:40])translate([14.4,2.5+i,-6])roundcut(7,9,4);
    mirror([1,0,0]){
        for(i=[0:5.2:75])translate([11.3,47.5+i,-6])roundcut(8,3.9,7);
        for(i=[0:9.9:40])translate([14.4,2.5+i,-6])roundcut(7,9,4);
    }
}

//roundcut(6,9,4);

module liion(){
    cylinder(d=19.5,h=68,$fn=50);
}


module roundcut(radius, width, rlen){
    minkowski(){
    union(){
        difference(){
            cylinder(r=radius,h=20,$fn=50);
            translate([0.2,-width+1.5,0])cylinder(r=radius,h=20,$fn=50);
            translate([rlen-1.5,-radius,0])cube([radius*2,radius*2,20]);
            translate([-radius*3,-width,0])cube([radius*3,radius*3,20]);
        }
    }
    cylinder(d=1.5,h=20,$fn=15);
    }
}
