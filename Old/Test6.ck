TDAnalyzer analyzer;


adc.left => analyzer.inL;
adc.right=> analyzer.inR;



spork ~ analyzer.run();

while(true) {
    10::ms => now;
}
