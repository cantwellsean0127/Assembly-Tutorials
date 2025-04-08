; These are procedure prototypes for procedures created outside this source file
GetStdHandle proto
WriteConsoleA proto
ExitProcess proto

; The .const section is where constants are stored. Every occurance of constant will be replaced with its respective value during compile time. For example, "mov rcx, EXIT_SUCCESS" will be replaced with "mov rcx, 0" in the actual executable.
.const
	
	CHAR_NULLBYTE equ 0
	CHAR_NEWLINE equ 10
	STD_OUTPUT_HANDLE equ -11
	EXIT_SUCCESS equ 0

; The .data section is where initialized variabels are stored.
; dq = define quad-words (64-bits)
; dd = define double-words (32-bits)
; dw = define words (16 bits)
; db = define bytes (8 bits)
.data
	
	; The stdout_handle variable contains the handle to the console screen buffer. This is 64-bits in size.
	stdout_handle dq 0

	; The greeting variable contains 1-byte characters to represent our greeting.
	greeting db "Hello, World!", CHAR_NEWLINE, CHAR_NULLBYTE

	; The greeting_length variable contains the size of the greeting variable. Since this value will be passed directly to a 64-bit register, it is easier to also make the variable 64 bits.
	greeting_length dq 15

; The .code section is where procedures are created. 
.code
	
	; The main procedure is the first procedure to execute. This can be configured in Visual Studio 2022 by right-clicking the project, and going to Properties -> Linker -> Advanced -> Entry Point and entering the name of the procedure. In this case, "main" (without quotes).
	main proc
		
		; Function Prologue
		push rbp
		mov rbp, rsp

		; Procedure: GetStdHandle from the Win32 API
		;
		; Documentation: https://learn.microsoft.com/en-us/windows/console/getstdhandle
		;
		; Description: Retrieves a handle to the specified standard device (standard input, standard output, or standard error).
		;
		; Parameters:
		; nStdHandle [in]: The standard device
		;
		; Return Value: If the function succeeds, the return value is a handle to the specified device.
		;
		sub rsp, 32
		mov rcx, STD_OUTPUT_HANDLE
		call GetStdHandle
		add rsp, 32
		mov stdout_handle, rax

		; Procedure: WriteConsoleA from the Win32 API
		;
		; Documentation: https://learn.microsoft.com/en-us/windows/console/writeconsole
		;
		; Description: Writes a character string to a console screen buffer beginning at the current cursor location.
		;
		; Parameters:
		; hConsoleOutput [in]: A handle to the console screen buffer.
		; lpBuffer [in]: A pointer to a buffer that contains characters to be written to the console screen buffer.
		; nNumberOfCharsToWrite [in]: The number of characters to be written.
		; lpNumberOfCharsWritten [out, optional]: A pointer to a variable that receives the number of characters actually written.
		; lpReserved Reserved; must be NULL.
		;
		; Return Value: If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
		;
		sub rsp, 40
		mov rcx, stdout_handle
		lea rdx, greeting
		mov r8, greeting_length
		mov r9, 0
		push 0
		call WriteConsoleA
		add rsp, 48

		; Procedure: ExitProcess from the Win32 API
		;
		; Description: Ends the calling process and all its threads.
		;
		; Documentation: https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-exitprocess
		;
		; Parameters:
		; [in] UINT uExitCode: The exit code for the process and all threads.
		;
		; Return Value: None
		;
		sub rsp, 32
		mov rcx, EXIT_SUCCESS
		call ExitProcess

	; This is the end of the main procedure
	main endp

; This is the end of this source file
end