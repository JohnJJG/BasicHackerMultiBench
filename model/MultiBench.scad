/*
Copyright © John Gilmour 2021
This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
Show="MultiBench"; // ["MultiBench (Jack)", "MultiBench (PSU)", "Face", "Back (XT60)", "Back (Jack)", "PSU"]

/*[Hidden]*/
HEIGHT=132;
WIDTH=164;
THICK=2;
THICK_BACK=2;
ANGLE=20;

B_DEPTH=40;

$fn=50;

SOLID=true;
CUTOUT=false;

if (Show=="MultiBench (Jack)") {
  rotate ([90,0,270]) translate ([-WIDTH/2,0,-45]) Combined("Jack");
}
else if (Show=="MultiBench (PSU)") {
  rotate ([90,0,270]) translate ([-WIDTH/2,0,-45]) Combined("PSU");
}
else if (Show=="Face") {
  MultiBench();
}
else if (Show=="Back (XT60)") {
  difference() {
    translate([1,-2,0]) Back("XT60");
  }
}
else if (Show=="Back (Jack)") {
  difference() {
    translate([1,-2,0]) Back("Jack");
  }
}
else if (Show=="PSU") {
  translate([THICK,-1,B_DEPTH+THICK]) mirror([0,0,1]) PSU();
}
module Combined(sInput) {
    rotate ([20,0,0]) MultiBench();
    if (sInput=="PSU")
      color ("DeepSkyBlue",1.0) translate([WIDTH,-.9,79]) mirror([1,0,0]) PSU();
    color ("Green",1.0) translate([WIDTH-0.4,-1,77]) mirror([1,0,0]) mirror([0,0,1]) Back(sInput);
}

module Back(sInput) {
  difference () {
    union() {
      difference() {
        union() {
          translate([-1.1,2.1,0]) cube([WIDTH+2-0.2,HEIGHT-14-0.2,THICK_BACK]);
          if (sInput=="Jack")
            translate([6.5,21,0]) Jack21_55(SOLID);
        }
        if (sInput=="XT60")
          translate([6.5,21,0]) XT60();
        else
          translate([6.5,21,0]) Jack21_55(CUTOUT);
          

        //hexagonal air vent
        translate([13,-2,-1]) for (xPos=[1:7]) {
          for (yPos=[0:9]) {
            translate([xPos*19.5,yPos*13.5,-1]) cylinder(h=10,r=6, $fn=6);
            translate([(xPos*19.5)+9.75,(yPos*13.5)+6.5,-1]) cylinder(h=10,r=6, $fn=6);
          }
        }
      }
      translate([51,21.5,0]) Fan60(SOLID);
      //need to trim the hexagonal air vents
      difference() {
        translate([25,2.1,0]) cube([WIDTH-24.3,HEIGHT-14-0.2,THICK_BACK]);
        translate([10,6,-1]) cube([WIDTH-17.5,HEIGHT-22,6]);
      }
    }
    translate([51,21.5,0]) Fan60(CUTOUT);

    //corner holes
    for (xPos=[WIDTH-4, 3.5]) {
      translate([xPos,116.75,-3]) cylinder(h=B_DEPTH+THICK+4,r=1.25);
      translate([xPos,7,-3]) cylinder(h=B_DEPTH+THICK+4,r=1.25);
    }
  }
}

