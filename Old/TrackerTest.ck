class EnvTracker {
    float b;
    float a;
    0.0 => float s;
    
    fun void setTau( float samples ) {
        Math.exp(-1.0/samples) => a;
        1.0 - a => b;
    }
    
    fun float tick( float val ) {
        b * (s - val) + s => s;
        return s; 
    }
}


EnvTracker leftMag;
EnvTracker riteMag;

44100.0 => float fs; 
0 => int fL;
0 => int fR;

leftMag.setTau( fs * 1.0 / 1000.0 );
riteMag.setTau( fs * 1.0 / 1000.0 );

adc.left => Gain left => blackhole;
adc.right => Gain rite => blackhole;

left.gain(1.0);
rite.gain(1.0);

0.001 => float threshold;
<<< threshold >>>;
0 => int counter;

while(true) {
    left.last() => float l;
    rite.last() => float r;
    
    leftMag.tick( Math.fabs(l) ) => l;
    riteMag.tick( Math.fabs(r) ) => r;
    
    <<< l , r >>>;
    
    if ( l > threshold ) {
        <<< "hummm" >>>;
        if (fL == 0 && fR == 0) {
            spork ~ runTimer();
            <<< "Left" >>>;
            1 => fL;
        } else if (fL == 0 && fR == 1) {
            1 => fL;
        }
    }
    
    if ( r > threshold ) {
        if (fL == 0 && fR == 0) {
            spork ~ runTimer();
            <<< "Rite" >>>;
            1 => fR;
        } else if (fL == 0 && fR == 1) {
            1 => fR;
        }
    }
    
//    1::samp => now;
    100::ms => now;
}

fun void runTimer() {
    while(fL != fR) {
        counter++;
        1::samp => now;
    }
    <<< counter >>>;
    0 => counter;
    0 => fL;
    0 => fR;
}