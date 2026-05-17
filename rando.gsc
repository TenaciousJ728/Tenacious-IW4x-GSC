// ================================================
// IW4x mp "rando"
// beta-002
// by Tenacious J
// 
// A (single-class) loadout randomizer.
// Suitable for all modes.
// Compatiple with bots.
// ================================================

#include scripts\_utility;

init()
{
    setDvarIfUninitialized("rando_enable", 0);
    setDvarIfUninitialized("rando_perks_mode", 2);
    setDvarIfUninitialized("rando_mains", 2);
    setDvarIfUninitialized("rando_attachments", 1);
    setDvarIfUninitialized("rando_interval", 0);
    setDvarIfUninitialized("rando_interval_reruns", 0);
    setDvarIfUninitialized("rando_notify_at_seconds", 9);
    setDvarIfUninitialized("rando_switch_immediate", 0);
    setDvarIfUninitialized("rando_debug_loadout", 0);
    setDvarIfUninitialized("rando_debug_items", 0);
    setDvarIfUninitialized("rando_debug_skip_enforcement", 0);
    //For Muhlex script
    setDvarIfUninitialized("scr_death_drop_weapon", 0);


    if (!getDvarInt("rando_enable"))
        return;

    if (getDvarInt("rando_debug_loadout") == 1)
        iPrintLnBold("^5Rando beta001 loaded! Interval: ^2" + getDvarInt("rando_interval") + "s | Attachments: ^2" + getDvarInt("rando_attachments"));

    if (getDvarInt("rando_attachments") > 2)
        setDvar("rando_attachments", 2);
    if (getDvarInt("rando_attachments") < -1)
        setDvar("rando_attachments", -1);

    // ====================== getItems() ======================
    items = scripts\_items::getItems();
    level.weaponPool = items["weapon"];
    level.attachmentPool = items["attachment"];

    // ====================== WEAPON BLACKLIST ======================
    level.weaponBlacklist = [];
    level.weaponBlacklist[level.weaponBlacklist.size] = "onemanarmy_mp";

    // Filter the dynamic weaponPool (getItems() gives everything)
    filteredPool = [];
    keys = getArrayKeys(level.weaponPool);
    for (i = 0; i < keys.size; i++)
    {
        weaponName = keys[i];
        isBlacklisted = false;
        for (j = 0; j < level.weaponBlacklist.size; j++)
        {
            if (weaponName == level.weaponBlacklist[j])
            {
                isBlacklisted = true;
                break;
            }
        }
        if (!isBlacklisted)
            filteredPool[weaponName] = level.weaponPool[weaponName];
    }
    level.weaponPool = filteredPool;

    // Lethal / Tactical
    level.lethalPool = [];
    level.lethalPool[level.lethalPool.size] = "frag_grenade_mp";
    level.lethalPool[level.lethalPool.size] = "semtex_mp";
    level.lethalPool[level.lethalPool.size] = "throwingknife_mp";
    level.lethalPool[level.lethalPool.size] = "c4_mp";
    level.lethalPool[level.lethalPool.size] = "claymore_mp";
    level.lethalPool[level.lethalPool.size] = "specialty_blastshield";
    level.lethalPool[level.lethalPool.size] = "specialty_tacticalinsertion";
    level.tacticalPool = [];
    level.tacticalPool[level.tacticalPool.size] = "flash_grenade_mp";
    level.tacticalPool[level.tacticalPool.size] = "concussion_grenade_mp";
    level.tacticalPool[level.tacticalPool.size] = "smoke_grenade_mp";

    // Perk pools with Pro versions
    level.perk1Pool = [];
    level.perk1Pool[level.perk1Pool.size] = "specialty_marathon";
    level.perk1Pool[level.perk1Pool.size] = "specialty_fastreload";
    level.perk1Pool[level.perk1Pool.size] = "specialty_scavenger";
    if (getDvarInt("rando_attachments") >= 0)
        level.perk1Pool[level.perk1Pool.size] = "specialty_bling";
    level.perk1Pool[level.perk1Pool.size] = "specialty_onemanarmy";
    level.perk1ProPool = [];
    level.perk1ProPool[level.perk1ProPool.size] = "specialty_fastmantle";
    level.perk1ProPool[level.perk1ProPool.size] = "specialty_quickdraw";
    level.perk1ProPool[level.perk1ProPool.size] = "specialty_extraammo";
    if (getDvarInt("rando_attachments") >= 0)
        level.perk1ProPool[level.perk1ProPool.size] = "specialty_secondarybling";
    level.perk1ProPool[level.perk1ProPool.size] = "specialty_omaquickchange";

    level.perk2Pool = [];
    level.perk2Pool[level.perk2Pool.size] = "specialty_bulletdamage";
    level.perk2Pool[level.perk2Pool.size] = "specialty_lightweight";
    level.perk2Pool[level.perk2Pool.size] = "specialty_hardline";
    level.perk2Pool[level.perk2Pool.size] = "specialty_coldblooded";
    level.perk2Pool[level.perk2Pool.size] = "specialty_explosivedamage";
    level.perk2ProPool = [];
    level.perk2ProPool[level.perk2ProPool.size] = "specialty_armorpiercing";
    level.perk2ProPool[level.perk2ProPool.size] = "specialty_fastsprintrecovery";
    level.perk2ProPool[level.perk2ProPool.size] = "specialty_rollover";
    level.perk2ProPool[level.perk2ProPool.size] = "specialty_spygame";
    level.perk2ProPool[level.perk2ProPool.size] = "specialty_dangerclose";

    level.perk3Pool = [];
    level.perk3Pool[level.perk3Pool.size] = "specialty_extendedmelee";
    level.perk3Pool[level.perk3Pool.size] = "specialty_bulletaccuracy";
    level.perk3Pool[level.perk3Pool.size] = "specialty_localjammer";
    level.perk3Pool[level.perk3Pool.size] = "specialty_heartbreaker";
    level.perk3Pool[level.perk3Pool.size] = "specialty_detectexplosive";
    level.perk3Pool[level.perk3Pool.size] = "specialty_pistoldeath";
    level.perk3ProPool = [];
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_falldamage";
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_holdbreath";
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_delaymine";
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_quieter";
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_selectivehearing";
    level.perk3ProPool[level.perk3ProPool.size] = "specialty_laststandoffhand";

    level.perk4Pool = [];
    level.perk4Pool[level.perk4Pool.size] = "specialty_copycat";
    level.perk4Pool[level.perk4Pool.size] = "specialty_combathigh";
    level.perk4Pool[level.perk4Pool.size] = "specialty_grenadepulldeath";
    level.perk4Pool[level.perk4Pool.size] = "specialty_finalstand";

    if (getDvarInt("rando_debug_items") == 1)
    {
        wait 1;
        iPrintLn("^5=== ALL WEAPON STRINGS (" + level.weaponPool.size + " after blacklist) ===");
        keys = getArrayKeys(level.weaponPool);
        for (i = 0; i < keys.size; i++){
            iPrintLn("^2" + keys[i]);
            wait 0.05;
        }
        iPrintLn("^5=== ALL ATTACHMENT STRINGS (" + level.attachmentPool.size + ") ===");
        keys = getArrayKeys(level.attachmentPool);
        for (i = 0; i < keys.size; i++){
            iPrintLn("^2" + keys[i]);
            wait 0.05;
        }
        iPrintLn("^5=== LETHAL STRINGS (" + level.lethalPool.size + ") ===");
        for (i = 0; i < level.lethalPool.size; i++) {
            iPrintLn("^2" + level.lethalPool[i]);
            wait 0.05;
        }
        iPrintLn("^5=== TACTICAL STRINGS (" + level.tacticalPool.size + ") ===");
        for (i = 0; i < level.tacticalPool.size; i++) {
            iPrintLn("^2" + level.tacticalPool[i]);
            wait 0.05;
        }
    }

    level.currentLoadout = level getRandomLoadout();

    level thread OnPrematchOver();
    level thread OnPlayerConnected();
    level thread intervalSystem();
    level thread startEnforcementSystem();
}