module PSU(){
  difference() {
    union() {
      difference() {
        //box
        translate([-THICK,0.85,-1]) cube([WIDTH+(2*THICK),120,B_DEPTH+THICK+1]);
        //Lip
        translate([-1,1.85,-2]) cube([WIDTH+2,118,2]);
        //hollow box
        translate([0,0.85+THICK,-THICK-2]) cube([WIDTH,120-(2*THICK),B_DEPTH+(2*THICK)]);
        //mains switch hole
        translate([8,118,3]) cube([13,4,19.5]);
        //mains cable
        translate([-3,17,30]) rotate([0,90,0]) cylinder(h=10,r=5);
        
        //hexagonal back air vent
        translate([-5.5,-2,0]) for (xPos=[1:8]) {
          for (yPos=[0:8]) {
            translate([xPos*19.5,yPos*14,B_DEPTH-0.01]) cylinder(h=10,r=6, $fn=6);
            if ((xPos <8) && (yPos<9)) {
              translate([(xPos*19.5)+9.5,(yPos*14)+7.5,B_DEPTH-.01]) cylinder(h=10,r=6, $fn=6);
            }
          }
        }
        //hexagonal top air vent
        translate([-5.5,HEIGHT+36-0.155,-7.5]) rotate ([90,0,0]) for (xPos=[2:8]) {
          for (yPos=[0:3]) {
              translate([xPos*19.5,yPos*14,B_DEPTH-1]) cylinder(h=10,r=6, $fn=6);
            if (xPos<8)
              translate([(xPos*19.5)+9.5,(yPos*14)+7.5,B_DEPTH-1]) cylinder(h=10,r=6, $fn=6);
          }
        }
      }
      //hexagonal back air vent boundry frame
      difference() {
        translate([-THICK,0.85,B_DEPTH]) cube([WIDTH+(2*THICK),120,THICK]);
        translate([-THICK,3.5,B_DEPTH-1]) cube([WIDTH+(2*THICK),114,THICK+2]);
      }
      //hexagonal top air vent boundry frame
      difference() {
        union() {
          translate([21,HEIGHT-11.15,0]) rotate([90,0,0]) cube([WIDTH+THICK-21,B_DEPTH+THICK,THICK]);
          translate([25,HEIGHT-11.15,-1]) rotate([90,0,0]) cube([WIDTH+THICK-25,1,1]);
          translate([0,HEIGHT-11.15,38]) rotate([90,0,0]) cube([29,4,THICK]);
        }
        translate([27.5,HEIGHT-10,1]) rotate([90,0,0]) cube([WIDTH+THICK-37,39,THICK+2]);
      }
      //screw posts and holes
      difference() {
        union() {
          //corner screw posts
          for (xPos=[WIDTH-7, 0]) {
            translate([xPos,112.8,0]) cube([7,7,B_DEPTH+THICK]);
            translate([xPos,3,0]) cube([7,7,B_DEPTH+THICK]);
          }
          //back screw plate
          translate([0,39,B_DEPTH]) cube([WIDTH,8,THICK]);
        }
      }
    }
    // corner screw holes
    for (xPos=[WIDTH-4, 3.5]) {
      translate([xPos,116.75,-3]) cylinder(h=B_DEPTH+THICK+4,r=1.25);
      translate([xPos,116.75,3]) cylinder(h=B_DEPTH+THICK,r=2.5);
      translate([xPos,7,-3]) cylinder(h=B_DEPTH+THICK+4,r=1.25);
      translate([xPos,7,3]) cylinder(h=B_DEPTH+THICK,r=2.5);
    }
    //scew holes through the back
    for (xPos=[WIDTH-58, WIDTH-136]) {
      translate([xPos,43,B_DEPTH-1]) cylinder(h=THICK+2,d=2.5);
      translate([xPos,43,B_DEPTH+1]) cylinder(h=THICK+20,d=5);
    }
  }
}

module MultiBench(){
  difference(){
    union() {
      color ("White",1.0) Frame(SOLID); // add the solid psrt for holding the components
      color ("Red",1.0) Components(SOLID); // add the solid psrt for holding the components
    }

    color ("Red",1.0) Components(CUTOUT); //remove any material needed to house the components
    color ("White",1.0) Frame(CUTOUT);
  }
  difference () {
    union () {
      for (xPos=[-1, WIDTH-8]) {
        hull() {
          translate([xPos,130,33.5]) rotate ([-ANGLE,0,0]) cube([9,8,.1]);
          translate([xPos,132.3,18]) rotate ([-ANGLE+90,0,0]) cube([9,9,.1]);
        }
        hull() {
          translate([xPos,27,71]) rotate ([-ANGLE,0,0]) cube([9,8,.1]);
          translate([xPos,20,50]) rotate ([-ANGLE+90,0,0]) cube([9,9,.1]);
        }
      }
    }
    // corner screw holes
    for (xPos=[3.5, WIDTH-4]) {
      translate([xPos,130.5,20])  rotate ([-ANGLE,0,0]) cylinder(h=20,r=1.25);
      translate([xPos,25.7,53])  rotate ([-ANGLE,0,0]) cylinder(h=20,r=1.25);
    }
    //rotate ([-ANGLE,0,0]) translate([-(2*THICK),0,0]) linear_extrude(height = 73) square([WIDTH+(4*THICK), HEIGHT]);
  }
}

