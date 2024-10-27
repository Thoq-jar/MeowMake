# MeowMake

MeowMake is a simple build system for C/C++ projects. It is designed to be easy to use and easy to understand.
It is written in Zig and is cross-platform.

## Syntax
```meowfile
purriler - compiler (eg. clang++)
purroject_files - files (eg. ["main.cc", "utils.cc"])
meoutput - name of exec (eg. my_app)
purriler_flags - compiler flags (eg. -Wall -O2 `wx-config --cxxflags`)
purrepends - libraries (eg. ["`wx-config --libs`"])
meocal_purrepends - local libraries (eg. ["-I./include", "-L./lib"])
```

## Installation
Prerequisites:
- Rust and Cargo
- Git
- Administrator privileges

Linux/macOS:
```bash
cd $HOME/
mkdir -p .meowmake
cd .meowmake/
git clone https://github.com/Thoq-jar/MeowMake.git .
git checkout -b master
git pull
zig build
mv zig-out/bin/meowmake $HOME/.meowmake/meowmake
rm -rf zig-out/
cd ..
export PATH="$HOME/.meowmake/:$PATH"
```

Windows:
```cmd
cd %USERPROFILE%
mkdir .meowmake
cd .meowmake
git clone https://github.com/Thoq-jar/MeowMake.git .
zig build
copy zig-out\bin\meowmake.exe %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
cd ..
```

## Updating
Linux/macOS:
```bash
cd $HOME/.meowmake
git pull
zig build
mv zig-out/bin/meowmake $HOME/.meowmake/meowmake
rm -rf zig-out/
cd $HOME/
export PATH="$HOME/.meowmake/:$PATH"
```

Windows:
```cmd
cd %USERPROFILE%/.meowmake
git pull
zig build
copy zig-out\bin\meowmake.exe %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
cd %USERPROFILE%
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
