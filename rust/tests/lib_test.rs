
use bowling_game;

#[test]
#[ignore]
fn acceptance_test() {
    assert_eq!(133, bowling_game::bowling_score(&mut [1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6]));
}
