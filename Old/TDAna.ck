public class TDAnalyzer {
    Gain inL => blackhole;
    Gain inR => blackhole;
    
    inL.gain(1.0);
    inR.gain(1.0);
    
    Tracker pkL;
    Tracker pkR;
    Tracker rmsL;
    Tracker rmsR;
    Switcher sw;

    Diff reL;
    Diff reR;
    
    pkL.setFs ( 44100.0 );
    pkR.setFs ( 44100.0 );
    rmsL.setFs ( 44100.0 );
    rmsR.setFs ( 44100.0 );
    
    pkL.setTau( 0.5 );
    pkR.setTau( 0.5 );
    rmsL.setTau( 100 );
    rmsR.setTau( 100 );

    0 => int state;
    0 => int counter;

    fun void run() {
        while (true) {
            inL.last() => float l;
            inR.last() => float r;

            pkL.tick ( Math.fabs(l) ) => float lF;
            rmsL.tick( Math.fabs(l) ) => float lS;
            pkR.tick ( Math.fabs(r) ) => float rF;
            rmsR.tick( Math.fabs(r) ) => float rS;
            
            (lF > 10 * lS) => int tL;
            (rF > 10 * rS) => int tR;

            reL.risingEdge( tL ) $ int => int flagL;
            reR.risingEdge( tR ) $ int => int flagR;
            
            if (flagL == 1) sw.triggerChange(1);
            if (flagR == 1) sw.triggerChange(0);
            if (tL == 0 && tR == 0) sw.clear();
            
            sw.tick();
            
            1::samp => now;
        }
    }
}
