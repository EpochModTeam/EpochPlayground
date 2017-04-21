/*
	Epoch Mod Survival Gamemode

	Author: Epoch Mod Team - EpochMod.com

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/release/Sources/epoch_config/config.hpp
*/

author = "Epoch Mod Team";
class Header
{
 gameType = Survive;
 minPlayers = 1;
 maxPlayers = 200;
};
respawn = "BASE";
respawnDelay = 600;
respawnDialog = 0;
respawnButton = 0;
respawnOnStart = -1;
onPauseScript = "epoch_code\gui\scripts\Epoch_onPause.sqf";
onLoadMission= "Epoch";
OnLoadIntro = "Welcome to Epoch Mod";
loadScreen = "\x\addons\a3_epoch_assets\pictures\loadScreen_ca.paa";
OnLoadIntroTime = 0;
OnLoadMissionTime = 0;
onLoadName = "Epoch Mod";
disabledAI = 1;
scriptedPlayer = 1;
disableChannels[]={{0,true,true},{1,false,true},{2,true,true},{6,true,true}}; // allow text only on side chat
enableItemsDropping = 0;
briefing = 0;
debriefing = 0;
enableDebugConsole = 0;
joinUnassigned = 0;
forceRotorLibSimulation = 1;
saving = 0;

corpseManagerMode = 1;
corpseLimit = 10;
corpseRemovalMinTime = 1200;
corpseRemovalMaxTime = 3600;

wreckManagerMode = 1;
wreckLimit = 2;
wreckRemovalMinTime = 60;
wreckRemovalMaxTime = 360;

ReviveMode = 2;                         //0: disabled, 1: enabled, 2: controlled by player attributes
ReviveUnconsciousStateMode = 0;         //0: basic, 1: advanced, 2: realistic
ReviveRequiredTrait = 0;                //0: none, 1: medic trait is required
ReviveRequiredItems = 2;                //0: none, 1: medkit, 2: medkit or first aid kit
ReviveRequiredItemsFakConsumed = 1;     //0: first aid kit is not consumed upon revive, 1: first aid kit is consumed
ReviveDelay = 6;                        //time needed to revive someone (in secs)
ReviveMedicSpeedMultiplier = 2;         //speed multiplier for revive performed by medic
ReviveForceRespawnDelay = 3;            //time needed to perform force respawn (in secs)
ReviveBleedOutDelay = 120;              //unconscious state duration (in secs)

disableRandomization[] = {"All"};

#include "Configs\CfgServicePoint.hpp"
#include "Configs\CfgItemSort.hpp"
#include "Configs\CfgTraderMissions.hpp"
#include "Configs\CfgMissions.hpp"
#include "Configs\CfgMissionsTasks.hpp"
#include "Configs\cfgCrafting.hpp"
#include "Configs\cfgPricing.hpp"
#include "Configs\CfgDynamicHUD.hpp"

#include "Configs\CfgEpochClient.hpp"

#include "Configs\CfgMasterLoop.hpp"
#include "Configs\CfgBaseBuilding.hpp"
#include "Configs\CfgSnapChecks.hpp"
#include "Configs\CfgBuildingLootPos.hpp"
#include "Configs\CfgActionMenu\CfgActionMenu_core.hpp"
#include "Configs\CfgEpochConfiguration.hpp"
#include "Configs\CfgClientFunctions.hpp"
#include "Configs\CfgObjectInteractions.hpp"
#include "Configs\CfgItemInteractions.hpp"
#include "Configs\CfgSay3Dhandler.hpp"
#include "Configs\CfgSwitchMovehandler.hpp"

// A3 specific configs
#include "Configs\CfgFunctions.hpp"
#include "Configs\CfgRemoteExec.hpp"

class CfgEpochBuild
{
 	#include "build.hpp"
};
