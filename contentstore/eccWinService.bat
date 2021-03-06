@echo off
REM   The contents of this file are subject to the Mozilla Public License
REM   Version 1.1 (the "License"); you may not use this file except in
REM   compliance with the License. You may obtain a copy of the License at
REM   http://www.mozilla.org/MPL/
REM
REM   Software distributed under the License is distributed on an "AS IS"
REM   basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
REM   License for the specific language governing rights and limitations
REM   under the License.
REM
REM   The Original Code is RabbitMQ.
REM
REM   The Initial Developers of the Original Code are LShift Ltd,
REM   Cohesive Financial Technologies LLC, and Rabbit Technologies Ltd.
REM
REM   Portions created before 22-Nov-2008 00:00:00 GMT by LShift Ltd,
REM   Cohesive Financial Technologies LLC, or Rabbit Technologies Ltd
REM   are Copyright (C) 2007-2008 LShift Ltd, Cohesive Financial
REM   Technologies LLC, and Rabbit Technologies Ltd.
REM
REM   Portions created by LShift Ltd are Copyright (C) 2007-2009 LShift
REM   Ltd. Portions created by Cohesive Financial Technologies LLC are
REM   Copyright (C) 2007-2009 Cohesive Financial Technologies
REM   LLC. Portions created by Rabbit Technologies Ltd are Copyright
REM   (C) 2007-2009 Rabbit Technologies Ltd.
REM
REM   All Rights Reserved.
REM
REM   Contributor(s): ______________________________________.
REM

rem 这是EMS管理端服务名
set EMSPro_SERVICENAME=EMSPro_Content

rem 这是EMS管理端根目录
if "%EMSPro_Content%"=="" (
    set EMSPro_Content=%APPDATA%\%EMSPro_SERVICENAME%
 )

rem 这是EMS管理节点名
set EMSPro_NODENAME=db

rem 这是Erlang命令目录
if "%ERLANG_SERVICE_MANAGER_PATH%"=="" (
    set ERLANG_SERVICE_MANAGER_PATH=C:\Program Files\erl5.7.4\erts-5.7.4\bin
)

echo %EMSPro_SERVICENAME%
echo %EMSPro_Content%
echo %EMSPro_NODENAME%
echo %ERLANG_SERVICE_MANAGER_PATH%


rem *** End of configuration ***

if not exist "%ERLANG_SERVICE_MANAGER_PATH%\erlsrv.exe" (
    echo.
    echo **********************************************
    echo ERLANG_SERVICE_MANAGER_PATH not set correctly. 
    echo **********************************************
    echo.
    echo %ERLANG_SERVICE_MANAGER_PATH%\erlsrv.exe not found!
    echo Please set ERLANG_SERVICE_MANAGER_PATH to the folder containing "erlsrv.exe".
    echo.
    exit /B 1
)


if "%1" == "install" goto INSTALL_SERVICE
for %%i in (start stop disable enable list remove) do if "%%i" == "%1" goto MODIFY_SERVICE 

echo.
echo *********************
echo Service control usage
echo *********************
echo.
echo %~n0 help    - Display this help
echo %~n0 install - Install the %EMSPro_SERVICENAME% service
echo %~n0 remove  - Remove the %EMSPro_SERVICENAME% service
echo.
echo The following actions can also be accomplished by using 
echo Windows Services Management Console (services.msc):
echo.
echo %~n0 start   - Start the %EMSPro_SERVICENAME% service
echo %~n0 stop    - Stop the %EMSPro_SERVICENAME% service
echo %~n0 disable - Disable the %EMSPro_SERVICENAME% service
echo %~n0 enable  - Enable the %EMSPro_SERVICENAME% service
echo.
exit /B


:INSTALL_SERVICE

if not exist "%EMSPro_Content%" (
    echo Creating base directory %EMSPro_Content% & md "%EMSPro_Content%" 
)

"%ERLANG_SERVICE_MANAGER_PATH%\erlsrv" list %EMSPro_SERVICENAME% 2>NUL 1>NUL
if errorlevel 1 (
    "%ERLANG_SERVICE_MANAGER_PATH%\erlsrv" add %EMSPro_SERVICENAME%
) else (
    echo %EMSPro_SERVICENAME% service is already present - only updating service parameters
)


set ERLANG_SERVICE_ARGUMENTS=+P 102400 -setcookie 3ren -mnesia dir '"./db"' -pa \ebin\ -boot start_sasl -s content_store


rem set ERLANG_SERVICE_ARGUMENTS=%ERLANG_SERVICE_ARGUMENTS:\=\\%
rem set ERLANG_SERVICE_ARGUMENTS=%ERLANG_SERVICE_ARGUMENTS:"=\"%

echo %ERLANG_SERVICE_ARGUMENTS%

"%ERLANG_SERVICE_MANAGER_PATH%\erlsrv" set %EMSPro_SERVICENAME% ^
-machine "%ERLANG_SERVICE_MANAGER_PATH%\erl.exe" ^
-env ERL_CRASH_DUMP="%EMSPro_Content%" ^
-workdir "%EMSPro_Content%" ^
-sname %EMSPro_NODENAME% ^
-c "EMS Pro" ^
-ar "%ERLANG_SERVICE_ARGUMENTS%" > NUL
goto END


:MODIFY_SERVICE

"%ERLANG_SERVICE_MANAGER_PATH%\erlsrv" %1 %EMSPro_SERVICENAME%
goto END


:END