; These are procedure prototypes for procedures created outside this source file
ExitProcess proto

; The .const section is where constants are stored. Every occurance of constant will be replaced with its respective value during compile time. For example, "mov rcx, EXIT_SUCCESS" will be replaced with "mov rcx, 0" in the actual executable.
.const

	; Exit status codes used within the program
	EXIT_SUCCESS equ 0

; The .code section is where procedures are created. 
.code
	
	; The main procedure is the first procedure to execute. This can be configured in Visual Studio 2022 by right-clicking the project, and going to Properties -> Linker -> Advanced -> Entry Point and entering the name of the procedure. In this case, "main" (without quotes).
	main proc

		; Function Prologue
		push rbp
		mov rbp, rsp

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