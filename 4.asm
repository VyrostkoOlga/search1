section .text
global _start

_start:
  jmp _not_enough_args
  call _message
  call _exit
  ret

_not_enough_args:
  mov  edx, not_enough_args.len
  mov  esi, not_enough_args
  call _message
  call _exit

_message:
  push edx     ; message length
  push esi          ; message to write
  push dword 1            ; file descriptor value
  mov eax, 0x4            ; system call number for write
  sub esp, 4               ; OS X (and BSD) system calls needs "extra space" on stack
  int 0x80                 ; make the actual system call
  ; 1c clean up the stack
  add esp, 16
  ret

_exit:
  push dword 0              ; exit status returned to the operating system

  ; 2b make the call to sys call to exit
  mov eax, 0x1              ; system call number for exit
  sub esp, 4                ; OS X (and BSD) system calls needs "extra space" on stack
  int 0x80
  ret

section .data
not_enough_args: db "Not enough args!", 10
not_enough_args.len: equ $ - not_enough_args
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg
