# Quick Retrospective

## Bowling Game

| Team | Date |
| -- | ---- |
| Coaches| 03/31/2022 |

## DO
_`What did we do?`_

- We did the FizzBuzz kata
- We used a stateful approach for testing (the classicist approach), we didn't use a terminal

- We added a main
- We added a terminal to the FizzBuzz and faked it
- We injected the fake terminal as a method parameter
- We followed a bottom-up approach

## LEARN
_`What did we learn?`_

- String.startWith method
- Java doesn't initialize the strings, we need to add = ""
- It made us think of ApprovalTests

## PUZZLE
_`What still puzzles us?`_

- Don't feel mocks are adapted to this kata, don't see who would use them, we should use a terminal or printer to try mocks
- Fake behavior wasn't obvious
- Fake behavior can become complicated so we thought we needed to test it, one can add the same contract tests (integration) that run on both the fake and the real object to keep them aligned, these tests are run once in a while

## DECIDE
_`How can we apply this in the future?`_

-
-

![Retrospective](./images/Retrospective.jpg)<br>
"[Too Busy to Improve](https://commons.wikimedia.org/wiki/File:Too_Busy_To_Improve_-_Performance_Management_-_Square_Wheels.png)" by [Alan O'Rourke](https://www.flickr.com/people/33524159@N00) is licensed under [Creative Commons Attribution 2.0 Generic](https://creativecommons.org/licenses/by/2.0/deed.en).
