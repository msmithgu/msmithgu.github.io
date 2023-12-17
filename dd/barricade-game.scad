$fa = 1;
$fs = 0.05;

$sheetDepth = 1;
$holeDepth = .5;
$holeDiameter = 1;
$holeMargin = .7;
$padding = 1.5;
$pathWidth = .125;
$pathDepth = .1;

$holeRadius = $holeMargin/2;
$holeStep = $holeDiameter+$holeMargin;
$width = 16*$holeStep + 2*$padding + 2*$holeRadius;
$height = 15*$holeStep + 2*$padding + 2*$holeRadius;
$pathY = $sheetDepth - $pathDepth;

difference(){
    // board
    translate([-$padding-$holeRadius, -$padding-$holeRadius, 0]) cube([$width, $height, $sheetDepth], false);

    // path
    union() {
        // vertical
        translate([8*$holeStep - $pathWidth/2, 14*$holeStep, $pathY]) cube([$pathWidth,1*$holeStep,$pathDepth*2], false);
        translate([0*$holeStep - $pathWidth/2, 12*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([16*$holeStep - $pathWidth/2, 12*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([8*$holeStep - $pathWidth/2, 10*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([6*$holeStep - $pathWidth/2, 8*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([10*$holeStep - $pathWidth/2, 8*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([4*$holeStep - $pathWidth/2, 6*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        translate([12*$holeStep - $pathWidth/2, 6*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        for (i=[2:4:14]) {
            translate([i*$holeStep - $pathWidth/2, 4*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        }
        for (i=[0:4:16]) {
            translate([i*$holeStep - $pathWidth/2, 2*$holeStep, $pathY]) cube([$pathWidth,2*$holeStep,$pathDepth*2], false);
        }
        for (i=[2:4:14]) {
            translate([i*$holeStep - $pathWidth/2, 1*$holeStep, $pathY]) cube([$pathWidth,1*$holeStep,$pathDepth*2], false);
        }
        for(i=[1:4:13]) {
            translate([i*$holeStep - $pathWidth/2, 0*$holeStep, $pathY]) cube([$pathWidth,1*$holeStep,$pathDepth*2], false);
            translate([(i+2)*$holeStep - $pathWidth/2, 0*$holeStep, $pathY]) cube([$pathWidth,1*$holeStep,$pathDepth*2], false);
        }
        
        // horizontal
        translate([0*$holeStep, 14*$holeStep - $pathWidth/2, $pathY]) cube([16*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([0*$holeStep, 12*$holeStep - $pathWidth/2, $pathY]) cube([16*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([6*$holeStep, 10*$holeStep - $pathWidth/2, $pathY]) cube([4*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([4*$holeStep, 8*$holeStep - $pathWidth/2, $pathY]) cube([8*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([2*$holeStep, 6*$holeStep - $pathWidth/2, $pathY]) cube([12*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([0*$holeStep, 4*$holeStep - $pathWidth/2, $pathY]) cube([16*$holeStep,$pathWidth,$pathDepth*2], false);
        translate([0*$holeStep, 2*$holeStep - $pathWidth/2, $pathY]) cube([16*$holeStep,$pathWidth,$pathDepth*2], false);
        for(g=[1:4:13]){
            translate([g*$holeStep, $holeStep - $pathWidth/2, $pathY]) cube([2*$holeStep,$pathWidth,$pathDepth*2], false);
        }
    }
    
    // holes
    union(){
        translate([8*($holeStep), 15*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[0:16]){
            translate([i*($holeStep), 14*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        translate([0*($holeStep), 13*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([16*($holeStep), 13*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[0:16]){
            translate([i*($holeStep), 12*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        translate([8*($holeStep), 11*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[6:10]){
            translate([i*($holeStep), 10*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        translate([6*($holeStep), 9*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([10*($holeStep), 9*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[4:12]){
            translate([i*($holeStep), 8*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }

        translate([4*($holeStep), 7*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([12*($holeStep), 7*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[2:14]){
            translate([i*($holeStep), 6*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        translate([2*($holeStep), 5*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([6*($holeStep), 5*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([10*($holeStep), 5*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([14*($holeStep), 5*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        
        for(i=[0:16]){
            translate([i*($holeStep), 4*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        translate([0*($holeStep), 3*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([4*($holeStep), 3*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([8*($holeStep), 3*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([12*($holeStep), 3*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        translate([16*($holeStep), 3*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        for(i=[0:16]){
            translate([i*($holeStep), 2*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
        }
        for(g=[0:3]){
            for(i=[0:2]){
                translate([((1+g*4)*$holeStep)+i*($holeStep), 1*$holeStep, $holeDepth]) cylinder(d=1, h=$sheetDepth+0.1);
            }
            for(i=[0:2:2]){
                translate([((1+g*4)*$holeStep)+i*($holeStep), 0*$holeStep,$holeDepth]) cylinder(d=1,h=$sheetDepth+0.1);
            }
        }
    }
}