include WINDOWS.inc	; файл констант

include user32.inc	; файл заголовківl user32.dll
include kernel32.inc	; файл заголовківl kernel32.dll

include RADbg.inc
include debug.inc
includelib DEBUG.LIB
includelib raddebug.lib
include masm32.inc

include comdlg32.inc
includelib comdlg32.lib

includelib user32.lib	;файл бібліотеки з таблицею імпорту user32.dll
includelib kernel32.lib	;файл бібліотеки з таблицею імпорту kernel32.dll

MEMSIZE	equ 1000000h  ; 16 Mb	; власна константа рівна значенню 16*220

.data	;сегмент даних
    title1		db 'Лабораторна робота №3',0	;стрічка, використовуємо її для заголовку повідомлення
    filename1	db 'lab3.asm',0	; стрічка, вміст якої шлях до файлу, по замовчуванню файл знаходиться у поточному каталозі
	hfile1		dd 0
	hfile2		dd 0
	readed		dd 0
	pmem 		dd 0
	filename2	db 'lab3.txt',0	
	buf			db 260 dup (0)
	mes			db 'Ви дійсно хочете видалити данний файл?',0
	qq			dd 100 dup (0)
	arg1		db 'Файл успішно видалено',0
	arg2		db 'Видалення файлу скасовано',0
	Created dd 0 
	LastAccessed dd 0 
	LastWrittenTo dd 0 
	
	p OPENFILENAME <0>


