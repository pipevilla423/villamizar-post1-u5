
; Programa 3 - Medicion de tiempo real
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
; Arquitectura de Computadores - Unidad 5

org 100h

section .text
    ; Mostrar mensaje inicial
    mov ah, 09h
    mov dx, msg_inicio
    int 21h

    ; Registrar hora inicial
    mov ah, 2Ch
    int 21h
    mov [hora1], ch
    mov [min1], cl
    mov [seg1], dh
    mov [cc1], dl

    ; Bucle de trabajo fijo
    mov cx, 2000

trabajo_ext:
    push cx
    mov cx, 0FFFFh

trabajo_int:
    inc ax
    loop trabajo_int

    pop cx
    loop trabajo_ext

    ; Registrar hora final
    mov ah, 2Ch
    int 21h
    mov [hora2], ch
    mov [min2], cl
    mov [seg2], dh
    mov [cc2], dl

    ; Mostrar hora inicial
    mov ah, 09h
    mov dx, msg_t1
    int 21h

    mov al, [hora1]
    call print_dec2
    call print_sep

    mov al, [min1]
    call print_dec2
    call print_sep

    mov al, [seg1]
    call print_dec2
    call print_sep

    mov al, [cc1]
    call print_dec2

    ; Mostrar hora final
    mov ah, 09h
    mov dx, msg_t2
    int 21h

    mov al, [hora2]
    call print_dec2
    call print_sep

    mov al, [min2]
    call print_dec2
    call print_sep

    mov al, [seg2]
    call print_dec2
    call print_sep

    mov al, [cc2]
    call print_dec2

    ; Mostrar mensaje final
    mov ah, 09h
    mov dx, msg_fin
    int 21h

    ; Finalizar programa
    mov ax, 4C00h
    int 21h

; Imprimir separador
print_sep:
    push ax
    mov ah, 09h
    mov dx, sep
    int 21h
    pop ax
    ret

; Imprimir numero decimal de dos digitos
print_dec2:
    aam
    xchg ah, al
    push ax

    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h

    pop ax
    mov al, ah
    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h
    ret

section .data
    msg_inicio db "Midiendo bucle de trabajo fijo...", 13, 10, "$"
    msg_t1 db "Hora inicial (hh:mm:ss:cc): $"
    msg_t2 db 13, 10, "Hora final   (hh:mm:ss:cc): $"
    msg_fin db 13, 10, "Medicion completa. Compare el campo cc (centesimas).", 13, 10, "$"
    sep db ":$"

    hora1 db 0
    min1 db 0
    seg1 db 0
    cc1 db 0

    hora2 db 0
    min2 db 0
    seg2 db 0
    cc2 db 0
