
#!/usr/bin/env bash

# Arquitectura de Computadores - Unidad 5
# Parte 2 - VirtualBox
# Estudiante: William Felipe Villamizar Soler
# Codigo: 1152498
# Registro de comandos del laboratorio

# Paso 1: Creacion de VM
VBoxManage createvm --name "Lab5-Alpine" --ostype "Linux_64" --register
VBoxManage modifyvm "Lab5-Alpine" --memory 1024 --vram 16 --cpus 1 --nic1 nat

# Paso 2: Configuracion inicial
# Alpine Linux 3.19 instalado mediante setup-alpine

# Paso 3: Modos de red
VBoxManage modifyvm "Lab5-Alpine" --nic1 nat
VBoxManage list hostonlyifs
# El nombre del adaptador Host-Only depende del anfitrion
# VBoxManage modifyvm "Lab5-Alpine" --nic1 hostonly --hostonlyadapter1 "NOMBRE_ADAPTADOR"
# VBoxManage modifyvm "Lab5-Alpine" --nic1 bridged --bridgeadapter1 "NOMBRE_ADAPTADOR"
VBoxManage modifyvm "Lab5-Alpine" --nic1 nat

# Paso 4: Snapshots
VBoxManage snapshot "Lab5-Alpine" take "snap_base" --description "Alpine recien instalado"
# Instalacion dentro de Alpine: apk add curl wget nano htop
VBoxManage snapshot "Lab5-Alpine" take "snap_con_herramientas" --description "Alpine con herramientas adicionales"
VBoxManage snapshot "Lab5-Alpine" list
# Con la VM apagada:
VBoxManage snapshot "Lab5-Alpine" restore "snap_base"

# Paso 5: Recursos
VBoxManage showvminfo "Lab5-Alpine"
VBoxManage modifyvm "Lab5-Alpine" --cpus 2 --memory 2048

# Paso 6: Disco fijo
VBoxManage createmedium disk \
  --filename "Lab5-Alpine-fixed.vdi" \
  --size 4096 \
  --format VDI \
  --variant Fixed

VBoxManage storageattach "Lab5-Alpine" \
  --storagectl "SATA" \
  --port 1 \
  --device 0 \
  --type hdd \
  --medium "Lab5-Alpine-fixed.vdi"

# Benchmark dentro de Alpine:
# time dd if=/dev/zero of=/mnt/fijo/test.img bs=1M count=200
# time dd if=/dev/zero of=/root/test.img bs=1M count=200

# Paso 9: Exportacion OVA
VBoxManage export "Lab5-Alpine" \
  --output "Lab5-Alpine-export.ova" \
  --manifest

# Los comandos anteriores documentan las operaciones.
# No ejecutar este archivo completo sobre una VM ya creada.
