// PCB is 25x48mm
// based on universam1 project

$fn = 80;
RohrInnenDurchmesser = 39.5; // 39,7
RohrInnenLaenge = 155; //149
Toleranz = 0.7; // Masstoleranz Abzug

width = RohrInnenDurchmesser - 2*Toleranz;
length = RohrInnenLaenge - 1* Toleranz - width/2;



//translate([0,-6,0])import("C:/src/Tennp/Git/iSpindel/drawer/drawer-combo-short-spring2.stl");
difference(){
    RohrInnen();
    translate([0,145+25,0])cube([50,50,50],true);
    translate([0,99,-15])cube([50,200,20],true);
    translate([0,99,15])cube([50,200,20],true);
    CutOut(24,48*2,2);
    translate([0,0,2])cube([25.5,48*2,2],true);
    translate([0,144,5])rotate([86,0,0])liion(); //battery
    for(i=[0:5.15:80])translate([11.3,47.5+i,-6])roundcut(8,3.9,7);
    for(i=[0:9.85:40])translate([14.4,2.5+i,-6])roundcut(7,9,4);
    mirror([1,0,0]){
        for(i=[0:5.2:80])translate([11.3,47.5+i,-6])roundcut(8,3.9,7);
        for(i=[0:9.9:40])translate([14.4,2.5+i,-6])roundcut(7,9,4);
    }
    translate([0,62,0])CutOut(18,22,3);
}
translate([0,30,-5])underPCB();

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

module CutOut(cw,cl,cdiam) {
  cwd=cw-cdiam;
  clw=cl-cdiam;
  hull(){
    translate([cwd/2,clw/2,0])cylinder(d=cdiam,h=20,$fn=20,center=true);
    translate([-cwd/2,clw/2,0])cylinder(d=cdiam,h=20,$fn=20,center=true);
    translate([cwd/2,-clw/2,0])cylinder(d=cdiam,h=20,$fn=20,center=true);
    translate([-cwd/2,-clw/2,0])cylinder(d=cdiam,h=20,$fn=20,center=true);
  }
}

module underPCB(){
    difference(){
        translate([0,0,1])cube([25,33,2],true);
        for(i=[0:7.5:35])translate([0,i-15,0])CutOut(24,5.5,1.5);
    }
}

module toroid(diamext,diamint){
    cylinder(d=(diamext-(diamext-diamint)/2),h=(diamext-diamint)/2,center=true,$fn=80);
    rotate_extrude(convexity = 10, $fn = 80)
    translate([(diamext-(diamext-diamint)/2)/2, 0, 0])
    circle(d = (diamext-diamint)/2, $fn = 30);
}


module RohrInnen() {
  echo("Variable length is ", length);
  echo("Variable width is ", width);
  translate([0, length, 0]) 
  rotate([90, 0, 0])
  translate([0, 0,30-(width/2)]) 
  union() {
    scale([1, 1, 30/(width/2)])  
    sphere(d=width);
    cylinder(d=width, h=length - (30-(width/2))-1/2, center=false);
    translate([0,0,length - (30-(width/2))-1/2])toroid(width,width-1*2);
  }
}