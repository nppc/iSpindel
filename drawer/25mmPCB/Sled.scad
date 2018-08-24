// PCB is 25x48mm

$fn = 40;
length = 150;
diamchange = 4; // smaller 4mm each 10cm
diam1 = 39.9;
diam2 = diam1-(length/100*diamchange); 
echo(diam1);
echo(diam2);


difference(){
    mainpart();
    //translate([0,145+25,0])cube([50,50,50],true);
    translate([0,99,-15])cube([50,200,20],true);
    translate([0,99,15])cube([50,200,20],true);
    CutOut(24,48*2,2);
    translate([0,0,2])cube([25.3,48*2,1.85],true);
    translate([0,149,5])rotate([86,0,0])liion(); //battery
    translate([0,65,0])CutOut(18,26,3);
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
        translate([0,0,1])cube([25,38,2],true);
        for(i=[0:7.5:35])translate([0,i-17,0])CutOut(24,5.5,1.5);
    }
}

module toroid(diamext,diamint){
    cylinder(d=(diamext-(diamext-diamint)/2),h=(diamext-diamint)/2,center=true);
    rotate_extrude(convexity = 10)
    translate([(diamext-(diamext-diamint)/2)/2, 0, 0])
    circle(d = (diamext-diamint)/2, $fn = 30);
}

module donut(diamext,diamint){
    rotate_extrude(convexity = 10)
    translate([(diamext-(diamext-diamint)/2)/2, 0, 0])
    circle(d = (diamext-diamint)/2, $fn = 30);
}


module mainpart() {
  translate([0, length, 0]) 
  rotate([90, 0, 0])
  union() {
    //toroid(diam2,diam2-8);
    cylinder(d2=diam1-11,d1=diam2-11, h=length);
    //translate([0,0,length-2/2])toroid(diam1,diam1-2*2);
    for(i=[0:16.8:140])
       translate([0,0,i])spring(diam2+(i/100*diamchange),14,5.5,0.8);
  }
}

module spring(sdiam, slen, sh, thck){
    difference(){
        spring_sub(sdiam,slen,sh);
        translate([0,0,thck])spring_sub(sdiam-thck*2,slen-thck*2,sh-thck*2);
    }
}
    
module spring_sub(sdiam,slen,sh){
    sdiam2 = sdiam-((slen-sh)/100*diamchange);
    difference(){
        translate([0,0,sh/2])cylinder(d2=sdiam, d1=sdiam2,h=slen-sh);
        translate([0,0,sh/2])cylinder(d2=sdiam-sh*2, d1=sdiam2-sh*2,h=slen-sh);
    }
    translate([0,0,sh/2])donut(sdiam2,sdiam2-sh*2);
    translate([0,0,slen-sh/2])donut(sdiam,sdiam-sh*2);
}