OnPlayerConnected()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread OnPlayerSpawned();
    }
}

OnPlayerSpawned()
{
    self endon("disconnect");

    for (;;)
    {
        self waittill("spawned");

        wait 0.05;

        self applyRandomLoadout(level.currentLoadout, false);

//        if (getDvarInt("rando_debug_loadout") == 1)
//            self thread debugPrintLoadout(level.currentLoadout);
    }
}

OnPrematchOver()
{
    level waittill("prematch_over");
    level thread watchForNewRounds();
}

watchForNewRounds()
{
    level endon("game_ended");
    for (;;)
    {
        level waittill("round_ended");
        wait 0.5;
        level.currentLoadout = level getRandomLoadout();
    }
}

startEnforcementSystem()
{
    level endon("game_ended");
    level endon("round_ended");

    wait 0.5;

    if (getDvarInt("rando_debug_skip_enforcement") == 1)
    {
        if (getDvarInt("rando_debug_loadout") == 1)
            iPrintLn("^5[DEBUG] Enforcement SKIPPED");
        return;
    }

    foreach (player in level.players)
        if (isDefined(player))
            player thread monitorClassEnforcement();

    for (;;)
    {
        level waittill("prematch_over");

        if (getDvarInt("rando_debug_loadout") == 1)
            iPrintLn("^5[DEBUG] Enforcement started for new round");

        foreach (player in level.players)
        {
            if (isDefined(player))
                player thread monitorClassEnforcement();
        }
    }
}



