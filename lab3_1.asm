.386
.MODEL flat, stdcall
 
 GetStdHandle PROTO, nStdHandle: DWORD 
 WriteConsoleA PROTO, handle: DWORD, lpBuffer:PTR BYTE, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:PTR DWORD, lpReserved:DWORD
 ReadConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
 ExitProcess PROTO, dwExitCode: DWORD 

 STD_OUTPUT_HANDLE equ -11
 STD_INPUT_HANDLE equ -10
 .data
 outputHandle DD ?
 inputHandle DD ?
 source DB 10 dup(?)
 destination DB 10 dup(?)
 wiadomosc1 db "Wypelnij tablice 10ma elementami!", 10d
 iloscLiter dd 34d
 zmiennaZnakow dd ?
 .code
 main PROC
	
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov outputHandle, EAX
	; wypisanie komunikatu na konsole
	push 0
	push offset zmiennaZnakow
	push iloscLiter
	push offset wiadomosc1
	push outputHandle

	call WriteConsoleA 

	push STD_INPUT_HANDLE
	call GetStdHandle
	mov inputHandle, EAX

	; pobranie znakow

	push 0
	push offset zmiennaZnakow
	push 10d
	push offset source
	push inputHandle

	call ReadConsoleA
	
	
	;kopiowanie petla
	mov EDX,0 ;iterator
	mov ECX, 10d;10 powtorzen
	petla:
	push ECX

	mov EAX, offset source
	add EAX,EDX
	mov EBX, [EAX]
	
	mov EAX, offset destination
	add EAX,EDX
	mov [EAX],EBX

	
	
	
	inc EDX
	pop ECX
	LOOP petla
	
	
	
	push 0
	push offset zmiennaZnakow
	push 10
	push offset destination
	push outputHandle

	call WriteConsoleA 
	
	
	
	push 0
	call ExitProcess
 main ENDP
END main