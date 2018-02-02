public class TDAnalyzer {
    Gain inL;
    Gain inR;

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

    0 => int flagL;
    0 => int flagR;
    0 => int flagT;

    fun void transientAnalysis() {
        while(true) {
            if (pkL.last() > rmsL.last()) 1 => flagL;
            if (pkR.last() > rmsR.last()) 1 => flagR;
            if (flagL != flagR) { 1 => flagT; } else { 0 => flagT; }

            1::samp => now;
        }
    }

    fun void timer() {
        0 => int counter;
        while(flagL != flagR) {
            counter + 1 => counter;
            1::samp => now;
        }
        0 => flagL;
        0 => flagR;
        <<< counter >>>;

    }
}
