TDAnalyzer td;

adc.left => td.inL;
adc.right => td.inR;

spork ~ td.transientAnalysis();

while(true) {
    10::ms => now;
}