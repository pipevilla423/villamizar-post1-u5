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

## Parte 2 — Paso 7: Decisión técnica — Selección del modo de red y sus implicaciones de seguridad

Para el desarrollo del laboratorio se determinó que **NAT es el modo de red más apropiado** para la máquina virtual Lab5-Alpine, debido a que permite acceder a Internet sin exponer directamente el sistema operativo huésped a los demás dispositivos de la red local.

En este modo, VirtualBox administra una red privada en la que la máquina virtual puede iniciar conexiones hacia Internet, descargar paquetes y realizar actualizaciones. Sin embargo, los dispositivos externos no pueden iniciar conexiones directamente hacia la VM mediante su dirección privada, salvo que se configuren mecanismos como el reenvío de puertos. Esto proporciona una capa de aislamiento apropiada para un entorno de aprendizaje.

Por otra parte, **Host-Only** resulta conveniente para prácticas de Arquitectura de Computadores y redes donde se requiere estudiar la comunicación entre el anfitrión y la máquina virtual sin permitir conexiones directas a Internet. Este modo permite experimentar con direcciones IP, protocolos y servicios de red en un entorno más controlado. Su principal limitación es la pérdida de conectividad externa, lo que impide descargar paquetes o actualizar el sistema sin configurar conexiones adicionales.

Finalmente, **Bridge presenta mayores riesgos de exposición** para este escenario, debido a que la máquina virtual obtiene una dirección IP de la misma red local que el equipo anfitrión. Esto permite que otros dispositivos de dicha red puedan intentar establecer conexiones con los servicios activos de Alpine Linux, como OpenSSH, aumentando las posibilidades de acceso no autorizado si existen configuraciones inseguras o vulnerabilidades.

Durante las pruebas se verificó que NAT asignó la dirección `10.0.2.15`, Host-Only asignó `192.168.56.101` y Bridge asignó `192.168.1.112`.

En conclusión, se seleccionó **NAT como configuración predeterminada del laboratorio**, porque ofrece un equilibrio adecuado entre conectividad, aislamiento y seguridad, sin necesidad de que otros dispositivos de la red local accedan directamente a la máquina virtual.

## Parte 2 — Paso 8: Decisión técnica — Disco fijo frente a dinámico y asignación de CPU/RAM

Durante el desarrollo del laboratorio se comparó el rendimiento de escritura secuencial entre un disco virtual de asignación fija y uno de asignación dinámica, utilizando Oracle VirtualBox y el comando `time dd` de Alpine Linux.

Los resultados mostraron que ambos discos registraron un tiempo real de **0,08 segundos** para escribir 200 MiB. Sin embargo, al analizar los valores más precisos reportados por `dd`, el disco dinámico obtuvo 0,078700 segundos, mientras que el disco fijo registró 0,078918 segundos. Por lo tanto, el disco dinámico resultó ligeramente más rápido en esta medición, aunque la diferencia de 0,000218 segundos es demasiado pequeña para establecer una ventaja significativa.

Desde el punto de vista técnico, un disco fijo reserva todo su espacio de almacenamiento desde su creación, evitando el trabajo adicional de ampliar el archivo `.vdi` durante las escrituras. En cambio, un disco dinámico aumenta progresivamente su tamaño en el sistema anfitrión, lo que puede generar operaciones adicionales de asignación de espacio y afectar el rendimiento en determinadas circunstancias.

A pesar de esta diferencia, **se considera más apropiado utilizar discos dinámicos en laboratorios académicos**, debido a que ocupan únicamente el espacio necesario para almacenar los datos utilizados. Esto permite administrar eficientemente el almacenamiento disponible, especialmente cuando varios estudiantes trabajan con máquinas virtuales en computadores de capacidad limitada.

Respecto a la asignación de recursos, se determinó que **2 CPUs virtuales y 2048 MB de RAM** representan una configuración adecuada para Alpine Linux, ya que proporcionan recursos suficientes para ejecutar herramientas básicas sin consumir excesivamente la capacidad del anfitrión.

En equipos con 4 a 8 núcleos o procesadores lógicos disponibles y entre 8 y 16 GB de RAM, esta asignación permite mantener recursos para Windows y otras aplicaciones. Por el contrario, asignar todos los procesadores o la mayor parte de la memoria RAM a una sola máquina virtual puede provocar saturación, intercambio de memoria con el disco y disminución del rendimiento general.

En conclusión, se recomienda utilizar **discos dinámicos y una asignación moderada de CPU y RAM**, priorizando el aprovechamiento eficiente de los recursos, la estabilidad del sistema anfitrión y las necesidades reales del laboratorio.

## Parte 2 — Paso 9: Exportación OVA y consolidación del repositorio

Se realizó el procedimiento de exportación de la máquina virtual Lab5-Alpine utilizando la herramienta VBoxManage de Oracle VirtualBox.

La exportación se configuró en formato OVA, basado en el estándar Open Virtualization Format (OVF), que permite distribuir máquinas virtuales con sus archivos de configuración y discos virtuales.

El archivo de exportación se denominó `Lab5-Alpine-export.ova` y se almacenó fuera del repositorio GitHub debido a su tamaño.

El proceso de exportación se verificó mediante la existencia y el tamaño del archivo generado. La evidencia correspondiente se almacenó en la carpeta `capturas/`.

Adicionalmente, se creó el archivo `VBoxManage_commands.sh`, que documenta los comandos utilizados durante las actividades de configuración de red, snapshots, asignación de recursos, creación de discos virtuales y exportación.

## Conclusiones generales del laboratorio

El desarrollo del laboratorio permitió comprobar las diferencias fundamentales entre la emulación y la virtualización mediante DOSBox y Oracle VirtualBox.

En la primera parte, DOSBox permitió ejecutar programas ensambladores x86 de 16 bits mediante un entorno DOS emulado. Las mediciones demostraron que el parámetro `cycles` influye directamente en la velocidad de ejecución. Con 1000 cycles se registraron 262,38 segundos, con 8000 cycles se registraron 32,74 segundos y con 20000 cycles se registraron 13,07 segundos. Esto permitió justificar el uso de una velocidad fija para mantener condiciones comparables.

En la segunda parte, VirtualBox permitió instalar y administrar un sistema operativo Alpine Linux completo mediante recursos virtualizados. Se comprobaron las diferencias entre los modos de red NAT, Host-Only y Bridge, identificando NAT como la opción más apropiada para un laboratorio personal por su equilibrio entre conectividad y aislamiento.

La creación y restauración de snapshots demostró la utilidad de conservar estados anteriores de una máquina virtual para recuperar configuraciones sin reinstalar el sistema operativo.

También se verificó que la asignación de 2 CPUs virtuales y 2048 MB de memoria RAM resultó suficiente para las tareas realizadas con Alpine Linux.

Respecto al almacenamiento, los discos fijo y dinámico presentaron tiempos de escritura prácticamente idénticos de 0,08 segundos. Por sus ventajas en el aprovechamiento del espacio disponible, se consideró más conveniente el disco dinámico para este entorno académico.

Finalmente, la exportación OVA y el uso de GitHub permitieron documentar los procedimientos y facilitar la distribución del entorno y la revisión de las evidencias.

En conclusión, el laboratorio demostró que la emulación es útil para reproducir arquitecturas y entornos de software históricos, mientras que la virtualización facilita la ejecución, administración y recuperación de sistemas operativos completos. Ambas tecnologías constituyen herramientas importantes para comprender el funcionamiento de los sistemas computacionales.