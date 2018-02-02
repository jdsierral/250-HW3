//
//  ComplexTracker.ck
//
//
//  Created by JuanS.

/* Main File!!! */


/* Create mappings for inputs from interface and outputs to interface */
Gain output;
Gain mix;
TDA analyzer;
Mapping map;
adc.chan(2) => Gain piezoL;
adc.chan(3) => Gain piezoR;
output => dac.chan(14);
output => dac.chan(15);
adc.chan(2) => mix;
adc.chan(3) => mix;


/* Add Gates to the inputs to avoid noise */
piezoL => Dyno gateL => analyzer.inL;
piezoR => Dyno gateR => analyzer.inR;
mix => Delay dlyComp => Dyno gate => Gain exciter;
exciter => OneZero lp => NRev verb => output;
lp => DelayL d => Gain inv => lp;

/* Small lag to allow string to be resized before it is excited */
200::samp => dlyComp.delay;
/* Master Gain/ */
output.gain(0.1);


/* Some Settings */
verb.mix(0.1);
inv.gain(1.0);
gateL.gate();
gateR.gate();
gateL.thresh(0.001);
gateR.thresh(0.001);

/* Pole Radius and other stuff */
0.9999 => float radius;
gate.gate();
gate.thresh(0.001);
int del;
int dir;

/* Portamento for interpolating delay */
Tracker portamento;

portamento.setFs(44100);
portamento.setTau(2);
100 => portamento.T;


/* Run analyzer, interpolator and keyboard listener */
spork ~ analyzer.run();
spork ~ tickPortamento();
spork ~ keyboard();


/* main Loop */
while(true) {
    analyzer.getDelay() => del;
    analyzer.getDirection() => dir;
    getPeriodFromDelay(del, dir) => int period;
    period => portamento.T; //d.delay;
    Math.pow(radius, period) => d.gain;
    100::ms => now;
}


/* Portamento Loop */
fun void tickPortamento() {
    while(true) {
        portamento.tick() $ int => int newDelay;
        newDelay::samp => d.delay;
        1::samp => now;
    }
}

/* Convert position to delay length based on frequency mapping based on mapping
object */

fun int getPeriodFromDelay(int del, int dir) {

    Math.min(Math.max((del * dir) + 100.0, 0.0), 200) / 2.0 => float pos;

    map.map(pos) => int zone;

    Std.mtof(zone + 57) => float freq;

    ( 44100 / freq ) $ int => int period;

    return period;
}

/* Listen to keyboard to control some parameters */
fun void keyboard() {
    Hid hid;
    HidMsg msg;

    hid.openKeyboard( 0 );
    <<< hid.name() >>>;

    while ( true ) {
        hid => now;
        while( hid.recv( msg ) ) {
            if ( msg.isButtonDown() ) {
                /* <<< msg.ascii >>>; */
                if (msg.ascii == 91) {
                    <<< "threshold decresed" >>>;
                    gateL.thresh() / 1.1 => gateL.thresh;
                    gateR.thresh() / 1.1 => gateR.thresh;
                } else if (msg.ascii == 93) {
                    <<< "threshold incresed" >>>;
                    gateL.thresh() * 1.1 => gateL.thresh;
                    gateR.thresh() * 1.1 => gateR.thresh;
                } else if (msg.ascii == 90) {
                    <<< "Activate inversion" >>>;
                    inv.gain() * -1.0 => inv.gain;
                } else if (msg.ascii == 65) {
                    <<< "Verb mix decreased" >>>;
                    Math.max(verb.mix() - 0.02, 0.0) => verb.mix;
                } else if (msg.ascii == 83) {
                    <<< "Verb mix increased" >>>;
                    Math.min(verb.mix() + 0.02, 1.0) => verb.mix;
                }
            }
        }
    }
}
