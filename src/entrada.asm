
; Programa 2 - Entrada de teclado y codigo ASCII
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
; Arquitectura de Computadores - Unidad 5

org 100h

section .text
    ; Mostrar mensaje inicial
    mov ah, 09h
    mov dx, prompt
    int 21h

    ; Leer caracter sin eco automatico
    mov ah, 07h
    int 21h
    mov bl, al

    ; Mostrar caracter recibido
    mov ah, 09h
    mov dx, msg_ok
    int 21h

    mov ah, 02h
    mov dl, bl
    int 21h

    ; Mostrar codigo ASCII hexadecimal
    mov ah, 09h
    mov dx, msg_cod
    int 21h

    ; Mostrar nibble alto
    mov al, bl
    shr al, 4
    call print_hex_nibble

    ; Mostrar nibble bajo
    mov al, bl
    and al, 0Fh
    call print_hex_nibble

    ; Nueva linea
    mov ah, 09h
    mov dx, nl
    int 21h

    ; Terminar programa
    mov ax, 4C00h
    int 21h

print_hex_nibble:
    cmp al, 9
    jle .digito
    add al, 7

.digito:
    add al, 30h
    mov ah, 02h
    mov dl, al
    int 21h
    ret

section .data
    prompt db "Ingrese una letra (se mostrara su codigo ASCII): $"
    msg_ok db 13, 10, "Caracter recibido: $"
    msg_cod db 13, 10, "Codigo ASCII (hex): $"
    nl db 13, 10, "$"