intervalSystem()
{
    level endon("game_ended");
    level endon("round_ended");

    for (;;)
    {
        interval = getDvarInt("rando_interval");
        if (interval <= 0)
        {
            wait 2;
            continue;
        }

        rerunsLeft = getDvarInt("rando_interval_reruns");

        level waittill("prematch_over");

        while (true)
        {
            level.nextLoadout = level getRandomLoadout();

            level thread uiPersistentCountdownTimer(interval);

            for (timeLeft = interval; timeLeft > 0; timeLeft--)
                wait 1;

            level.currentLoadout = level.nextLoadout;
            level.nextLoadout = level getRandomLoadout();

            foreach (player in level.players)
            {
//                if (isDefined(player) && isAlive(player))
                if (isDefined(player))
                {
                    player applyRandomLoadout(level.currentLoadout, false);
                    if (getDvarInt("rando_debug_loadout") == 1)
                        player iPrintLnBold("^2Class changed mid-round!");
                }
            }

            if (rerunsLeft > 0)
            {
                rerunsLeft--;
                if (rerunsLeft <= 0)
                    break;
            }
        }
    }
}

watchForRoundEnd(label, number)
{
    level waittill("round_ended");
    if (isDefined(label)) label destroy();
    if (isDefined(number)) number destroy();
}

watchForGameEnd(label, number)
{
    level waittill("game_ended");
    if (isDefined(label)) label destroy();
    if (isDefined(number)) number destroy();
}


monitorClassEnforcement()
{
    self endon("disconnect");
    self endon("round_ended");
    self endon("game_ended");

    if (getDvarInt("rando_debug_loadout") == 1)
        self iPrintLn("^5[DEBUG] Enforcement monitor started for this round");

    for (i = 0; i < 150; i++)
    {
        wait 0.1;

        mismatch = false;
        if (isDefined(level.currentLoadout.mainWeapons))
        {
            foreach (def in level.currentLoadout.mainWeapons)
                if (!self hasWeapon(def.fullName)) mismatch = true;
        }
        else if (!self hasWeapon(level.currentLoadout.primary) || !self hasWeapon(level.currentLoadout.secondary))
            mismatch = true;

        if (mismatch)
            self applyRandomLoadout(level.currentLoadout, true);
    }
}


