# mg-td


A tower defense scenario for the free rts megaglest

## Tools

rdfr (recursive dofile replacer) is a tool for combining multiple luafiles into just one.
But you can play it with disabled sandbox for development reasons.
This tool is absolutely primitive, there should be no other code in the same line!
It's looking for dofile(getSystemMacroValue("$SCENARIO_PATH").."filename"), where getSystemMacroValue("$SCENARIO_PATH") is the same as the directory where this script is executed.
Depedencies: bash, cat, sed, echo, cut, head, tail

## Licenses


All LUA code is licensed under the terms of Apache License, Version 2.0
  * https://www.apache.org/licenses/LICENSE-2.0.html
The rest is licensed under the terms of Creative Commons Attribution-ShareAlike 3.0 Unported 
  * https://creativecommons.org/licenses/by-sa/3.0/
  

Authors:

The towerdefense tech-tree is based upon the megapack

towers:

air_pyramid, defense_tower, guard_tower, snake_basket, worker, barracks, eagle_pillar, minaret, sphinx, beehive, goldworker, mistletree, totem, castle, golem, power_golem, tower_of_souls

creeps:

behemoth, genie, mummy, pig, sheep


## The game

I had planned to include dozens of creeps, towers and waves.
But got some fundamental problems:
  * You can’t give Buildings a target to attack
  * If you implement towers as units, they rotate
  * either way their automatic atticking strategy is just dump
  * It’s hard to hit fast units over a bigger range
That’s why it’s better to have less units, waves and towers.
Around 4 creeps and 4 towers should be sufficient.