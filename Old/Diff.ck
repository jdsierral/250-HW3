public class Diff {
    float s;
    fun float tick(float val) {
        val - s => float out;
        val => s;
        return out;
    }

    fun float risingEdge(float val) {
        val - s => float out;
        val => s;
        return Math.max(0.0, out);
    }
}