getRandomLoadout()
{
    loadout = spawnStruct();

    // ====================== PERKS FIRST ======================
    perksMode = getDvarInt("rando_perks_mode");
    if (perksMode == 0)
    {
        loadout.perk1 = undefined; loadout.perk1Pro = undefined;
        loadout.perk2 = undefined; loadout.perk2Pro = undefined;
        loadout.perk3 = undefined; loadout.perk3Pro = undefined;
        loadout.perk4 = undefined;
    }
    else
    {
        idx1 = randomInt(level.perk1Pool.size);
        loadout.perk1    = level.perk1Pool[idx1];
        if (perksMode == 2 || (perksMode == 3 && randomInt(2) == 0))
            loadout.perk1Pro = level.perk1ProPool[idx1];

        idx2 = randomInt(level.perk2Pool.size);
        loadout.perk2    = level.perk2Pool[idx2];
        if (perksMode == 2 || (perksMode == 3 && randomInt(2) == 0))
            loadout.perk2Pro = level.perk2ProPool[idx2];

        idx3 = randomInt(level.perk3Pool.size);
        loadout.perk3    = level.perk3Pool[idx3];
        if (perksMode == 2 || (perksMode == 3 && randomInt(2) == 0))
            loadout.perk3Pro = level.perk3ProPool[idx3];

        loadout.perk4 = level.perk4Pool[randomInt(level.perk4Pool.size)];
    }
    // ====================== MAIN WEAPONS ======================
    amount = getDvarInt("rando_mains");
    if (amount < 1) amount = 1;
    if (amount > level.weaponPool.size) amount = level.weaponPool.size;

    loadout.mainWeapons = [];
    keys = getArrayKeys(level.weaponPool);
    temp = [];
    for (i = 0; i < keys.size; i++)
        temp[temp.size] = keys[i];

    for (i = 0; i < amount && temp.size > 0; i++)
    {
        idx = randomInt(temp.size);
        weaponKey = temp[idx];
        baseItem = level.weaponPool[weaponKey];

        // Bling math
        baseAttach = getDvarInt("rando_attachments");
        if (baseAttach == -1) baseAttach = 0;
        else if (baseAttach > 2) baseAttach = 2;

        hasBling    = (isDefined(loadout.perk1)    && loadout.perk1    == "specialty_bling");
        hasBlingPro = (isDefined(loadout.perk1Pro) && loadout.perk1Pro == "specialty_secondarybling");

        attachCount = baseAttach;
        if (hasBling && loadout.mainWeapons.size == 0)
            attachCount += 1;
        if (hasBlingPro)
            attachCount += 1;
        if (attachCount > 2)
            attachCount = 2;

        // === Pure table-driven selection ===
        attachments = selectValidAttachments(baseItem, attachCount);

        weaponDef = scripts\_items::createWeaponDef(baseItem, attachments, undefined);
        loadout.mainWeapons[loadout.mainWeapons.size] = weaponDef;

        // Remove used weapon
        newTemp = [];
        for (j = 0; j < temp.size; j++)
            if (j != idx)
                newTemp[newTemp.size] = temp[j];
        temp = newTemp;
    }

    loadout.lethal   = level.lethalPool[randomInt(level.lethalPool.size)];
    loadout.tactical = level.tacticalPool[randomInt(level.tacticalPool.size)];

    return loadout;
}

selectValidAttachments(baseItem, attachCount)
{
    if (attachCount <= 0 || !isDefined(baseItem) || !isDefined(baseItem.validAttachments) || baseItem.validAttachments.size == 0)
        return [];

    for (try = 0; try < 30; try++)
    {
        selected = [];   // always initialized

        // Fresh copy of candidates (manual because no arrayCopy())
        candidates = [];
        for (j = 0; j < baseItem.validAttachments.size; j++)
            candidates[candidates.size] = baseItem.validAttachments[j];

        // === PRIMARY ===
        primaryIdx = randomInt(candidates.size);
        primary = candidates[primaryIdx];
        selected[selected.size] = primary;

        if (attachCount == 1)
            return selected;

        // === SECONDARY - strict combosMap filter from attachmentcombos.csv ===
        secondaryCandidates = [];
        foreach (att in candidates)
        {
            if (att.name == primary.name)
                continue;
            if (isDefined(primary.combosMap[att.name]) && primary.combosMap[att.name])
                secondaryCandidates[secondaryCandidates.size] = att;
        }

        if (secondaryCandidates.size == 0)
            continue;   // bad primary → retry whole thing

        secondary = secondaryCandidates[randomInt(secondaryCandidates.size)];
        selected[selected.size] = secondary;

        // Final pair validation
        if (isDefined(primary.combosMap[secondary.name]) && primary.combosMap[secondary.name] &&
            isDefined(secondary.combosMap[primary.name]) && secondary.combosMap[primary.name])
        {
            return selected;   // good pair
        }

        // otherwise retry (mainly secondary)
    }

    // Fallback - return whatever we managed to get (should be rare)
//    return selected;
}



