# Resumen del Clúster
_Actualizado: 2026-05-19 21:21_

## ordenador1 — Estado de contenedores
VMID       Status     Lock         Name                
100        running                 vscode-server       
101        running                 n8n                 
103        running                 zrok                
104        running                 postgresql          

## ordenador1 — Almacenamiento
Name             Type     Status     Total (KiB)      Used (KiB) Available (KiB)        %
HHDD          zfspool   disabled               0               0               0      N/A
NFS_ord2          nfs     active       938764288          631808       938132480    0.07%
local             dir     active        86999080        10913628        71620200   12.54%
local-lvm     lvmthin     active       195833856        21150056       174683799   10.80%

## ordenador2 — Estado de contenedores
VMID       Status     Lock         Name                
102        stopped                 openclaw            
105        running                 picoclaw            
200        running                 ollama              

## ordenador2 — Almacenamiento
Name             Type     Status     Total (KiB)      Used (KiB) Available (KiB)        %
HHDD          zfspool     active       942931968         4800224       938131744    0.51%
NFS_ord2          nfs   inactive               0               0               0    0.00%
local             dir     active        98497780        16893064        76555168   17.15%
local-lvm     lvmthin     active       354275328        44815828       309459499   12.65%
