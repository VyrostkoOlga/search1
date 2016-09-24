nasm -f macho 4.asm
ld -o 4 -e _start 4.o
./4
