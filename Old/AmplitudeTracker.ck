class AmplitudeTracker {
    float fs;
    float b;
    float a;
    
    float s;
    
    fun void init(float sampleRate) {
        sampleRate => fs;
    }
    
    fun void setTau(float milis) {
        -1.0/(fs * milis * 1000.0) => a;
    }
    
    fun float tick( float val ) {
        s + b * (s - Math.fabs(val)) => s;
        return s;
    }
}