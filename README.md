# Project: \*.ui

### by Team Mezewn: Adeebur Rahman, Michael Ruvinshteyn, Jake Zaia (pd01)



## What it is

### Overview
A game library consisting of ripoffs of several of the internet-famous .io games. We have 4 games to play: Sagarui, Snekui, Chrenchui, and Warui. These are spoofs of http://agar.io http://slither.io http://diep.io and life itself respectively.

### Sagarui
Credit to http://agar.io for this idea.

Sagarui is a relatively straightforward game in which the user plays a cell in a world populated by other cells. The main goal of the game is not only to survive, but thrive by eating other smaller cells. The cell follows the mouse, and eats whatever it can as soon as it can. To split yourcellf into two smaller cells, press SPACE, and to eject part of your mass (possibly as bait for other cells) press W.

### Snekui
Credit to http://slither.io for this idea.

Snekui is a modern take on the classic game Snake. The idea is to grow as long as possible, and not crash into walls but with a simple twist: there are multiple snakes. Colliding with another snake spells instant death; more length means a higher score but also higher risk. The snake follows the mouse, with the only other control being that pressing the Left Mouse Button will consume part of your length for a temporary speed boost.

### Chrenchui
Credit to http://diep.io for this idea.

Chrenchui is similar to Sagarui in that you are simply an entity traversing the world trying to thrive. However in Chrenchui you are a tank, not a cell. Sound boring? It's not, theres a tank! Tanks have the ability to fire, replacing the concept of mass entirely with a much more universal healthbar that regends slowly and can be extinguished quickly. The tank uses WASD to move, and the gun on the tank follows the mouse. Press LMB to fire.

### Warui
WAAAAA WAAA WA http://i.imgur.com/toCTth5.png WAA WA.

It's a surprise. All you need to know is that 悪い (*warui*) means "bad" in Japanese. That and WAAAAAAAAA.

## How it works

### Sagarui
There are 3 main classes to Sagarui: Sagar, Ball, and Mass. There are more classes, but these are the most important of them. A Sagar is any player in the game in their entirety, whether human or AI. A Sagar is composed of many Balls, and keeps track of and controls all of its owned Balls. A Ball is a singular part of a given Sagar, a Ball can eat, grow, and attack on its own, but is united with the other Balls in its Sagar. Mass are just random sprinkles throughout the world which Balls can eat to increase their size.

The AIs function by targetting the largest Ball within a given vision radius. Depending on whether or not the target is larger than the AI, it will either attempt to hunt it down, or flee. If no such target exists, the AI will traverse the world gaining mass until it can find such Balls.


### Snekui
There are also 3 main classes to Snekui: Snek, Segment, and Mass. There are more classes, but these are the most important of them. A Snek is any player in the game in their entirety, whether human or AI. A Snek is composed of several Segments, which are stored as a Linked List. A Segment exists only as a part of a Snek, and is functionally just a moving wall that kills Sneks (aside from its parent). Mass are just random sprinkles throughout the world which Sneks can eat to increase their number of Segments, which to the user is just length.

The AIs function by targetting the nearest Snek in a given vision radius, and then attempting to move towards a fixed point in front of it. This in effect leads AIs to cut off other Sneks, which is the optimal strategy to kill others. An AI will attempt to avoid death if it is going to collide with another Snek, however depending on the surrounding environment this is not a guarenteed save. Sneks that have no target or wall to avoid will instead consume Mass around the board in order to increase length (and consequently score).

### Chrenchui
There are once again 3 main classes to Chrenchui: Chrench (Tanks), Bullet, and Shape. There are more classes, but these are the most important of them. A Chrench is any player in the game in their entirety, whether human or AI. A Chrench has a body, a gun, health and a score. These are the surface level elements that a user can easily distnguish. However Chrenchs are actually much more complex, containing a Deque of their fired Bullets, along with several variables that store reload times for various Chrench functions. A Bullet is fired by a Tank and acts as an unstoppable projectile that deals damage. Shapes are inanimate objects scattered throughout the world that can be user as both cover for fleeing Chrenchs, or to gain score by killing them.

The AIs function similarly to Snekui, in that they target a fixed point in front of a given Chrench and fire towards it. Chrenchs will flee from both Bullets as well as Shapes and other Chrenchs as there is collision damage.


### Warui
WAAAAAAAAAA WA WA WAAA WA WAAAA WA WAAA. WAAAAAAAAAAA WAAA WA WAA WA. WAAAA WAA!


## How to run it

### To run any of our games:
* ``` $ cd Starui```
* ``` $ processing Starui.pde```
* Press play within processing
* The program takes care of everything else, simply select the options you want