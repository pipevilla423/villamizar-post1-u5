
; Programa 1 - Salida de texto en DOS
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
; Arquitectura de Computadores - Unidad 5

org 100h

section .text
    mov ah, 09h
    mov dx, nombre
    int 21h

    mov ax, 4C00h
    int 21h

section .data
nombre db "Laboratorio 5 - DOSBox y Ensamblador", 13, 10
       db "Estudiante: Villamizar Soler", 13, 10
       db "Unidad 5 - Arquitectura de Computadores", 13, 10, "$"
