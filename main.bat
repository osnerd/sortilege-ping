@echo off
cls
chcp 65001 >nul
color 4
goto banner

:banner
cls
echo.
echo                ███████╗ ██████╗ ██████╗ ████████╗██╗██╗     ███████╗ ██████╗ ███████╗
echo                ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝██║██║     ██╔════╝██╔════╝ ██╔════╝
echo                ███████╗██║   ██║██████╔╝   ██║   ██║██║     █████╗  ██║  ███╗█████╗  
echo                ╚════██║██║   ██║██╔══██╗   ██║   ██║██║     ██╔══╝  ██║   ██║██╔══╝  
echo                ███████║╚██████╔╝██║  ██║   ██║   ██║███████╗███████╗╚██████╔╝███████╗
echo                ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝
echo.
echo                 01 Ping Test                             11 Admin Check
echo                 02 Raw Ping (ICMP Echo)                  12 Admin PS [POWERSHELL]
echo                 03 RAW-Flood Bot                         13 Browser Info [IMPORTANTINFO]
echo                 04 Telnet Test                           14 Ip Config
echo                 05 Port Scan                             
echo                 06 Traceroute                         
echo                 07 Netstat (Active Connections)       
echo                 08 DNS Lookup                         
echo                 09 UDP Flood                          
echo                 10 TCP Connect Test                   
echo.
set /p choice=          $ 
if "%choice%"=="1" goto ping_test
if "%choice%"=="2" goto raw_ping_test
if "%choice%"=="3" goto ddos_simulation
if "%choice%"=="4" goto telnet_test
if "%choice%"=="5" goto port_scan
if "%choice%"=="6" goto traceroute
if "%choice%"=="7" goto netstat_test
if "%choice%"=="8" goto dns_lookup
if "%choice%"=="9" goto udp_flood
if "%choice%"=="11" goto admin_check
if "%choice%"=="12" goto admin_powershell
if "%choice%"=="13" goto browser
if "%choice%"=="13" goto ipconfigg

:ipconfigg
ipconfig

:browser
cls
echo.
echo               ███████╗ ██████╗ ██████╗ ████████╗██╗██╗     ███████╗ ██████╗ ███████╗
echo               ██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝██║██║     ██╔════╝██╔════╝ ██╔════╝
echo               ███████╗██║   ██║██████╔╝   ██║   ██║██║     █████╗  ██║  ███╗█████╗  
echo               ╚════██║██║   ██║██╔══██╗   ██║   ██║██║     ██╔══╝  ██║   ██║██╔══╝  
echo               ███████║╚██████╔╝██║  ██║   ██║   ██║███████╗███████╗╚██████╔╝███████╗
echo               ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝
echo.
echo                  1 Google Chrome
echo                  2 Mozilla Firefox
echo                  3 Microsoft Edge
echo                  4 Opera
echo                  5 Exit
echo.
set /p choice=Select browser (1-5): 

if "%choice%"=="1" goto chrome
if "%choice%"=="2" goto firefox
if "%choice%"=="3" goto edge
if "%choice%"=="4" goto opera
if "%choice%"=="5" exit

:chrome
start explorer "%LocalAppData%\Google\Chrome\User Data"
goto banner

:firefox
start explorer "%AppData%\Mozilla\Firefox\Profiles"
goto banner

:edge
start explorer "%LocalAppData%\Microsoft\Edge\User Data"
goto banner

:opera
start explorer "%AppData%\Roaming\Opera Software\Opera Stable"
goto banner

:virus_check
cd C:\\ProgramData\\Microsoft\\Windows Defender\\Platform\\4.18* || goto error
MpCmdRun -Scan -ScanType 1 || goto error
goto results

:admin_check
openfiles > nul 2>&1
if %ErrorLevel% equ 0 (
   echo Running As Administrator
) else (
   echo Not Running As Administrator
)
pause

:admin_powershell
color 7
cls
powershell

:ping_test
cls
set /p target=Enter target IP: 
set /p timeout=Enter timeout (seconds): 
echo Pinging %target% with a timeout of %timeout% seconds...
ping -n 1 -w %timeout% %target%
pause
goto banner

:raw_ping_test
cls
set /p target=Enter target IP: 
set /p timeout=Enter timeout (ms): 
echo Sending raw ping (ICMP Echo) to %target% with timeout %timeout% ms...
ping -n 1 -w %timeout% %target%
pause
goto banner

:flood
cls
set /p target=Enter target IP: 
set /p count=Enter number of pings for flood simulation: 
set /p timeout=Enter timeout (ms): 
ping -w %timeout% %target%

:ddos_loop
ping -n 1 -w %timeout% %target% >nul
set /a count=%count%-1
if %count% gtr 0 goto ddos_loop
echo DDoS flood simulation completed.
pause
goto banner

:telnet_test
cls
set /p target=Enter target IP: 
set /p port=Enter port: 
echo Testing Telnet to %target% on port %port%...
telnet %target% %port%
pause
goto banner

:port_scan
cls
set /p target=Enter target IP: 
set /p start_port=Enter start port: 
set /p end_port=Enter end port: 
echo Scanning ports from %start_port% to %end_port% on %target%...

for /L %%i in (%start_port%,1,%end_port%) do (
    echo Checking port %%i...
    echo > nul | telnet %target% %%i
    if errorlevel 1 (
        echo Port %%i is closed.
    ) else (
        echo Port %%i is open.
    )
)
pause
goto banner

:traceroute
cls
set /p target=Enter target IP or domain: 
echo Tracing route to %target%...
tracert %target%
pause
goto banner

:netstat_test
cls
echo Displaying active network connections...
netstat -an
pause
goto banner

:dns_lookup
cls
set /p target=Enter domain name: 
echo Performing DNS lookup for %target%...
nslookup %target%
pause
goto banner

:udp_flood
cls
set /p target=Enter target IP: 
set /p port=Enter target UDP port: 
set /p count=Enter number of UDP packets: 
echo Starting UDP flood on %target%:%port% with %count% packets...

for /L %%i in (1,1,%count%) do (
    echo Sending UDP packet to %target%:%port%...
    echo | set /p="x" >nul
    echo > nul | telnet %target% %port%
)
echo UDP flood simulation completed.
pause
goto banner

:tcp_connect
cls
set /p target=Enter target IP: 
set /p port=Enter target port: 
echo Testing TCP connection to %target% on port %port%...
echo >nul | telnet %target% %port%
pause
goto banner
