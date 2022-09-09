
# Development

## Getting Started

Make sure to recurse submodules to include project dependencies.  

`git clone <this-repo> --recurse-submodules`

or

`git clone <this-repo>`
`git submodule update --init`

## Running Game Simulator

TODO docs

## Project Structure

- `./source/main.lua`: main entry file of the game
- `./source/assets/`: all static assets
- `./source/assets/launcher/`: special assets for game launch experience
- `./source/libraries/`: third party [dependencies](#dependencies)
- `./source/scenes/`: Game scenes, descended from [NobleScene](https://noblerobot.github.io/NobleEngine/classes/NobleScene.html)

## 3rd Party Dependencies

- `noble`: https://github.com/NobleRobot/NobleEngine
- (still investigating usefulness, maybe) https://github.com/kyleconroy/lua-state-machine 