applyRandomLoadout(loadout, isEnforcement)
{
    self maps\mp\_utility::_clearPerks();
    foreach (weapon in arrayCombine(self getWeaponsListPrimaries(), self getWeaponsListOffhands()))
        self takeWeapon(weapon);

    if (getDvarInt("rando_perks_mode") != 0)
    {
        if (!isEnforcement)
            self maps\mp\perks\_perks::givePerk(loadout.perk4);
        self maps\mp\perks\_perks::givePerk(loadout.perk1);
        if (isDefined(loadout.perk1Pro))
            self maps\mp\perks\_perks::givePerk(loadout.perk1Pro);
        self maps\mp\perks\_perks::givePerk(loadout.perk2);
        if (isDefined(loadout.perk2Pro))
            self maps\mp\perks\_perks::givePerk(loadout.perk2Pro);
        self maps\mp\perks\_perks::givePerk(loadout.perk3);
        if (isDefined(loadout.perk3Pro))
            self maps\mp\perks\_perks::givePerk(loadout.perk3Pro);
    }

    if (isDefined(loadout.mainWeapons))
        foreach (def in loadout.mainWeapons)
            self scripts\_items::give(def);

    if (loadout.lethal == "frag_grenade_mp")
    {
        self giveWeapon(loadout.lethal);
        self SetOffhandPrimaryClass("frag");
    }
    else if (loadout.lethal == "throwingknife_mp")
    {
        self SetOffhandPrimaryClass("throwingknife");
        self maps\mp\perks\_perks::givePerk(loadout.lethal);
    }
    else if (loadout.lethal == "semtex_mp" || loadout.lethal == "c4_mp" || loadout.lethal == "claymore_mp")
    {
        self SetOffhandPrimaryClass("other");
        self giveWeapon(loadout.lethal);
    }
    else
    {
        self SetOffhandPrimaryClass("other");
        self maps\mp\perks\_perks::givePerk(loadout.lethal);
    }

    self giveWeapon(loadout.tactical);
    if (loadout.tactical == "flash_grenade_mp")
    {
        self SetOffhandSecondaryClass("flash");
        self giveWeapon(loadout.tactical);
    }
    else
    {
        self SetOffhandSecondaryClass("smoke");
        self giveWeapon(loadout.tactical);
    }

//    wait 0.1;
    if (loadout.perk1 == "specialty_onemanarmy")
        self giveWeapon("onemanarmy_mp");
    if (getDvarInt("rando_debug_loadout") == 1)
        self thread debugPrintLoadout(level.currentLoadout, false);
    self updatePerkIcons(loadout);

    wait 0.05;
    if (getDvarInt("rando_switch_immediate") == 1)
        self switchToWeaponImmediate(loadout.mainWeapons[0].fullName);
    else 
        self switchToWeapon(loadout.mainWeapons[0].fullName);
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
}

