# git-multipull
🚥 Script to pull multiple repositories at once. Version for maOS/Linux and Windows (using [CMDer](https://cmder.app/)).

## macOS/Linux

1. Copy `git-multipull.sh` whenever you want (exemple: `~/scripts/)
2. Make it executable:
   ```
   chmod +x ~/scripts/git-multipull.sh
   ```
3. Add an alias to execute the script. For example, in ~/.bash_profile:
   ```
   alias git:multipull="~/scripts/git-multipull.sh"
   ```
4. Reload your command shell, then go in your main folder where all your repositories are stored, and execute the command:
   ```
   git:multipull
   ```

## Windows

1. Copy `git-multipull.bat` whenever you want (exemple: `C:\cmder\scripts\`)
2. Add an alias in CMDer config file (Typically, `C:\cmder\config\user-aliases.cmd`):
   ```
   alias git:multipull=C:\cmder\scripts\git-multipull.bat
   ```
3. Reload CMDer. Then go in your main folder where all your repositories are stored, and execute the command:
   ```
   git:multipull
   ```
