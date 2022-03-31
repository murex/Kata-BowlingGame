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

- We moved the dependency further inside the code
- We made the calls more granular
- We used Mockito for mocks, mockito is already kind of a spy library

- We introduced a proxy terminal making use of our system and mock terminals
- Mirna played with intellij shortcuts

- Refactored around "\n" and observed which tests would break
- Observed that low level tests broke
- Converted the Terminal interface to an abstract class
- Got a brilliant explanation by Antoine on how Mockito works

## LEARN
_`What did we learn?`_

- String.startWith method
- Java doesn't initialize the strings, we need to add = ""
- It made us think of ApprovalTests

- how to create mocks with Mockito
- .var shortcut in IntelliJ

- Java is a nice high level language, but Antoine's preference to writing things in Assembly code helps him have a deeper understanding on how things work under the hood.
- Mocks make tests a bit harder to update
- In Java mocks, we put expectations after the call, while in C++ mock expectations are placed before
- One advantage of using mocks is that it forces you to add interfaces around your design
- For this kata, proxy didn't seem to bring much value


## PUZZLE
_`What still puzzles us?`_

- Don't feel mocks are adapted to this kata, don't see who would use them, we should use a terminal or printer to try mocks
- Fake behavior wasn't obvious
- Fake behavior can become complicated, so we thought we needed to test it, one can add the same contract tests (integration) that run on both the fake and the real object to keep them aligned, these tests are run once in a while

- Is mock testing better than the Fake? for this example not really
  - Is it more flexible? since we did not have to parse the outputs with the mock
  - Fakes are more refactoring friendly and reusable
  - Fakes can become monsters
  - How could we find a kata to highlight that?
  - People have strong opinions pros and against mocks

- the benefit is not yet obvious, but we feel the last iteration may help us see the big picture

## DECIDE
_`How can we apply this in the future?`_

- We should find some katas to experience in depth what test doubles feel

- Never ever let Damien and Patrice leave on their own

- Would like to dig further into each of the techniques, either continuing on FizzBuzz or with something else
- Would be nice to have a kata with the different types of tests (fake, mock, etc.) then add new features, and see the impact on existing tests 
- We need to find a kata allowing to practice seams

![Retrospective](./images/Retrospective.jpg)<br>
"[Too Busy to Improve](https://commons.wikimedia.org/wiki/File:Too_Busy_To_Improve_-_Performance_Management_-_Square_Wheels.png)" by [Alan O'Rourke](https://www.flickr.com/people/33524159@N00) is licensed under [Creative Commons Attribution 2.0 Generic](https://creativecommons.org/licenses/by/2.0/deed.en).
