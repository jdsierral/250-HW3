public class Mapping {

    0 => int linear;
    1 => int pentatonic;

    1 => int mapping;

    fun int map(float pos) {
        if (mapping == linear) {
            return linearMapping(pos);
        }
        if (mapping == pentatonic) {
            return pentatonicMapping(pos);
        }

    }

    fun int linearMapping(float pos) {
        (pos / 10) $ int => int zone;
        10 - zone => zone;
        return zone;
    }

    fun int pentatonicMapping(float pos) {
        (pos / 10) $ int => int zone;
        10 - zone => zone;
        if (zone == 0) return -5;
        if (zone == 1) return 0;
        if (zone == 2) return 3;
        if (zone == 3) return 5;
        if (zone == 4) return 7;
        if (zone == 5) return 10;
        if (zone == 6) return 12;
        if (zone == 7) return 15;
        if (zone == 8) return 17;
        if (zone == 9) return 19;
    }
}
