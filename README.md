# ExportRunHistory
Export your entire Hades run history to JSON. Only works on the 32-bit version!

## Installation

In order to export your run history, you must run "Hades.exe" from either "C:\Program Files\Epic Games\Hades\x86" (Epic) or C:\Steam\steamapps\common\Hades\x86" (Steam).

Once you load into game, your run history will appear in a "output.json" file in the same directory as the "ExportRunHistory.lua" script.


## Important Notes
Note: Boons will appear as "ZeusBonusBounceTrait" or "SpeedDamageTrait" and so on. 
These may be confusing, so use the localizations file at "C:\Program Files\Epic Games\Hades\Content\Game\Text\en\CodexText.en.sjson" or the equivalent for Steam in order to translate them to their "real" names.

For example, in the "CodexText.en.sjson" file, "ZeusBonusBounceTrait" corresponds to "Storm Lightning" and "SpeedDamageTrait" corresponds to "Rush Delivery".

If you're curious about the conditions needed to achieve clear messages such as "ClearTimeVeryFast" ("Hermes would be Jealous"), you can find all of those in the "RunClearMessageData.lua" file located in "C:\Program Files\Epic Games\Hades\Content\Scripts\" or the Steam equivalent.