module Components(bProcess) {
  translate([90,HEIGHT,0]) Osc(bProcess); // referenced from inside top left
  translate([1.5,38,0]) Meter(bProcess,2);
  translate([95.5,9.5,0]) Meter(bProcess,1,iDigits=3);
  translate([8,83,-1]) Dsp150(bProcess);
  translate([6,3,5]) rotate([-ANGLE,0,0]) Usb(bProcess);
  translate([51,3,5]) rotate([-ANGLE,0,0]) Usb(bProcess);
  #translate([0,30,40]) rotate ([90,ANGLE,90]) Buck(bProcess);  // referenced bottom left
  translate([WIDTH,35,48]) rotate ([-90,ANGLE,90]) Buck(bProcess);  // referenced bottom left
  plugs_jack(bProcess); // 2.1mm barrel jacks
  plugs_post(bProcess); // binding posts
  plugs_flush(bProcess); // probe sockets
  translate ([108,2.5,1]) rotate([-ANGLE,0,0]) SlideSwitch(bProcess);
  translate ([0.5,47,0]) rotate([-ANGLE+90,0,0]) Vent(bProcess);
}
module Frame(bProcess){
  if (bProcess==SOLID) {
    //face, base, top, left side and right side
    translate([0,0,0]) linear_extrude(height = 2) square([WIDTH, HEIGHT]);
    rotate ([-ANGLE,0,0]) translate([0,0,.7]) linear_extrude(height = 165) square([WIDTH, THICK]);
    translate([-THICK,HEIGHT,0]) linear_extrude(height = 100) square([WIDTH+(2*THICK), THICK]);
    rotate ([-ANGLE,0,0]) translate([-(THICK),0,62]) linear_extrude(height = 100) square([WIDTH+(2*THICK), HEIGHT-12]);
    translate([WIDTH,0,0]) linear_extrude(height = 100) square([THICK, HEIGHT+THICK]);
    translate([-THICK,0,0]) linear_extrude(height = 100) square([THICK, HEIGHT+THICK]);

    //reinforcing spine (optional)
    translate([89.5,52,0]) cube([2,HEIGHT-52,15+THICK]);
    translate([89.5,0,0]) cube([2,45,15+THICK]);
  }
  else {
    //slice off the back, bottom, face
    rotate ([-ANGLE,0,0]) translate([-(2*THICK),0,78]) linear_extrude(height = 100) square([WIDTH+(4*THICK), HEIGHT]);
    rotate ([-ANGLE,0,0]) translate([-(2*THICK),0.01,.5]) linear_extrude(height = 200) rotate([180,0,0]) square([WIDTH+(4*THICK), 200]);
    translate([-4,-4,-50]) linear_extrude(height = 50) square([200,200]);
    rotate ([-ANGLE,0,0]) translate([0,2,61]) linear_extrude(height = 20) square([WIDTH, HEIGHT-16]);
    rotate ([-ANGLE,0,0]) translate([-1,1,76]) linear_extrude(height = 20) square([WIDTH+2, HEIGHT-14]);
  }
}
module XT60(){
  for (yPos=[0,20.5]) {  
    translate ([6.75,yPos,3]) cylinder(h=10, d=2.5, center=true);
    translate ([6.75,yPos,0.5]) cylinder(h=3, d=4.7, center=true);
  }
  hull () {
    translate ([6.75,6.25,3]) cube([8.5,8.5,10], center=true);
    translate ([6.75,14.25,3]) cylinder(h=10, d=8.5, center=true);
  }
}

// Power Jack, 2.1 x 5.5
module Jack21_55(bProcess){
  if (bProcess==SOLID) {
    translate ([0,60,0]) rotate([105,0,0]) translate ([6.75,10,1.5]) cylinder(h=65, d=18, center=false);
    //translate ([0,60,0]) rotate([105,0,0]) translate ([6.75,10,4]) cylinder(h=2, d=13.5, center=false);
  }
  else {
    translate ([0,60,0]) rotate([105,0,0]) translate ([6.75,10,0]) cylinder(h=10, d=7.8, center=false);
    translate ([0,60,0]) rotate([105,0,0]) translate ([6.75,10,6]) cylinder(h=60, d=13.5, center=false);
    translate ([-20,-20,-20]) cube([50,850,20], center=false);
  }
}

