# Tenacious-IW4x-GSC
A drop-in-opt-in collection of GSC files made for IW4x dedicated server. Simply drop the IWD package and enable any of the scripts through your `server.cfg`.

# Rando
A loadout randomizer.

<img width="1574" height="630" alt="bleh" src="https://github.com/user-attachments/assets/3eff065a-a8fe-48f7-8f92-de7d8326c4fe" />

## Features
- Works in all game modes
- Randomizes weapons, equipment, and perks. Either per round, or also after a set interval.
- Prevents players from switching classes within a round's first 15 seconds
- Displays current loadout's perks at all times
- Shows preview of next random loadout (if applicable) when imminent
- Bypasses rank/challenges requirements for things like weapon unlocks, Pro perks, and gillie suit. 
- Bots-friendly! This script won't crash the server upon spawning bots, even with a full load of bots.

## Installation
1. Download `tenacious.iwd` [here](https://github.com/TenaciousJ728/Tenacious-IW4x-GSC/releases/tag/tenacious), place it in your MW2's `\userraw` directory
2. Edit your server.cfg, add `set rando_enable 1` and any [dvars](#dvars) to taste
3. Start server

### dvars

|                  Name |           Value | Effect                                                                                         |
|----------------------:|----------------:|:-----------------------------------------------------------------------------------------------|
|          rando_enable |               0 | (default) Disable rando script                                                                 |
|                       |               1 | Enable rando                                                                                   |
|      rando_perks_mode |               0 | Skip giving perks                                                                              |
|                       |               1 | Give base perks only                                                                           |
|                       |               2 | (default) Give pro-tier perks                                                                  |
|                       |               3 | Shuffle each perk slot with base and pro-tier perks                                                               |
|           rando_mains | [integer value] | (default: 2) Preferred amount of main weapons to give per class                                |
|     rando_attachments | [integer value] | (default: 1) Preferred amount of attachments per main weapon                                   |
|        rando_interval |               0 | Mid-round class changing disabled                                                              |
|                       | [integer value] | (default: 55) Countdown interval in seconds before a new class is applied to players mid-game  |
| rando_interval_reruns |               0 | (default) Restart interval after countdown indefinitely                                        |
|                       | [integer value] | The amount of times to restart interval timer after countdown                                  |
|        rando_oma_mode |               1 | (default) One Man Army occupies a main weapon slot                                             |
|                       |               2 | Give OMA backpack in addition to given class                                                   |

## To-do
- [ ] Make interval reruns indefinite at `-1`
- [x] Fix/rewrite multi-attachment selection
- [x] Make next-class preview pretty
- [x] Select player model based on selected primary main. (Gillie for snipers/heavy armor for shield)
- [x] Select random weapon camo where applicable
- [ ] Make a rando mode for different classes per player, per life. (with weapon drops enabled)
- [ ] Make perks HUD show very current life's perks for OMA swapping and new rando mode
- [x] End class enforcement on using OMA. Or use `changed_kit` notify?
- [ ] Have blacklists definable through dvars
- [ ] Have killstreak rewards randomly selected per game?
- [ ] Add incendiary grenades
- [ ] Kick player out of OMA menu at countdown?

# Tourney
- [ ] More dvar toggles (interval timer, camo mode, etc.)
- [x] Pack with dependencies as IWD file, update [#Installation](#Installation).
- [ ] Optimize script flows
