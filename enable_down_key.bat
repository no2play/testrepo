@echo off
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /f
echo Registry key deleted to re-enable the DOWN arrow key.
pause