module Fan60(bProcess){
  iDiameter=60;
  if (bProcess==SOLID) {
    difference(){
      translate([3.25,3.25,0]) minkowski() {
        cube([iDiameter-5,iDiameter-5,THICK_BACK-1]);
        cylinder(h=1,d=10);
      }
      difference(){
        translate ([iDiameter/2+.5,iDiameter/2+.5,-1]) cylinder(h=8, d=59);
        translate ([iDiameter/2+.5,iDiameter/2+.5,-5]) cylinder(h=15, d=19);
      }
    }
    //translate([10,7,0]) rotate([0,0,45]) cube([iDiameter,4,3]);
    //translate([7,iDiameter-10,0]) rotate([0,0,-45]) cube([iDiameter,4,3]);
  }
  else {
    for (iX=[0,iDiameter-10]) {
      for (iY=[0,iDiameter-10]) {
        translate ([iX+5,iY+5,-.01]) cylinder(h=THICK_BACK+0.02, d2=4.3, d1=7);
      }
    }
  }
}

module Vent(bProcess){
  if (bProcess==SOLID) {
  }
  else {
    //hexagonal air vent
    translate([-6.5,10,0]) for (xPos=[1:8]) {
      for (yPos=[1:3]) {
        if ((xPos>1 || xPos<8) && yPos<3)
          translate([xPos*19.5,yPos*13.5,B_DEPTH-1]) cylinder(h=10,r=6, $fn=6);
        if ((xPos <8) && (yPos<3)) {
          translate([(xPos*19.5)+9.75,(yPos*13.5)+6.5,B_DEPTH-1]) cylinder(h=10,r=6, $fn=6);
        }
      }
    }
  }
}
module Usb(bSolid){
  if (bSolid==true) {
    difference() { //ledge with mounting hole cut
      translate([0,0,-5]) cube([36.4,2,25]);
      translate([17.8,-1,11.5]) rotate([-90,0,0]) cylinder(h=20,d=2.7);
    }
    translate([0.7,3,-5]) cube([35,11,15]); //usb board slot
  }
  else{
    translate([2.7,5,-5]) cube([30.8,7.5,20]);
    translate([2.7,5,0.5]) cube([31,7,20]);
    translate([0,2,-2]) cube([36.4,3,20]);
    translate([17.8,-5,11.5]) rotate([-90,0,0]) cylinder(h=6,d=5.8, $fn=6);
  }
}

module plugs_jack(bSolid){
  if (bSolid==true) {
  }
  else {
    for (xPlug=[13.75,34.25]) {
      translate([xPlug,72,-1]) cylinder(5,r=4);
    }
  }
}
  
module plugs_post(bSolid){
  if (bSolid==true) {
  }
  else {
    for (xPlug=[13.75,34.25,58.75,79.25]) {
      translate([xPlug,29,-1]) cylinder(5,r=2.1);
    }
    for (xPlug=[58.75,79.25,]) {
      translate([xPlug,72,-1]) cylinder(5,r=2.1);
    }
  }
}
  
module plugs_flush(bSolid){
  if (bSolid==true) {
    for (yPlug=[9.5,25.75]) {
      translate([WIDTH-15,yPlug,-1]) rotate([-ANGLE,0,0]) cylinder(6.5,d=15);
    }
  }
  else {
    for (yPlug=[9.5,25.75]) {
      translate([WIDTH-15,yPlug+1.5,2]) rotate([-ANGLE,0,0]) cylinder(5,d=12);
      translate([WIDTH-15,yPlug,-2.7]) rotate([-ANGLE,0,0]) cylinder(5.6,d=15);
    }
  }
}
  
module Attiny(bSolid){
  if (bSolid==SOLID) {
    Post(7,5.25, 1.25,bPin=true);
    Post(7,18.75, 1.25);
  }
  else {
  }
}

module Buck(bSolid){
  if (bSolid==SOLID) {
    Post(37,20, 1.25);
    Post(7,4, 1.25);
    Post(7,20, 1.25);
    Post(37,4, 1.25);
  }
  else {
  }
}

