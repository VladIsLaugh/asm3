include WINDOWS.inc	; ���� ��������

include user32.inc	; ���� ���������l user32.dll
include kernel32.inc	; ���� ���������l kernel32.dll

include RADbg.inc
include debug.inc
includelib DEBUG.LIB
includelib raddebug.lib
include masm32.inc

include comdlg32.inc
includelib comdlg32.lib

includelib user32.lib	;���� �������� � �������� ������� user32.dll
includelib kernel32.lib	;���� �������� � �������� ������� kernel32.dll

MEMSIZE	equ 1000000h  ; 16 Mb	; ������ ��������� ���� �������� 16*220

.data	;������� �����
    title1		db '����������� ������ �3',0	;������, ������������� �� ��� ��������� �����������
    filename1	db 'lab3.asm',0	; ������, ���� ��� ���� �� �����, �� ������������ ���� ����������� � ��������� �������
	hfile1		dd 0
	hfile2		dd 0
	readed		dd 0
	pmem 		dd 0
	filename2	db 'lab3.txt',0	
	buf			db 260 dup (0)
	mes			db '�� ����� ������ �������� ������ ����?',0
	qq			dd 100 dup (0)
	arg1		db '���� ������ ��������',0
	arg2		db '��������� ����� ���������',0
	Created dd 0 
	LastAccessed dd 0 
	LastWrittenTo dd 0 
	
	p OPENFILENAME <0>


