# IW4x-MP-GSC
Personal add-on scripts for IW4x dedicated server.

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
1. Place `rando.gsc` in your `\userraw\*`
2. Extract [these dependencies](https://github.com/TenaciousJ728/IW4x-MP-GSC/raw/refs/heads/main/scriptDependencies.zip) and place them with rando.gsc
3. Edit your server.cfg and add `set rando_enable 1`
4. Start server

### dvars

- `rando_enable` = 
  - `0` Rando disabled (default)
  - `1` Enable rando
- `rando_perks_mode` = 
  - `0` Perks disabled
  - `1` Base perks only
  - `2` Pro perks only (default)
  - `3` Base and pro perks shuffled
- `rando_mains_amount` = [integer value] (default: `2`) Amount of main weapons to give per loadout. I dare you to exceed 2!
- `rando_attachments_max` = [integer value] (default: `1`, hard cap: `2`) Preferred amount of attachments to give with each weapon where possible
- `rando_interval` =
  - `0` Interval disabled
  - [integer value] (default: `55`) Countdown interval in seconds before a new loadout is applied to players mid-game
- `rando_interval_reruns` =
  - `0` (default) Restart interval countdown indefinitely
  - [integer value] The finite amount of times to rerun the interval countdown
- `rando_oma_mode` =
  - `1` (default) Rolling One Man Army replaces a main weapon for the OMA backpack. Vanilla-ish behavior.
  - [other integer value] Rolling OMA gives backpack in addition to random loadout
- `rando_debug_loadout` = Prints debug lines showing the current loadout in raw form to the game's console
- `rando_debug_skip_enforcement` = Skips player loadout checks and class enforcement at first 15 seconds of round. Handy for buggy rando selection.

## To-do
- [x] Fix/rewrite multi-attachment selection
- [x] Make next-class preview pretty
- [x] Select player model based on selected primary main. (Gillie for snipers/heavy armor for shield)
- [ ] Select random weapon camo where applicable
- [ ] Make a rando mode for different classes per player, per life. (with weapon drops enabled)
- [ ] Make perks HUD show very current life's perks for OMA swapping and new rando mode
- [x] End class enforcement on using OMA. Or use `changed_kit` notify?
- [ ] Have killstreak rewards randomly selected per game?
- [ ] Add incendiary grenades
- [ ] Kick player out of OMA menu at countdown?
- [ ] Add HUD element toggles
- [ ] Use proper includes and make dependencies drop-in
- [ ] Optimize script flows
