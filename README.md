# IW4x-MP-GSC
Personal add-on scripts for IW4x dedicated server.

# Rando
A loadout randomizer.

<img width="2560" height="1080" alt="10190_18" src="https://github.com/user-attachments/assets/edf1dd52-a681-4323-bb4e-85c69a72ab6f" />

## Features
- Built for Search & Destroy, but should work for other modes too.
- Randomizes weapons, equipment, and perks. Either per round, or also after a set interval.
- Prevents players from switching classes within a round's first 15 seconds.
- Displays the current loadout's perks at all times.
- Bots-friendly! This script won't crash the server upon spawning bots, even with a full load of bots.

## Installation
1. Place `rando.gsc` in your `\userraw\*`
2. Extract [these dependencies](https://github.com/TenaciousJ728/IW4x-MP-GSC/raw/refs/heads/main/scriptDependencies.zip) and place them with rando.gsc
3. Start server

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
- `rando_debug_loadout` = Prints debug lines showing the current loadout in raw form to the game's console
- `rando_debug_skip_enforcement` = Skips player loadout checks and class enforcement at first 15 seconds of round. Handy for buggy rando selection.

## To-do
- [ ] Fix/rewrite multi-attachment selection.
- [ ] Make next-class preview pretty.
- [ ] Make a rando mode for different classes per player.
- [ ] Make perks HUD show very current life's perks for OMA swapping and new rando mode.
- [ ] End class enforcement on using OMA
- [ ] Bind OMA to key instead of as third weapon?
- [ ] Kick player out of OMA menu at countdown?
