//
//  ComplexTracker.ck
//
//
//  Created by JuanS.

/* Simple Test to verify inputs and outputs from interface */



adc.chan(0) => FullRect rect1 => OnePole p1 => blackhole;
adc.chan(1) => FullRect rect2 => OnePole p2 => blackhole;
adc.chan(2) => FullRect rect3 => OnePole p3 => blackhole;
adc.chan(3) => FullRect rect4 => OnePole p4 => blackhole;

p1.pole(0.9);
p2.pole(0.9);
p3.pole(0.9);
p4.pole(0.9);

SinOsc s1 => dac.chan(8);
SinOsc s2 => dac.chan(9);

while(true) {
    if (p1.last() > 0.01) <<< "IN 1" >>>;
    if (p2.last() > 0.01) <<< "IN 2" >>>;
    if (p3.last() > 0.01) <<< "IN 3" >>>;
    if (p4.last() > 0.01) <<< "IN 4" >>>;

    50::ms => now;


}
