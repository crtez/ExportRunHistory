# ExportRunHistory
Export your entire Hades run history to JSON.

## Installation

0. This mod requires [Magic's Mod Importer](https://www.nexusmods.com/hades/mods/26/) and [ModUtil](https://www.nexusmods.com/hades/mods/27). Make sure you have both installed prior to installing this mod.

1. Unzip the folder `ExportRunHistory` from the downloaded archive into the `\Hades\Content\Mods` folder.

2. Run modimporter.py from [Magic's Mod Importer](https://www.nexusmods.com/hades/mods/26/).

3. Run the 32-bit verison of `Hades.exe` from either `C:\Program Files\Epic Games\Hades\x86` (Epic) or `C:\Steam\steamapps\common\Hades\x86` (Steam).

4. Once you load into your save, your run history will appear as an `output.json` file in the ExportRunHistory folder.


## "Alright so I have my JSON file...what's next?"

You can use [this wonderful formatter](https://jsonformatter.org/) to get a prettier version of your `output.json`.

Try using the [pandas](https://pandas.pydata.org/) data analysis library in Python and Jupyter Notebook to garner interesting insights about your data, like average run time, outliers, and more!

The [test_analysis.ipynb](https://github.com/crtez/ExportRunHistory/blob/trunk/test/test_analysis.ipynb) file in this repository is a good example of what you can do with your data.


## Important Notes
Boons will appear as "ZeusBonusBounceTrait" or "SpeedDamageTrait" and so on. 
These may be confusing, so use the localizations file `CodexText.en.sjson` at `C:\Program Files\Epic Games\Hades\Content\Game\Text\en\` (could be different if you're playing Hades in a language other than English) or the equivalent for Steam in order to translate them to their "real" names.

- For example, in `CodexText.en.sjson`, "ZeusBonusBounceTrait" corresponds to "Storm Lightning" and "SpeedDamageTrait" corresponds to "Rush Delivery".

If you're curious about the conditions needed to achieve clear messages such as "ClearTimeVeryFast" ("Hermes would be Jealous"), you can find all of those in the `RunClearMessageData.lua` file located in `C:\Program Files\Epic Games\Hades\Content\Scripts\` or the Steam equivalent.

As far as I know, there is no way to identify the rarity of a boon—so if anyone knows a way, please let me know or submit a pull request! :)
