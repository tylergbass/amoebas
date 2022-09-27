
// Runs `./spritesheet.sh` in each pet folder. Could def do this in bash but I didn't want to learn something knew >:)
// Requires GraphicsMagick to be installed as `gm`

const baseDirPath = "source/assets/images/pets/";
for await (const dirEntry of Deno.readDir(baseDirPath)) {
  if (dirEntry.isDirectory) {
    await Deno.run({
      cmd: `gm convert *_spriteSheet.png +append ${dirEntry.name}-table-92-101.png`.split(
        " ",
      ),
      cwd: baseDirPath + dirEntry.name,
    }).status();
  }
}
