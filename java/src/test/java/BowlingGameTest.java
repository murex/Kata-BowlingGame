import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class BowlingGameTest {
    @Ignore
    @Test
    public void acceptance_test() {
        assertEquals(133, BowlingGame.score(1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6));
    }
}
