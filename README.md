PokerEvaluator
=====================

This is a console program written in Swift that accepts as its input a collection of hands of three card Poker, and selects the winner from among those hands.

Input Format
------------

The input is read over `stdin`. Some of the lines will contain collections of cards. 

These cards are represented in the format format `<rank><Suit>`. 

rank is one of:
* an integer from `2` to `9` for numbered cards less than ten
* `T` for ten
* `J` for jack
* `Q` for queen
* `K` for king
* `A` for ace

Suit is one of:
* `h` for hearts
* `d` for diamonds
* `s` for spades
* `c` for clubs

For example `4d` is the four of diamonds, `Ts`, ten of spades, and `Ah`, ace of hearts.

Input Data
----------
The first line of input contains a single integer representing the number of players.

The following `n` lines, where `n` is the number of players, contain a single integer representing the id of the player, followed by three space-separated cards representing a hand belonging to a player.

An example input is as follows:

```
3
0 2c As 4d
1 Kd 5h 6c
2 Jc Jd 9s
```

Output Format
-------------

The output, printed to `stdout`, is the id of the winning player. In the example above, the correct output is:

```
2
```

since player with `id = 2` has the winning hand.

In the event of a tie, the ids of the winning players are output on one line, space-separated, in ascending order. For example, for the input:
```
4
0 Qc Kc 4s
1 Ah 2c Js
2 3h 9h Th
3 Tc 9c 3c
```

the correct output would be:

```
2 3
```

since those two players have equivalent hands (flushes, with a ten, a nine, and a three).

Three Card Poker Rules
----------------------

The winner of a round is the player with the best hand. The possible types of hands, ranked best to worst, are as follows:

* **Straight Flush:** A straight flush is a hand that is both a straight and a flush. That is to say, all three cards have the same suit, and their ranks form a "run" (check out the explanation for a straight).

* **Three Of A Kind:** A three of a kind is a hand in which all three of the cards have the same rank. An example might be `4c 4h 4d`, as all three cards are fours.

* **Straight:** A straight is a hand in which the cards have ranks that are in a "run." This means that they are of the format `n, n+1, n+2`. For example, the hand `5h 3c 4d` is a straight, because the cards can be ordered `3c 4d 5h` to form a "run" of `3-4-5`. The full order of the cards is `2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A`. Face cards form runs when they appear in that order, so `Qh Kd As` is a straight, because they form a run of `Q-K-A`. Runs can also include numbers and face cards, so `9h Td Js` is straight because it forms a run of `9-T-J`. When considering a straight, aces can also be used as a 1. That means that `A-2-3` is also a run. An ace cannot, however, be both high and low in the same straight, so `K-A-2` does not qualify.

* **Flush:** A flush is a hand in which all three cards have the same suit. An example might be `Ac 4c 8c`, as all three cards are clubs.

* **Pair:** A pair is a hand in which two of the cards have the same rank, but the third is different. An example is `4c 4d Ah`. This is a "pair of fours", because it has two fours.

* **High Card:** Any hand that doesn't fit into one of the other categories is considered a "high card" hand.

When comparing hands of the same type, the winner is the hand whose highest card is ranked higher. Therefore, `Ah 5h 2h` beats `Qd Jd 7d` because the first hand's highest card, an ace, is ranked higher than the second hand's highest card, a Queen. If the highest cards are equal, then the second highest cards should be compared. If those are equal, the third highest cards should be compared. If all three are equal, then the hands are tied.

The exception to this comes when comparing pairs. If two hands are both a pair, the winning hand is the hand that has a higher pair. For example `8c 8h 4d` beats `5s 5h 2h` because the pair of `8`s beats the pair of `5`s. If the pair is tied, then the remaining card is used to decide the winner.

(More about 3 Card Poker: [in this wikipedia article.](https://en.wikipedia.org/wiki/Three_card_poker))

Using the test runner
----------------------

The test runner in `PokerEvaluator/Tests/` can be used to end-to-end test the program with 20 sample tests and 10 sample error tests.

To run the tests, first compile the console application in Xcode (directions below), copy the executable to the Tests folder, and run the `run_tests` python script using `./run_tests "./PokerEvaluator"`.

How to compile using Xcode and run the test script
--------------------------------------------------

1. Download [Xcode 8.3.3 (Swift 3)](https://developer.apple.com/xcode/)
2. In Xcode, open the project file `PokerEvaluator.xcodeproj`
3. Run `Command-R`, or build `Command-B` the program
4. In the navigator window (far left pane), click on the `Products` folder to reveal the `PokerEvaluator` executable
5. Right click on it and select `Show in Finder`
6. Copy or move the `PokerEvaluator` executable to the `Tests` directory where the run_tests Python script is
7. From a terminal, enter the command: `./run_tests "./PokerEvaluator"`

Limitations
-----------

Currently, the program does not first verify if hands consists of cards from a single deck.  That is, unlimited identical cards are permitted, as occurs when playing with an unlimited number of multiple decks.

Program Entry Point
-------------------

`PokerEvaluator/main.swift`

High Level Design
-----------------

Models:

`Hand`: with player id, the cards, and score
`Card`: with `Suit` and `Rank` as enums

`Suit`: string enum of possible suits
`Rank`: int enum of possible ranks
`Score`: int constants for score value of hand types

`Error`: string constants for error messages

Services:

`GameManger` acts as the main executor of the high level logic of the program.  The execution flow is summarized in the `start()` method:  

* Get the game from console input (`GameDecoder`, `ConsoleWrapper`)
* Score the hands (`GameScorer`)
* Detemine the winner(s), and break ties if necessary (`GameJudge`)
* Print out the winner(s) (`ConsoleWrapper`)

Utilites:

`ConsoleWrapper`: console wrapper for input/output
`DIContainer`: functions as the dependency injection container
`ErrorHandler`: handles errors (prints out error message and kills execution)


Unit Tests
----------

All unit tests are run before the main program execution begins.  Because Xcode does not allow attaching an XCTest target to a console application target, I had to build my own simple test class to run the tests.

Unit tests may be disabled by commenting out `runUnitTests()` in `main.swift`


