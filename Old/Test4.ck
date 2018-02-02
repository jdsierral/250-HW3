adc.left => Gain inL;
adc.right => Gain inR;

inL => FullRect rectL;
rectL => OnePole pkL => blackhole;
rectL => OnePole rmsL => blackhole;

inR => FullRect rectR;
rectR => OnePole pkR => blackhole;
rectR => OnePole rmsR => blackhole;

0.5 => float tauF;
100 => float tauS;



Math.exp(-1.0/ (44100 * tauF / 1000.0 )) =>float a1F;
1.0 - a1F => float b0F;
Math.exp(-1.0/ (44100 * tauS / 1000.0 )) =>float a1S;
1.0 - a1S => float b0S;


rmsL.gain(20.0);
rmsR.gain(20.0);
pkL.a1(-a1F);
pkL.b0(b0F);
rmsL.a1(-a1S);
rmsL.b0(b0S);
pkR.a1(-a1F);
pkR.b0(b0F);
rmsR.a1(-a1S);
rmsR.b0(b0S);


SinOsc lTest => dac.left;
SinOsc rTest => dac.right;

spork ~ transientAnalysis();

fun void transientAnalysis() {
    while(true) {
        if (pkL.last() > rmsL.last()) {
            lTest.gain(1.0);
        } else {
            lTest.gain(0.0);
        }

        if (pkR.last() > rmsR.last()) {
            rTest.gain(1.0);
        } else {
            rTest.gain(0.0);
        }

        1::samp => now;
    }
}

while (true) {
    10::ms => now;
}
