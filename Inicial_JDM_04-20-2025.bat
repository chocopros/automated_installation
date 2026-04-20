este es mi bat: agrega lo que te pedi:

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

:: --- Proceso de Instalacion
:: Llamamos a la funcion de nuevo para que limpie y muestre el banner antes de instalar
call :mostrar_banner
echo [+] INSTALANDO SOFTWARE (Por favor, espera...)
echo ---------------------------------------------------

set apps=Google.Chrome Brave.Brave RARLab.WinRAR VideoLAN.VLC Google.EarthPro RustDesk.RustDesk WireGuard.WireGuard

for %%a in (%apps%) do (
    echo [i] Procesando %%a...
    winget install --id %%a -e --silent --accept-source-agreements --accept-package-agreements >nul
    if %errorlevel% equ 0 (echo     [OK]) else (echo     [SALTADO/ACTUALIZADO])
)

call show_banner_exito
pause


:: --- SECCION DE FUNCIONES PARA BANNERS ---

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
echo  #                 DEPLOYMENT SCRIPT v2.5                      #
echo  ###############################################################
echo.
goto :eof

:show_banner_exito
echo.
echo ---------------------------------------------------
echo [+] Jchock93: Proceso finalizado con exito.
echo ---------------------------------------------------
echo.
goto :eof

:: --- SECCION DE FUNCIONES ESPECIALES ---

:contador
echo ¿Deseas cancelar la instalacion de este programa?
echo [S] Continuar (o espera 5s)  |  [C] Cancelar y saltar
:: /T 5 espera 5 segundos. /D S elige 'S' por defecto.
choice /c SC /n /t 5 /d S /m "Selecciona una opcion (S/C):"
goto :eof
