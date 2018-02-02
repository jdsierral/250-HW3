public class Tracker {
    float a;
    float b;
    float s;
    float fs;
    
    fun void setFs( float newFs) {
        newFs => fs;
    }

    fun void setTau( float valInMs ) {
        Math.exp(-1.0 / (fs * valInMs / 1000.0)) => a;
        <<< a >>>;
        1.0 - a => b;
        <<< b >>>;
    }

    fun float tick( float val ) {
        s + b * (val - s) => s;
        return s;
    }
}
