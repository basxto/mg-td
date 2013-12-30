# mg-td


A tower defense scenario for the free rts megaglest

## Tools

rdfr (recursive dofile replacer) is a tool for combining multiple luafiles into just one.
But you can play it with disabled sandbox for development reasons.
This tool is absolutely primitive, there should be no other code in the same line!
It's looking for dofile(getSystemMacroValue("$SCENARIO_PATH").."filename"), where getSystemMacroValue("$SCENARIO_PATH") is the same as the directory where this script is executed.
Depedencies: bash, cat, sed, echo, cut, head, tail

## Licenses


All LUA code is licensed under the terms of GPL v3
  * https://www.gnu.org/licenses/gpl.html
The rest is licensed under the terms of Creative Commons Attribution-ShareAlike 3.0 Unported 
  * https://creativecommons.org/licenses/by-sa/3.0/
  

Authors:

The towerdefense tech-tree is based upon the megapack

towers:

air_pyramid, defense_tower, guard_tower, snake_basket, worker, barracks, eagle_pillar, minaret, sphinx, beehive, goldworker, mistletree, totem, castle, golem, power_golem, tower_of_souls

creeps:

behemoth, genie, mummy, pig, sheep
