@echo off
:: Habilitar expansión retardada para que el errorlevel se actualice dentro del FOR
setlocal enabledelayedexpansion

:: Solicitar permisos de administrador automáticamente
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )



:: --- INICIO DEL SCRIPT ---
call :visual_styled
call :show_banner
:: validation red
call :validation_red
:: about pc 
call :show_about_pc

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

    :: Tu sistema de elección (Sigue igual)
    choice /c SC /n /t 5 /d S /m "[C] Saltar instalacion de %%a? (5s):"
    
    if errorlevel 2 (
        echo     [SALTADO] Se ha omitido %%a.
    ) else (
        echo [i] Instalando %%a...
        winget install --id %%a -e --silent --accept-source-agreements --accept-package-agreements --no-upgrade >nul
        
        :: CAMBIO IMPORTANTE: Usamos !errorlevel! en lugar de %errorlevel%
        if !errorlevel! equ 0 (
            echo     [OK]
        ) else (
            echo     [ERROR / YA EXISTE]
        )
    )
    echo ---------------------------------------------------
)

call :show_banner_exito
pause
exit /B


:: --- SECCION DE FUNCIONES ---
:visual_styled
:: Tittle o nombre de la ventana
:: cambio de estilo visual
title Jchock93 Auto-Installer
color 0B
goto :eof

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
:: --- VALIDACIÓN DE RED ---
:validation_red
echo [i] Verificando conexion a internet...
:: Usamos la sintaxis clásica de IF ERRORLEVEL que es la más estable
ping -n 1 8.8.8.8 >nul 2>&1

if errorlevel 1 (
    echo.
    echo [!] ERROR: No se pudo contactar con 8.8.8.8
    echo [i] Revisa tu cable de red o conexion Wi-Fi.
    pause
    exit /B
)
:: --- OBTENER IP (Método Infalible) ---
:: Buscamos el texto "IPv4" y extraemos el valor después de los ":"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    set "temp_ip=%%a"
)
:: Quitamos el espacio inicial que siempre deja ipconfig
set "mi_ip=%temp_ip:~1%"

echo [+] Conexion establecida.
echo.
:: Actualizamos el titulo para que siempre la veas arriba
title Jchock93 Auto-Installer - IP: %mi_ip%
timeout /t 2 >nul
goto :eof

::-- About this PC --
:show_about_pc
echo ===================================================
echo [i] INFORMACION DEL SISTEMA:
echo ---------------------------------------------------
echo [+] Nombre del Equipo: %COMPUTERNAME%
echo [+] Usuario Actual  : %USERNAME%

:: Obtener Modelo (usando el metodo rapido de una linea)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get model /value ^| find "="') do set "pc_modelo=%%a"
echo [+] Modelo de PC    : %pc_modelo%

:: Mostrar la IP que obtuvimos antes
echo [+] Direccion IP    : %mi_ip%
echo ===================================================
timeout /t 2 >nul
echo.
goto :eof