debugPrintLoadout(loadout, isNextLoadout)
{
    self endon("disconnect");

    if (isNextLoadout)
    {
        prefix = "^5[NEXT CLASS PREVIEW] ";
        // Called from level timer thread → broadcast to all alive players
        foreach (player in level.players)
//            if (isDefined(player) && isAlive(player))
            if (isDefined(player)
                player thread playerPrintLoadout(loadout, prefix);
        return;
    }

    // Normal case — called on a player (current loadout)
    prefix = "^3[CURRENT CLASS] ";
    self thread playerPrintLoadout(loadout, prefix);
}



playerPrintLoadout(loadout, prefix)
{
    self endon("disconnect");

    if (isDefined(loadout.mainWeapons))
    {
        mains = "";
        for (i = 0; i < loadout.mainWeapons.size; i++)
        {
            mains += loadout.mainWeapons[i].fullName;
            if (i < loadout.mainWeapons.size - 1)
                mains += " | ";
        }
        self iPrintLn(prefix + "Main weapons: ^2" + mains);
    }

    self iPrintLn(prefix + "Offhands: ^2" + loadout.lethal + " | " + loadout.tactical);

    perksMode = getDvarInt("rando_perks_mode");
    if (perksMode != 0)
    {
        perks = loadout.perk1;
        if (isDefined(loadout.perk1Pro)) perks += " (Pro)";
        perks += " | " + loadout.perk2;
        if (isDefined(loadout.perk2Pro)) perks += " (Pro)";
        perks += " | " + loadout.perk3;
        if (isDefined(loadout.perk3Pro)) perks += " (Pro)";
        perks += " | " + loadout.perk4;

        self iPrintLn(prefix + "Perks: ^2" + perks);
    }
    else
    {
        self iPrintLn(prefix + "^1(No perks — rando_perks_mode 0)");
    }
}



uiPersistentCountdownTimer(totalTime)
{
    level notify("newCountdownTimer");
    level endon("newCountdownTimer");
    level endon("game_ended");
    level endon("round_ended");

    notifyAt = getDvarInt("rando_notify_at_seconds");

    label = newHudElem();
    label.alignX = "center";
    label.alignY = "bottom";
    label.horzAlign = "center";
    label.vertAlign = "bottom";
    label.x = 0;
    label.y = -60;
    label.font = "default";
    label.fontScale = 1.1;
    label.color = (1, 1, 1);
    label.glowAlpha = 0;
    label.alpha = 1;
    label setText("Next class in");

    number = newHudElem();
    number.alignX = "center";
    number.alignY = "bottom";
    number.horzAlign = "center";
    number.vertAlign = "bottom";
    number.x = 0;
    number.y = -40;
    number.font = "objective";
    number.fontScale = 2.0;
    number.color = (1, 1, 1);
    number.glowAlpha = 0;
    number.alpha = 1;

    level thread watchForRoundEnd(label, number);
    level thread watchForGameEnd(label, number);

    for (timeLeft = totalTime; timeLeft > 0; timeLeft--)
    {
        number setText(timeLeft + "s");

        if (timeLeft <= 20)
        {
            label.color = (1, 0.65, 0.2);
            number.color = (1, 0.65, 0.2);
            label.glowColor = (1, 0.65, 0.2);
            number.glowColor = (1, 0.65, 0.2);
            label.glowAlpha = 0.8;
            number.glowAlpha = 0.8;
        }
        else
        {
            label.color = (1, 1, 1);
            number.color = (1, 1, 1);
            label.glowAlpha = 0;
            number.glowAlpha = 0;
        }

        if (timeLeft > totalTime - 5 && label.alpha < 1)
        {
            label fadeOverTime(0.4);
            label.alpha = 1;
        }
        else if (timeLeft <= totalTime - 5 && timeLeft > notifyAt && label.alpha > 0)
        {
            label fadeOverTime(0.4);
            label.alpha = 0;
        }
        else if (timeLeft <= notifyAt && label.alpha < 1)
        {
            label fadeOverTime(0.4);
            label.alpha = 1;
        }

        if (timeLeft <= notifyAt)
        {
            foreach (player in level.players)
                if (isDefined(player) && isAlive(player))
                    player playLocalSound("mp_defcon_text_slide");
        }
        if (timeLeft == notifyAt)
            debugPrintLoadout(level.nextLoadout, true);

        wait 1;
    }

    if (isDefined(label)) label destroy();
    if (isDefined(number)) number destroy();

    foreach (player in level.players)
        if (isDefined(player) && isAlive(player))
            player playLocalSound("mp_ingame_summary");
}



updatePerkIcons(loadout)
{
    self endon("disconnect");

    // Destroy any old icons first
    if (isDefined(self.perkIconHuds))
    {
        for (i = 0; i < self.perkIconHuds.size; i++)
            if (isDefined(self.perkIconHuds[i]))
                self.perkIconHuds[i] destroy();
    }
    self.perkIconHuds = [];

    perksMode = getDvarInt("rando_perks_mode");
    if (perksMode == 0) return; // no perks = no icons

    perkList = [];

    // === PERK 3 (top) ===
    if (isDefined(loadout.perk3Pro))
    {
        if (loadout.perk3Pro == "specialty_falldamage") perkList[0] = "specialty_commando_upgrade";
        else if (loadout.perk3Pro == "specialty_holdbreath") perkList[0] = "specialty_steadyaim_upgrade";
        else if (loadout.perk3Pro == "specialty_delaymine") perkList[0] = "specialty_localjammer_upgrade";
        else if (loadout.perk3Pro == "specialty_quieter") perkList[0] = "specialty_quieter_upgrade";
        else if (loadout.perk3Pro == "specialty_selectivehearing") perkList[0] = "specialty_bombsquad_upgrade";
        else if (loadout.perk3Pro == "specialty_laststandoffhand") perkList[0] = "specialty_pistoldeath_upgrade";
        else perkList[0] = loadout.perk3Pro;
    }
    else if (isDefined(loadout.perk3))
    {
        if (loadout.perk3 == "specialty_extendedmelee") perkList[0] = "specialty_commando";
        else if (loadout.perk3 == "specialty_bulletaccuracy") perkList[0] = "specialty_steadyaim";
        else if (loadout.perk3 == "specialty_heartbreaker") perkList[0] = "specialty_quieter";
        else if (loadout.perk3 == "specialty_detectexplosive") perkList[0] = "specialty_bombsquad";
        else perkList[0] = loadout.perk3;
    }

    // === PERK 2 ===
    if (isDefined(loadout.perk2Pro))
    {
        if (loadout.perk2Pro == "specialty_armorpiercing") perkList[1] = "specialty_bulletdamage_upgrade";
        else if (loadout.perk2Pro == "specialty_fastsprintrecovery") perkList[1] = "specialty_lightweight_upgrade";
        else if (loadout.perk2Pro == "specialty_rollover") perkList[1] = "specialty_hardline_upgrade";
        else if (loadout.perk2Pro == "specialty_spygame") perkList[1] = "specialty_coldblooded_upgrade";
        else if (loadout.perk2Pro == "specialty_dangerclose") perkList[1] = "specialty_dangerclose_upgrade";
        else perkList[1] = loadout.perk2Pro;
    }
    else if (isDefined(loadout.perk2))
    {
        if (loadout.perk2 == "specialty_explosivedamage") perkList[1] = "specialty_dangerclose";
        else perkList[1] = loadout.perk2;
    }

    // === PERK 1 ===
    if (isDefined(loadout.perk1Pro))
    {
        if (loadout.perk1Pro == "specialty_fastmantle") perkList[2] = "specialty_marathon_upgrade";
        else if (loadout.perk1Pro == "specialty_quickdraw") perkList[2] = "specialty_fastreload_upgrade";
        else if (loadout.perk1Pro == "specialty_extraammo") perkList[2] = "specialty_scavenger_upgrade";
        else if (loadout.perk1Pro == "specialty_secondarybling") perkList[2] = "specialty_bling_upgrade";
        else if (loadout.perk1Pro == "specialty_omaquickchange") perkList[2] = "specialty_onemanarmy_upgrade";
        else perkList[2] = loadout.perk1Pro;
    }
    else if (isDefined(loadout.perk1))
    {
        if (loadout.perk1 == "specialty_fastmantle") perkList[2] = "specialty_marathon";
        else perkList[2] = loadout.perk1;
    }

    // === PERK 4 (bottom) ===
    if (isDefined(loadout.perk4))
    {
        if (loadout.perk4 == "specialty_combathigh") perkList[3] = "specialty_painkiller";
        else perkList[3] = loadout.perk4;
    }

    baseY = -56;
    for (i = 0; i < 4; i++)
    {
        if (!isDefined(perkList[i])) continue;

        icon = newClientHudElem(self);
        icon.hidewheninmenu = true;
        icon.alignX = "right";
        icon.alignY = "bottom";
        icon.horzAlign = "right";
        icon.vertAlign = "bottom";
        icon.x = -26;
        icon.y = baseY - (i * 38);
        icon.sort = 1;
        icon.alpha = 1.0;
        icon setShader(perkList[i], 32, 32);

        self.perkIconHuds[self.perkIconHuds.size] = icon;
    }

    self thread watchPerkIconsForRoundEnd();
    self thread watchPerkIconsForGameEnd();
}
watchPerkIconsForRoundEnd()
{
    self endon("disconnect");
    level waittill("round_ended");
    self destroyPerkIcons();
}
watchPerkIconsForGameEnd()
{
    self endon("disconnect");
    level waittill("game_ended");
    self destroyPerkIcons();
}
destroyPerkIcons()
{
    if (isDefined(self.perkIconHuds))
    {
        for (i = 0; i < self.perkIconHuds.size; i++)
        {
            if (isDefined(self.perkIconHuds[i]))
                self.perkIconHuds[i] destroy();
        }
        self.perkIconHuds = undefined; // clean reference
    }
}
