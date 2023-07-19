import {bowlingScore} from "../src/BowlingGame";

describe("bowling_game", () => {
    // Remove the ".skip" below to enable this test case
    test.skip('acceptance test', () => {
        expect(bowlingScore(1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6)).toEqual(133);
    });
});
