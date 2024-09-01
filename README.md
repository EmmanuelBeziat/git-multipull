# git-multipull
🚥 Script to pull multiple repositories at once. Version for maOS/Linux and Windows (using [CMDer](https://cmder.app/) or Powershell).

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

### CMDer

1. Copy `git-multipull.bat` whenever you want (exemple: `C:\cmder\scripts\`)
2. Add an alias in CMDer config file (Typically, `C:\cmder\config\user-aliases.cmd`):
   ```
   alias git:multipull=C:\cmder\scripts\git-multipull.bat
   ```
3. Reload CMDer. Then go in your main folder where all your repositories are stored, and execute the command:
   ```
   git:multipull
   ```

### Powershell

1. Copy `git-multipull.ps1` in a folder that is already added to your PATH (or create a new PATH variable)
2. Add an alias in your Powershell profile:
   ```
   notepad $PROFILE
   Set-Alias git:multipull "C:\path\to\your\script\git-multipull.ps1"
   ```
3. Reload Powershell. Then go in your main folder where all your repositories are stored, and execute the command:
   ```
   git:multipull
   ```
