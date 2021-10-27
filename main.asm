section .text

%include 'colon.inc'

section .data

%include 'words.inc'

start_msg:
    db 'Enter the key: ', 0
err_msg: 
    db 'Couldn not read the word', 10, 0
not_found_msg: 
    db 'The key was not found in the dictionary', 10, 0
found_msg: 
    db 'Value by key: ', 0


section .text

global _start

extern find_word
extern read_string
extern print_string
extern print_newline
extern string_length
extern exit

_start:
    mov rdi, 1
    mov rsi, start_msg
    call print_string
    sub rsp, 256
    mov rsi, 256
    mov rdi, rsp
    call read_string
    test rax, rax
    jz .error
    mov rdi, rsp
    mov rsi, first
    call find_word
    add rsp, 256
    test rax, rax
    jz .not_found
    push rax
    mov rdi, 1
    mov rsi, found_msg
    call print_string
    pop rax
    add rax, 8
    mov rdi, rax
    push rax
    call string_length
    pop rsi
    add rsi, rax
    inc rsi
    mov rdi, 1
    call print_string
    call print_newline
    call exit

.error:
    add rsp, 256
    mov rdi, 2
    mov rsi, err_msg
    call print_string
    call exit

.not_found:
    mov rdi, 2
    mov rsi, not_found_msg
    call print_string
    call exit

