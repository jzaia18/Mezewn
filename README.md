# Project: *.ui

### by Team Mezewn: Adeebur Rahman, Michael Ruvinshteyn, Jake Zaia (pd01)



## What it is
A game library consisting of ripoffs of several of the internet-famous .io games. We have 4 games to play: Sagarui, Snekui, Chrenchui, and Warui. These are spoofs of http://agar.io http://slither.io http://diep.io and life itself respectively.



## How it works

### Sagarui
There are 3 main classes to Sagarui: Sagar, Ball, and Mass. There are more classes, but these are the most important of them. A Sagar is any player in the game in their entirety, whether human or AI. A Sagar is composed of many Balls, and keeps track of and controls all of its owned Balls. A Ball is a singular part of a given Sagar, a Ball can eat, grow, and attack on its own, but is united with the other Balls in its Sagar. Mass are just random sprinkles throughout the world which Balls can eat to increase their size.

The AIs are still a work in progress, but currently functioning by targetting the nearest Ball that is small enough to eat, and following it. If no such Ball exists, it moves randomly. While this is better than nothing at all, it's generally glitchy and uninteresting, so as we expand past our MVP this will improve.


### Snekui
Still a work in progress, check back soon.


## How to run it
Currently only Sagarui and Snekui are in working condition.

### To run Sagarui:
* ``` $ cd Sagarui```
* ``` $ processing Sagarui.pde```
* Press play within processing

### To run Snekui:
* ``` $ cd Snekui```
* ``` $ processing Snekui.pde```
* Press play within processing
