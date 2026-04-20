# 🚀 Jchock93 Auto-Installer (v1.0)

## Fecha de ultima actualizacion

    04/20/2026 11:32 AM

Este es un script de automatización basado en **Batch** diseñado para agilizar la configuración de entornos Windows post-formateo. Utiliza el administrador de paquetes oficial de Microsoft, **Winget**, para instalar software de forma desatendida y silenciosa. El objetivo que fue creado este scrip es para facilitar primeramente la instalacion de programas de manera automatica, ayudando a los ingenieros y agilizando tiempos

## 🛠️ Características

* **Elevación de Privilegios:** Solicita automáticamente permisos de administrador si no se están ejecutando.
* **Instalación Silenciosa:** Utiliza flags `--silent` para evitar ventanas de confirmación molestas.
* **Sistema de Confirmación:** Antes de cada instalación, el script otorga un margen de **5 segundos**. Puedes presionar `C` para saltar esa aplicación específica o dejar que continúe automáticamente.
* **Banner Personalizado:** Interfaz visual limpia en la terminal con colores y arte ASCII.

## 📦 Software Incluido

El script procesa actualmente las siguientes aplicaciones:
* 🌐 Google Chrome & Brave Browser
* 📚 WinRAR
* 🎬 VLC Media Player
* 🌍 Google Earth Pro
* 🖥️ RustDesk (Control remoto)
* 🛡️ WireGuard (VPN)

## 🚀 Uso

1.  Descarga el archivo `.bat`.
2.  Haz doble clic en el archivo (el script solicitará permisos de administrador).
3.  Presiona **ENTER** para comenzar.
4.  Observa el progreso o presiona `C` si decides no instalar alguna de las apps de la lista.

## ⚠️ Requisitos

* **Windows 10 (1709 o superior) o Windows 11.**
* **App Installer (Winget):** Normalmente viene preinstalado, pero si falla, asegúrate de tenerlo actualizado desde la Microsoft Store.
* **Conexión a Internet.**

---
*Desarrollado por jesus Arechider (Jchock93) - Ingeniero Electricista & IT Support & Entusiasta de la automatizacion y agilizacion de tiempso y procesos.*