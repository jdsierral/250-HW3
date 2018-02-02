//
//  ComplexTracker.ck
//
//
//  Created by JuanS.

/* 
Main Analyzer:

It is based on a complex tracker (different attack and release times)
and a slow rms to avoid false readings from noise
The Transient attack is defined as the moment where the fast tracker
has a higher value than the rmsTracker.
Then this boolean stream is converted to pulses by differentiating the
steam, and finally, only the rising edge is used to discard the moment
where the fast tracker goes below the rms tracker

Then this stream is given to the Switcher! */

public class TDA {
    Gain inL => blackhole;
    Gain inR => blackhole;

    inL.gain(1.0);
    inR.gain(1.0);

    ComplexTracker pkL;
    ComplexTracker pkR;
    Tracker rmsL;
    Tracker rmsR;

    Switcher sw;

    Diff reL;
    Diff reR;

    pkL.setFs ( 44100.0 );
    pkR.setFs ( 44100.0 );
    rmsL.setFs( 44100.0 );
    rmsR.setFs( 44100.0 );

    pkL.setTauAttack( 1 );
    pkR.setTauAttack( 1 );
    pkL.setTauRelease( 10 );
    pkR.setTauRelease( 10 );
    rmsL.setTau( 1000 );
    rmsR.setTau( 1000 );

    fun int getDelay() {
        return sw.getDelay();
    }

    fun int getDirection() {
        return sw.getDirection();
    }

    fun void run() {
        while(true) {
            inL.last() => float l;
            inR.last() => float r;

            pkL.tick ( l ) => float lF;
            pkR.tick ( r ) => float rF;
            rmsL.tick( l ) => float lS;
            rmsR.tick( r ) => float rS;

            (lF > 20 * lS) => int tL;
            (rF > 20 * rS) => int tR;

            reL.risingEdge( tL ) $ int => int flagL;
            reR.risingEdge( tR ) $ int => int flagR;

            sw.analyze(flagL, flagR);
            1::samp => now;
        }
    }
}
