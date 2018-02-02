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

piezoL => Dyno gateL => analyzer.inL;
piezoR => Dyno gateR => analyzer.inR;
mix => Delay dlyComp => Dyno gate => Gain exciter;
exciter => OneZero lp => NRev verb => output;
lp => DelayL d => Gain inv => lp;

200::samp => dlyComp.delay;
output.gain(0.1);

verb.mix(0.1);
inv.gain(1.0);
gateL.gate();
gateR.gate();
gateL.thresh(0.001);
gateR.thresh(0.001);

0.9999 => float radius;
gate.gate();
gate.thresh(0.001);
int del;
int dir;

Tracker portamento;

portamento.setFs(44100);
portamento.setTau(2);
100 => portamento.T;



spork ~ analyzer.run();
spork ~ tickPortamento();
spork ~ keyboard();

while(true) {
    analyzer.getDelay() => del;
    analyzer.getDirection() => dir;
    getPeriodFromDelay(del, dir) => int period;
    period => portamento.T; //d.delay;
    Math.pow(radius, period) => d.gain;
    100::ms => now;
}

fun void tickPortamento() {
    while(true) {
        portamento.tick() $ int => int newDelay;
        newDelay::samp => d.delay;
        1::samp => now;
    }
}

fun int getPeriodFromDelay(int del, int dir) {

    Math.min(Math.max((del * dir) + 100.0, 0.0), 200) / 2.0 => float pos;

    map.map(pos) => int zone;

    Std.mtof(zone + 57) => float freq;

    ( 44100 / freq ) $ int => int period;

    return period;
}

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
