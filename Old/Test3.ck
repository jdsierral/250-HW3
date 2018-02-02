// adc => Gain g => dac;
adc.left => Gain gainL => FullRect rectL => OnePole onePoleL => blackhole;
adc.right => Gain gainR => FullRect rectR => OnePole onePoleR => blackhole;
onePoleL.a1(-0.99);
onePoleR.a1(-0.99);
onePoleL.b0(1 - 0.99);
onePoleR.b0(1 - 0.99);

0.001 => float th;

SinOsc oscL => dac.left;
SinOsc oscR => dac.right;

oscL.freq(400);
oscR.freq(1000);


fun void transientAnalysis( float val ) {
    
}


while (true) {
    if (onePoleL.last() > th) {
        <<< "left" >>> ;
        oscL.gain(1.0);
    } else {
        oscR.gain(0.0);
    }
    
    if (onePoleR.last() > th){
        <<< "right" >>> ;
        oscL.gain(1.0); 
    } else {
        oscL.gain(0.0);
    }
    
    1::samp => now;
}