module Osc(bSolid){
  if (bSolid==true) {
    translate([0,0,THICK]) {
      // corner posts
      Post(66,-3.5, 1.25);
      Post(5,-88, 1.25);
      Post(5,-3.5, 1.25);
      Post(66,-79.5, 1.25);

      //analogue board post
      Post(5,-33.5, 1.25);

      //encoder posts
      Post(46,-81.5, 1.25);
      Post(25,-81.5, 1.25);
    }
  }
  else {
    // Oscilloscope Screen
    translate([11,-48,-1]) minkowski(){
      cube([49,38,5]);
      cylinder(r=1,h=5);
    }

    //inset
    translate([7,-68,1.5]) cube([57,62,5]);

    //buttons
    translate([15.1+(0*13.5),-60, -1]) cylinder(5,r=3.6);
    translate([15.1+(1*13.5),-60, -1]) cylinder(5,r=3.6);
    translate([15.1+(2*13.5),-60, -1]) cylinder(5,r=3.6);
    translate([15.1+(3*13.5),-60, -1]) cylinder(5,r=3.6);

    //rotary encoder
    translate([10+((51)/2),-81.5,-1]) cylinder(5,r=4,center=false);

    //top
    translate([53,-1,11]) mirror ([0,1,-1]) cylinder(THICK+2,r=6,center=false);
    translate([32,-1,5.5]) mirror ([0,1,-1]) cube([5.5,2,THICK+2],center=false);
    translate([14,-1,11]) mirror ([0,1,-1]) cube([8,3,THICK+2],center=false);
  }
}

module Dsp150(bSolid){
  if (bSolid==SOLID) {
  }
  else {
    cube([76.25,39.5,10]);
  }
}

module SlideSwitch(bSolid){
  if (bSolid==SOLID) {
  }
  else {
    translate([6.25,4.75,1.5]) rotate([180,0,0]) cube([7.75,3.5,4]);
    translate([0,0,1.4]) cube([20,6,10]);
  }
}

module Meter(bSolid, iCount=1, iDigits=4){
  if (bSolid==SOLID) {
    for (iMeter=[1:iCount]) {
      if (iMeter==1)
        difference(){
          translate([0,5.9,0]) cube([2,9,11.2+THICK]);
          #translate([0-.5,8,8.2+THICK]) cube([4,4.8,2]);
      }
      if (iCount==1 || iMeter<iCount) {
        difference(){
          if (iDigits == 4)
            translate([43,2.5,0]) cube([3.5,17,10.1+THICK]);
          else
            translate([43,2.5,0]) cube([2.5,17,10.1+THICK]);
          if (iDigits == 4)
            translate([44.75,17,THICK]) linear_extrude(height=12) circle(r=1.25);
          else
            translate([44.25,17,THICK]) linear_extrude(height=12) circle(r=1.25);
          #translate([43-.5,8,8.2+THICK]) cube([6,4.8,2]);
        }
      }
      if (iCount>1 && iMeter==iCount)
        difference() {
          translate([88,5.9,0]) cube([2,9,11.2+THICK]);
          translate([88-.5,8,8.2+THICK]) cube([4,4.8,2]);
      }

      translate([((iMeter-1)*45)+1.5,-2.25,THICK]) cube([41.5,2,5]);
      if (iDigits == 4)
        translate([((iMeter-1)*45)+1.5,21.95,THICK]) cube([41.5,2,5]);
      else
        translate([((iMeter-1)*45)+1.5,21.95,THICK]) cube([31.5,2,5]);
    }
  }
  else {
    for (xPos=[0:45:(iCount-1)*45]) {
      //screen hole and pocket
      if (iDigits == 4)
        translate([xPos+6.5,1,-1]) cube([32,19.2,5]);
      else
        translate([xPos+4.5,1,-1]) cube([36,19.2,5]);
      translate([xPos+2,0,1.5]) cube([41,21.2,2]);
    }
  }
}

module Buzzer(bSolid) {
  if (bSolid==SOLID) {
    cylinder(4,d=14);
  }
  else {
    cylinder(8,d=12.2);
  }
}

module Led(bSolid){
  if (bSolid==SOLID) {
    cylinder(4,d=6.5);
  }
  else {
    cylinder(6,d=5.2);
  }
}

module Post(iXOffset,iYOffset,hole_rad,iPostHeight=3, bPin=false){
  if (bPin==true) {
    translate([iXOffset,iYOffset,0]) cylinder(h=iPostHeight, r1=hole_rad+3, r2=hole_rad+1);
    //make pin for the screw hole
    translate([iXOffset,iYOffset,0]) cylinder(h=iPostHeight+2, r=hole_rad);
  }
  else { // make screw hole
    difference(){
      //translate([iXOffset,iYOffset,THICK]) linear_extrude(height = iPostHeight) circle(r=hole_rad+1);
      translate([iXOffset,iYOffset,0]) cylinder(h=iPostHeight, r1=hole_rad+3, r2=hole_rad+1);

      //make hole for the screw
      translate([iXOffset,iYOffset,0])
      linear_extrude(height = iPostHeight+1) circle(r=hole_rad);
    }
  }
}
