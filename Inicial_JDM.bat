@echo off
:: Solicitar permisos de administrador automáticamente
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title Jchock93 Auto-Installer
color 0B

:: --- INICIO DEL SCRIPT ---
call :show_banner
echo [!] El sistema esta listo para instalar tus aplicaciones.
echo [!] Presiona la tecla ENTER para comenzar...
pause >nul

:: --- Proceso de Instalacion ---
call :show_banner
echo [+] PREPARANDO ENTORNO...
:: Actualizar la base de datos de Winget
echo [i] Actualizando fuentes de Winget...
winget source update >nul 2>&1

:: Opcional: Actualizar el propio Winget (si hay una versión nueva disponible)
echo [i] Comprobando actualizaciones de Winget...
winget upgrade --id Microsoft.Winget -e --silent --accept-source-agreements >nul 2>&1
echo ---------------------------------------------------

:: -- Lista de Aplicaciones --
set "Navegadores=Google.Chrome Brave.Brave"
set "Utilidades=RARLab.WinRAR VideoLAN.VLC"
set "Mapas=Google.EarthPro"
set "Remoto=RustDesk.RustDesk WireGuard.WireGuard"

set "apps=%Navegadores% %Utilidades% %Mapas% %Remoto%"

:: --- BUCLE DE INSTALACION ---
for %%a in (%apps%) do (
    echo.
    echo [?] Proximo: %%a

    choice /c SC /n /t 5 /d S /m "Deseas instalar? [S] Si | [C] Saltar:"
    
    :: En tal caso de pasar algo
    if errorlevel 2 (
        echo     [SALTADO] Se ha omitido %%a.
    ) else (
        echo [i] Instalando %%a...
        winget install --id %%a -e --silent --accept-source-agreements --accept-package-agreements --no-upgrade >nul
        if %errorlevel% equ 0 (echo     [OK]) else (echo     [ERROR/EXISTE])
    )
    echo ---------------------------------------------------
)

call :show_banner_exito
pause
exit /B


:: --- SECCION DE FUNCIONES ---
:show_banner
cls
echo.
echo  ###############################################################
echo  #                                                             #
echo  #      #  ####  #    #  ####   ####  #    #  ####  #####      #
echo  #      # #    # #    # #    # #    # #   #  #    #     #      #
echo  #      # #      ###### #    # #      ####    ####   ###       #
echo  #      # #      #    # #    # #      #  #        #     #      #
echo  #      # #    # #    # #    # #    # #   #  #    # #   #      #
echo  #    ##   ####  #    #  ####   ####  #    #  ####   ###       #
echo  #                                                             #
echo  #               jesuschock93@gmail.com v1.0                   #
echo  ###############################################################
echo.
goto :eof

:show_banner_exito
echo.
echo ---------------------------------------------------
echo [+] Jchock93<<: Proceso finalizado con exito.
echo ---------------------------------------------------
echo.
goto :eof


:: --- SECCION DE FUNCIONES ESPECIALES ---
