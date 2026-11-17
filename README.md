@"
# Post-contenido Unidad 5 — Emuladores y Virtualización

**Asignatura:** Arquitectura de Computadores  
**Estudiante:** William Felipe Villamizar Soler  
**Código:** 1152498  
**Universidad:** Universidad Francisco de Paula Santander  
**Unidad:** 5

## Descripción

Este laboratorio aborda el uso de emuladores y máquinas virtuales mediante DOSBox y VirtualBox.

La primera parte consiste en configurar DOSBox para desarrollar, ensamblar y ejecutar programas en lenguaje ensamblador x86 utilizando NASM y DEBUG.

La segunda parte consiste en crear y administrar una máquina virtual con Alpine Linux mediante VirtualBox.

## Entorno de trabajo

- Sistema anfitrión: Windows 11
- Emulador: DOSBox
- Ensamblador: NASM
- Virtualizador: Oracle VirtualBox
- Control de versiones: Git y GitHub

## Estructura del proyecto

- src/: archivos fuente en ensamblador.
- bin/: archivos compilados.
- capturas/: evidencias del laboratorio.
- README.md: documentación técnica.

## Estado del laboratorio

Parte 1: En desarrollo.

Parte 2: Pendiente.
"@ | Set-Content README.md -Encoding UTF8



## Paso 7: Comparacion del efecto de cycles

| Corrida | cycles | Hora inicial | Hora final | Duracion (centesimas) |
|---------|--------|--------------|------------|----------------------|
| 1 | 8000 | 23:59:36:21 | 00:00:08:95 | 3274 |
| 2 | 1000 | 23:47:09:33 | 23:51:31:71 | 26238 |
| 3 | 20000 | 00:00:47:62 | 00:01:00:69 | 1307 |

### Analisis de resultados

Se realizaron tres mediciones con un numero fijo de iteraciones y diferentes valores de cycles en DOSBox.

Con cycles=1000, el programa tardo 262,38 segundos. Al aumentar a cycles=8000, la duracion disminuyo a 32,74 segundos. Finalmente, con cycles=20000, el tiempo se redujo a 13,07 segundos.

Los resultados demuestran que aumentar el valor de cycles incrementa la velocidad de ejecucion de las instrucciones emuladas, sin modificar el funcionamiento del programa.

El parametro cycles representa una configuracion de velocidad de emulacion y no corresponde directamente a la frecuencia fisica del procesador anfitrion.

## Paso 8: Decisión técnica — Selección del valor de cycles en DOSBox

Para el desarrollo del laboratorio se seleccionó `cycles=fixed 8000` como configuración principal, debido a que permite mantener una velocidad de emulación controlada y obtener mediciones reproducibles.

La opción `cycles=max` permite que DOSBox ejecute tantas instrucciones emuladas como pueda procesar el equipo anfitrión. En computadores modernos, esto puede hacer que el programa `ciclos.com` termine en un tiempo muy reducido, incluso cuando contiene millones de iteraciones. Esta situación desvirtúa el propósito del laboratorio, ya que la duración dependería principalmente de la capacidad del hardware utilizado y no de una velocidad de emulación previamente establecida.

Por otra parte, `cycles=auto` ajusta la velocidad según el comportamiento del programa, lo que puede introducir variaciones en las mediciones. Por esta razón, un valor fijo de 8000 resulta más apropiado para comparar resultados entre estudiantes, aunque pueden existir pequeñas diferencias relacionadas con el rendimiento de cada equipo.

Los resultados experimentales respaldan esta decisión: con 1000 cycles se registraron 262,38 segundos; con 8000 cycles, 32,74 segundos; y con 20000 cycles, 13,07 segundos.

Fuera del laboratorio, `cycles=max` puede ser conveniente para programas de productividad o aplicaciones de cálculo desarrolladas para DOS que necesitan ejecutar tareas rápidamente y no dependen de una temporización histórica. Asimismo, `cycles=auto` resulta útil para aplicaciones que requieren ajustes automáticos de rendimiento.

En conclusión, se determinó que `cycles=fixed 8000` proporciona un equilibrio adecuado entre velocidad, control de ejecución y reproducibilidad para las actividades del laboratorio.

## Paso 9: Decisión técnica — Tiempo emulado en DOSBox frente a ciclos reales de CPU

Durante el desarrollo del laboratorio se identificó que el parámetro `cycles` de DOSBox no representa directamente los ciclos de reloj físicos del procesador anfitrión. Este parámetro establece una velocidad de ejecución emulada, mientras que la frecuencia real del procesador se expresa en MHz o GHz y representa millones o miles de millones de ciclos físicos por segundo. Por lo tanto, comparar directamente `cycles=8000` con la frecuencia del procesador constituye un error conceptual, debido a que ambas magnitudes corresponden a mecanismos de ejecución diferentes.

Cada instrucción x86 de 16 bits ejecutada dentro de DOSBox necesita ser procesada mediante instrucciones nativas del sistema anfitrión. La cantidad de operaciones requeridas puede variar según la complejidad de la instrucción y el funcionamiento del emulador. En consecuencia, no existe una equivalencia directa entre un ciclo emulado y un ciclo físico del procesador.

