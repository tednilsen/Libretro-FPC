This is the Project Template Welcome for the Libretro-FPC package, and should contain the following files:

libretro-fpc-welcome
    __PROJNAME__.lpi
    __PROJNAME__.lpr
    __PROJNAME__.lps
    font_kong.inc
    libretro.inc
    project.ini
    readme.txt (you are reading me now)
    samples.inc

In order to use templates in Lazarus you need the "ProjTemplates" package installed in Lazarus, install it if you don't have it.
Let's say you run Windows and have a copy of Libretro-FPC in "F:\CoreFPC\libretro", in that folder you should have "include", "helpers", "templates" etc too.
Next go to "Tools" -> "Project templates options..." in Lazarus to know or set the templates folder, next copy the folder "libretro-fpc-template" located under "F:\CoreFPC\libretro\templates" into Lazarus templates folder.
Now you should be ready to go, restart Lazarus.

Here in the Windows template example I have RetroArch installed in the libretro source folder like this "F:\CoreFPC\libretro\RetroArch".
To create a new project in Lazarus, go to "File" -> "New project from template" -> "LibretroFPC Project Welcome" and fill in the form.

e.g. for Windows:
------------------------
* Name for new project:
libretro_welcome
* Create in directory:
F:\CoreFPC\libretro\libretro_welcome
* RATitle:
Welcome Libretro
* RADir:
F:\CoreFPC\libretro\RetroArch
* RAExe:
retroarch.exe
* RACore:
F:\CoreFPC\libretro\RetroArch\cores
* RACmd:
(blank)
* RAExt:
dll
*RASrc:
..\


e.g. for Linux RetroPie:
------------------------
* Name for new project:
libretro_welcome
* Create in directory:
/home/pi/Development/projects/corefpc/libretro/libretro_welcome
* RATitle:
Welcome Libretro
* RADir:
/opt/retropie/emulators/retroarch/bin
* RAExe:
retroarch
* RACore:
/opt/retropie/libretrocores/lr-fpc
* RACmd:
--config /opt/retropie/configs/all/retroarch.cfg
* RAExt:
so
*RASrc:
../

Restart Lazarus and reopen the project you just created... press run in Lazarus to see and hear what unfolds!
