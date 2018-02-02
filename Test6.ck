Gain output;
TDA analyzer;
adc.left => analyzer.inL;
adc.right=> analyzer.inR;
output => dac.left;
output => dac.right;
int del;

Gain mix;
  
adc.right => mix;

mix => OneZero lp => output;
lp => Delay d => lp;

0.9999 => float R;
spork ~ analyzer.run();
while(true) {
    analyzer.getDelay() => del;
//    <<< del >>>;
    del::samp * 10 => d.delay;
    10::ms => now;
}
