section .text

global find_word

extern string_length
extern string_equals

;Параметры:
; rdi - указатель на нуль-терминированную строку
; rsi - указатель на начало словаря
; Возвращает:
; rax - адрес начала вхождения в словарь, если найдено, иначе 0

find_word:
.loop:
    push rsi            ; сохраняем rsi
    push rdi            ; сохраняем rdi
    add rsi, 8          ; получаем указатель ключа
    call string_equals  ; сравниваем переданную строку и ключ в словаре
    pop rdi             ; возвращаем rdi
    pop rsi             ; возвращаем rsi
    test rax, rax       
    jnz .found          ; если строки равны, то найдено
    mov rsi, [rsi]      ; указатель следующего элемента в rax
    test rsi, rsi
    jnz .loop           ; повтор цикла, если не достигнут конец словаря
    xor rax, rax        ; возврат 0
    ret   
.found:
    mov rax, rsi        ; возврат адреса начала вхождения
    ret                  