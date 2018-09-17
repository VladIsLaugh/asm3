.386
.model flat,STDCALL
option casemap :none  ;case sensitive

include lab3.inc

.code	; сегмент коду
Begin:	; мітка початку
	call main	; виклик підпрограми main
	invoke ExitProcess,NULL	; вихід з процедури

; власна процедура виділення пам'яті
Mem_Alloc PROC Buf_Size:DWORD
add Buf_Size,4	; виділяємо буфер на 4 байти більший
invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT,Buf_Size   ; виділяємо область у динамічній пам'яті
push eax 	; зберігаємо хендл області виділеного буфера у стек
invoke GlobalLock,eax ;фіксуємо у реальній
pop [eax]	;Витягнемо зі стеку значення  і запишемо у перші 4 байта виділеного масиву, 
;це значення є хенд області виділеної області
;наступні Buf_Size байт використовуємо як масив
add eax,4	;зсуваємо вказівних початку масиву на 4 байти, оскільки перші 4 байти 
		;заняті значенням хендлу буфера
	ret	; виходимо з процедури
Mem_Alloc endp

; власна процедура знищення пам'яті.
Mem_Free PROC DATA:DWORD
mov eax,DATA	;копіюємо значення параметра процедури у регістр eax, параметром є 
		;початкова (робоча) адреса буфера ( початок + 4 байти)
sub eax,4	;пам'ятаємо, що перших 4 байти масиву  - це хендл буфера
push [eax]	;беремо чотирьох байтне значення по адресі, що лежить у регістрі eax, заносимо його у стек
invoke GlobalUnlock,eax	;розблоковуємо пам'ять (всю розміром Buf_Size+4)
call GlobalFree	;оскільки параметр вже у стеці, викликаємо процедуру без параметрів, за дапомогою інструкції 
;call (знищуємо хендел буфера)
	ret	;вихід з процедури
Mem_Free endp

main proc	;основна процедура

	mov p.lStructSize, sizeof OPENFILENAME
	mov p.lpstrFile, offset buf
	mov p.nMaxFile, 260
	

	invoke GetOpenFileName, addr p
	
	invoke Mem_Alloc,4000h
	mov pmem, eax
	invoke CreateFile, addr buf, GENERIC_READ or GENERIC_WRITE,FILE_SHARE_DELETE,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
	cmp eax, -1
	jz endd
	
	mov hfile1,eax
	invoke ReadFile,hfile1, pmem,4000h, addr readed,0
	;invoke GetFileTime,hfile1, eax, addr LastAccessed, addr LastWrittenTo
	
	invoke MessageBox,0,addr mes,addr title1,MB_OKCANCEL
	cmp qq, 1
	jz ok
	cmp eax, 2
	jz cncl
	
	ok:
	invoke DeleteFile, addr buf
	invoke MessageBox,0,addr arg1,addr title1,MB_OK
	jmp exit
	
	cncl:
	invoke MessageBox,0,addr arg2,addr title1,MB_OK
	jmp exit
	
	
	exit:
	
		
	invoke CloseHandle,hfile1
	invoke Mem_Free,pmem
endd:
	ret		; вихід з процедури
main endp	
end Begin	;кінець програми