Esto también implica que el uso real de CPU del proceso `DOSBox.exe` no puede determinarse únicamente a partir del valor configurado en `cycles`. Su consumo depende de factores como el rendimiento del procesador, la carga del sistema operativo y las tareas adicionales que realiza el emulador.

Para analizar el consumo real de recursos se podría utilizar el Administrador de tareas de Windows 11, observando el porcentaje de utilización de CPU correspondiente a `DOSBox.exe`. Sin embargo, para estimar con mayor precisión los ciclos físicos consumidos sería necesario emplear un perfilador de rendimiento, como Windows Performance Analyzer, junto con herramientas de medición basadas en contadores de hardware compatibles.

En conclusión, se determinó que el parámetro `cycles` es apropiado para controlar y comparar la velocidad de emulación, pero no para calcular directamente el número de ciclos físicos utilizados por el procesador anfitrión. Por esta razón, ambas métricas deben analizarse de manera independiente.

## Parte 2 — Paso 3: Configuración de modos de red

Se configuraron y verificaron tres modos de red en la máquina virtual Lab5-Alpine utilizando Oracle VirtualBox.

| Modo de red | Dirección IP | Acceso a Internet | Resultado |
|---|---|---|---|
| NAT | 10.0.2.15 | Sí | Conectividad correcta |
| Host-Only | 192.168.56.101 | No | Comunicación con el anfitrión correcta |
| Bridge | 192.168.1.112 | Sí | Conectividad con la red local e Internet correcta |

En modo NAT, la máquina virtual obtuvo una dirección IP privada administrada por VirtualBox y logró comunicarse con Internet.

En modo Host-Only, la máquina virtual obtuvo la dirección 192.168.56.101 y estableció comunicación con Windows. Se verificó mediante cuatro paquetes ICMP recibidos exitosamente, sin pérdida. No se obtuvo acceso directo a Internet.

Finalmente, en modo Bridge, Alpine Linux recibió la dirección 192.168.1.112, perteneciente a la misma red local del anfitrión, y logró comunicarse con 8.8.8.8 sin pérdida de paquetes.

Las pruebas permitieron comprobar las diferencias de conectividad y aislamiento entre los tres modos de red.

## Parte 2 — Paso 4: Gestión de snapshots

Se utilizó la funcionalidad de snapshots de Oracle VirtualBox para conservar y restaurar diferentes estados de la máquina virtual Lab5-Alpine.

Se creó inicialmente el snapshot `snap_base`, correspondiente al sistema Alpine Linux instalado y configurado, antes de agregar herramientas adicionales.

Posteriormente, mediante el gestor de paquetes APK, se instalaron las herramientas `curl`, `wget`, `nano` y `htop`. Una vez completada la instalación, se creó el segundo snapshot, denominado `snap_con_herramientas`.

Para comprobar el funcionamiento de la restauración, se apagó la máquina virtual y se recuperó el estado almacenado en `snap_base`. Después de iniciar nuevamente Alpine Linux, se verificó mediante `apk info -e curl` que el paquete ya no estaba instalado.

Esta prueba permitió comprobar que los snapshots conservan estados anteriores de una máquina virtual y facilitan la recuperación del sistema sin necesidad de reinstalar el sistema operativo o deshacer manualmente las modificaciones.

## Parte 2 — Paso 6: Comparación de rendimiento entre disco dinámico y disco fijo

Se realizó una comparación del rendimiento de escritura secuencial entre dos discos virtuales VDI de Oracle VirtualBox.

El disco original `Lab5-Alpine.vdi` utiliza asignación dinámica y tiene una capacidad de 10 GB. Posteriormente, se creó un segundo disco denominado `Lab5-Alpine-fixed.vdi`, con asignación fija y capacidad de 4 GB.

El segundo disco fue particionado, formateado con el sistema de archivos ext4 y montado en `/mnt/fijo`.

Para evaluar el rendimiento se utilizó el comando `time dd`, escribiendo 200 MiB de datos en cada disco.

### Resultados obtenidos

| Tipo de disco | Comando utilizado | Tiempo real |
|---|---|---|
| Fijo | `time dd if=/dev/zero of=/mnt/fijo/test.img bs=1M count=200` | 0,08 s |
| Dinámico | `time dd if=/dev/zero of=/root/test.img bs=1M count=200` | 0,08 s |

### Análisis de resultados

Ambos discos presentaron tiempos de escritura prácticamente idénticos, con una velocidad reportada de aproximadamente 2,5 GB/s.

El disco dinámico registró un tiempo de 0,078700 segundos, mientras que el disco fijo obtuvo 0,078918 segundos, según las mediciones internas del comando `dd`.

Estos resultados no permiten establecer una ventaja significativa de rendimiento para ninguno de los dos tipos de asignación.

Es importante considerar que las mediciones pueden estar influenciadas por la caché del sistema operativo y el almacenamiento físico del anfitrión. Además, el tiempo utilizado por `sync` no quedó incluido en los valores registrados.

La principal diferencia entre los discos se encuentra en la administración del espacio de almacenamiento: el disco fijo reserva su capacidad desde la creación, mientras que el dinámico aumenta su tamaño físico conforme se almacenan datos.