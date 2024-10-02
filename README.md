# MeowMake

MeowMake is a simple build system for C/C++ projects. It is designed to be easy to use and easy to understand. It is written in Rust and is cross-platform.

## Installation
Prerequisites:
- Rust and Cargo
- Git
- Administrator privileges

Linux/macOS:
```bash
cd ~
mkdir -p .meowmake
cd .meowmake
git clone https://github.com/Thoq-jar/MeowMake.git
cd MeowMake
cargo build --release
sudo cp target/release/MeowMake /usr/local/bin/meowmake
cd ..
cd ..
rm -rf .meowmake
```

Windows:
```cmd
cd %USERPROFILE%
mkdir .meowmake
cd .meowmake
git clone https://github.com/Thoq-jar/MeowMake.git
cd MeowMake
cargo build --release
copy target\release\meowmake.exe %USERPROFILE%\AppData\Local\Microsoft\WindowsApps
cd ..
cd ..
rmdir /s /q .meowmake
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
