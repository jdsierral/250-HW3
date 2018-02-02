public class Switcher {
    0 => int state;
    0 => int counter;
    1 => int del;
    1 => int direction;

    fun int getDelay() {
        return del;
    }

    fun int getDirection() {
        return direction;
    }

    fun void analyze(int l, int r) {

        l + r => int sw;

        if (sw == 1) {
            if (state == 0) {
                1 => state;
                0 => counter;
            } else {
                0 => state;
                if (r == 1) { 1 => direction; }
                else { -1=> direction; }
                Math.max(counter, 1) $ int => del;
                0 => counter;
            }
        }
        if (counter > 100){
            0 => state;
            0 => counter;
        }
        if (state == 1) {
            counter + 1 => counter;
        }
    }
}
