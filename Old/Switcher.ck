public class Switcher {
    0 => int none;
    1 => int left;
    2 => int right;
    0 => int state;
    0 => int holder;
    0 => int counter;

    fun void triggerChange(int channel) {
        if (state == 0) {
            setStateFlag();
            channel => holder;
        } else if (state == 1) {
            if (holder != channel) {
                clearStateFlag();
            }
        }
    }

    fun void setStateFlag() {
        1 => state;
        0 => counter;
    }

    fun void clearStateFlag() {
        0 => state;
        none => holder;
        <<< counter >>>;
    }

    fun void tick() {
        if (state == 1) {
            counter + 1 => counter;
        } else {
            0 => counter;
        }
    }
    
    fun void clear() {
        0 => counter;
        none => holder;
        
    }
}
