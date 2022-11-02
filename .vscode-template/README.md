This folder is here to help you set up your VSCode dev environment. 

-  Make a copy of this folder and rename it from `.vscode-template` to `.vscode`. Please don't delete/rename this template folder.
- In `.vscode`, update `sdkPath` in `launch.json` to the path of your Playdate SDK CoreLibs folder
- In `.vscode`, update `Lua.workspace.library` in `settings.json` to the path of your Playdate SDK CoreLibs folder
- Install the `Playdate` VSCode extension: https://marketplace.visualstudio.com/items?itemName=Orta.playdate

You should now be able to press f5 to build the project and run the simulator! :) 