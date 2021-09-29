# Refactoring with classes

## Programme

This programme helps users organise a league-style championship.
Right now the user can:
* create a league with a list of players names
* show the matches
* record who won a match (draws have not been implemented yet)
* once all matches have a winner, you can get the overall winner for the league. This method works in a general case, but is buggy if several players are tied for the maximum number of wins.

## Task 1

Clone the project on your machine. 

```
git clone git@github.com:alicelieutier/OOD_exercise.git
cd OOD_exercise
```

Read the code and tests, and play with the programme in irb.
You can load the code in irb using:
```
require './lib/league_organiser.rb'
```

* Do you understand it?
* Are you able to use all the features? Read the spec file for examples of how to use the code.
* Can you spot ways of improving it?
* Are there things you learnt from it?
* Can you spot some good candidates for classes that could be extracted?

## Task 2

Extract a `Match` class from the programme.
* Start by modelling it - which properties and methods should that class have?
* Which methods from the `LeagueOrganiser` class will need to be rewritten?
* You'll use the existing test as a feature test (don't change it while you extract) and will create a unit test to test-drive the creation of your `Match` class.

## Task 3 - *stretch*

Write a unit test for the `LeagueOrganiser` class that is isolated from the `Match` class.

## Task 4 - *stretch*

Create a new feature using TDD: Instead of recording a win, the user can now record a score for the match. You should change the way matches are displayed accordingly.
This is a good opportunity to introduce the possibility of draws.
