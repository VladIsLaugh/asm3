.386
.model flat,STDCALL
option casemap :none  ;case sensitive

include lab3.inc

.code	; ������� ����
Begin:	; ���� �������
	call main	; ������ ���������� main
	invoke ExitProcess,NULL	; ����� � ���������

; ������ ��������� �������� ���'��
Mem_Alloc PROC Buf_Size:DWORD
add Buf_Size,4	; �������� ����� �� 4 ����� ������
invoke GlobalAlloc,GMEM_MOVEABLE or GMEM_ZEROINIT,Buf_Size   ; �������� ������� � ��������� ���'��
push eax 	; �������� ����� ������ ��������� ������ � ����
invoke GlobalLock,eax ;������� � ��������
pop [eax]	;��������� � ����� ��������  � �������� � ����� 4 ����� ��������� ������, 
;�� �������� � ���� ������ ������� ������
;�������� Buf_Size ���� ������������� �� �����
add eax,4	;������� �������� ������� ������ �� 4 �����, ������� ����� 4 ����� 
		;����� ��������� ������ ������
	ret	; �������� � ���������
Mem_Alloc endp

; ������ ��������� �������� ���'��.
Mem_Free PROC DATA:DWORD
mov eax,DATA	;������� �������� ��������� ��������� � ������ eax, ���������� � 
		;��������� (������) ������ ������ ( ������� + 4 �����)
sub eax,4	;���'�����, �� ������ 4 ����� ������  - �� ����� ������
push [eax]	;������ �������� ������ �������� �� �����, �� ������ � ������ eax, �������� ���� � ����
invoke GlobalUnlock,eax	;������������ ���'��� (��� ������� Buf_Size+4)
call GlobalFree	;������� �������� ��� � �����, ��������� ��������� ��� ���������, �� ��������� ���������� 
;call (������� ������ ������)
	ret	;����� � ���������
Mem_Free endp

main proc	;������� ���������

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
	ret		; ����� � ���������
main endp	
end Begin	;����� ��������
