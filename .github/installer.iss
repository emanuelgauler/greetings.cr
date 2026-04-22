; =============================================================================
; installer.iss — Script de Inno Setup para MyApp
; Reemplazá los valores marcados con ; TODO antes de usar.
; =============================================================================

; --- Constantes globales -----------------------------------------------------
; Definirlas acá en lugar de hardcodearlas en cada sección hace que el script
; sea fácil de mantener: cambiás un valor y se propaga a todo el archivo.

#define AppName      "Greetings"              ; TODO: nombre legible de tu app
#define AppVersion   "1.0.0"             ; TODO: versión actual
#define AppPublisher "kurupi.org"         ; TODO: tu nombre o el de tu organización
#define AppURL       "https://github.com/emanuelgauler/greetings.cr"  ; TODO: URL del proyecto
#define AppExeName   "greetings.exe"         ; TODO: nombre del .exe que genera Crystal

; =============================================================================
[Setup]
; --- Identidad de la aplicación ----------------------------------------------
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}

; Identificador único e inmutable para esta aplicación.
; Generá uno nuevo con Tools > Generate GUID en el IDE de Inno Setup,
; o con PowerShell: [guid]::NewGuid()
; IMPORTANTE: No lo cambies entre versiones, o Windows lo tratará como una app distinta.
AppId={{00000000-0000-0000-0000-000000000000}}  ; TODO: reemplazá con un GUID real

; --- Directorio de instalación -----------------------------------------------
; {autopf} es un comodín inteligente de Inno Setup:
;   - Si el usuario instala con privilegios de admin → C:\Program Files\MyApp
;   - Si instala sin admin (nuestro caso) → C:\Users\<usuario>\AppData\Local\Programs\MyApp
; Esto es correcto para apps de escritorio que no necesitan admin.
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}

; Habilita que el usuario cambie el directorio de instalación en el wizard.
DisableDirPage=no

; --- Privilegios -------------------------------------------------------------
; "lowest" significa que el instalador NO pide UAC (sin el escudo de admin).
; Es la opción correcta para apps que no escriben en ubicaciones del sistema.
PrivilegesRequired=lowest

; --- Compatibilidad con Windows ----------------------------------------------
; Declaramos soporte explícito para Windows 10 y 11 (64-bit).
; Esto afecta el manifiesto del instalador y evita advertencias del sistema.
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0

; --- Archivos de salida del instalador ---------------------------------------
; Inno Setup genera el .exe del instalador en esta carpeta.
; "Output\" es relativa al directorio donde esté este .iss.
OutputDir=Output
OutputBaseFilename={#AppName}-{#AppVersion}-windows-x64-setup

; Compresión LZMA2 es la mejor opción de Inno Setup: buena ratio y velocidad razonable.
Compression=lzma2
SolidCompression=yes

; Muestra el ícono de tu app en el instalador y en "Agregar o quitar programas".
; TODO: reemplazá con la ruta a tu .ico, o eliminá esta línea si no tenés ícono.
; SetupIconFile=assets\myapp.ico

; =============================================================================
[Languages]
; Podés agregar más idiomas. Inno Setup incluye traducciones para ~20 idiomas.
; La lista completa está en la carpeta "Languages\" de tu instalación de Inno Setup.
Name: "english"; MessagesFile: "compiler:Default.isl"
; Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

; =============================================================================
[Tasks]
; Las "tareas" son checkboxes opcionales que el usuario ve durante la instalación.
; Acá definimos el acceso directo en el escritorio como opcional (recomendado).
Name: "desktopicon"; \
  Description: "{cm:CreateDesktopIcon}"; \
  GroupDescription: "{cm:AdditionalIcons}"; \
  Flags: unchecked
; "unchecked" = desmarcado por defecto. El usuario puede marcarlo si quiere.
; Si preferís que esté marcado por defecto, simplemente quitá "unchecked".

; =============================================================================
[Files]
; Acá listás todos los archivos que el instalador debe copiar al sistema.
;
; Para tu app con Crystal + uing compilado estáticamente con MSVC, libui queda
; embebida en el .exe, así que solo necesitás copiar el ejecutable principal.
; No hay DLLs externas que distribuir — eso simplifica mucho el instalador.
;
; "Source" es relativa al directorio donde esté este .iss.
; "DestDir: {app}" significa "el directorio que eligió el usuario al instalar".

Source: "bin\{#AppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; TODO: Si tu app tiene archivos adicionales (imágenes, configuración, etc.),
; agregalos acá. Ejemplo:
; Source: "assets\*"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs

; =============================================================================
[Icons]
; Los íconos son los accesos directos que aparecen en el Menú Inicio y escritorio.

; Acceso directo en el Menú Inicio — siempre se crea.
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"

; Acceso directo en el escritorio — solo si el usuario marcó la tarea "desktopicon".
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

; =============================================================================
[Run]
; Pasos opcionales que se ejecutan al final de la instalación.
; Este ofrece al usuario lanzar la app inmediatamente al terminar el wizard.
Filename: "{app}\{#AppExeName}"; \
  Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; \
  Flags: nowait postinstall skipifsilent
