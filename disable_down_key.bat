@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 0000000000000000020000005000000000000000 /f
echo Registry key added to disable the DOWN arrow key.
pause
