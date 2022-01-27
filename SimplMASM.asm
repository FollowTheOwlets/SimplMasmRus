.386                                                         
.model flat, stdcall                                         
option casemap:none                                           

include C:\masm32\include\windows.inc                         
include c:\masm32\include\kernel32.inc                        
include C:\masm32\include\user32.inc                          
include C:\masm32\include\masm32.inc                          

includelib c:\masm32\lib\kernel32.lib                        
includelib c:\masm32\lib\user32.lib                           
includelib C:\masm32\lib\masm32.lib                           

.const
BSIZE       equ   100                                         
MAXSCREENX equ  80
MAXSCREENY equ  25

.data       
                                                  
downloadChar1 byte 255
downloadChar2 byte 255                                        
ColorW      dd    FOREGROUND_RED + FOREGROUND_GREEN + FOREGROUND_BLUE
BackColorW      dd    BACKGROUND_RED + BACKGROUND_GREEN + BACKGROUND_BLUE
ColorB      dd    FOREGROUND_BLUE  + FOREGROUND_GREEN
msg1310 byte 13, 10

;MENU
char byte "|"
m1  byte "О языке Ассемблера {*}" 
m2  byte "Изучать MASM32 {**}"
m3  byte "Тест по MASM32 {***}"
m4  byte "Об Авторе {****}"
console byte "{*?} Команда : "   
consolePost byte "{0 or 1,2..}{command only for test} Команда : "       

;Загрузка программы
download byte "Загрузка"
download10  byte " 10% "
download20  byte " 20% "
download30  byte " 30% "
download40  byte " 40% "
download50  byte " 50% "
download60  byte " 60% "
download70  byte " 70% "
download80  byte " 80% "
download90  byte " 90% "
download100 byte " 100% "



;Большие текста для экранов
Sc1  byte "         ___     _____    _____    _____    __  __    _____    __      _____    _____"
Sc2  byte "        / _ \   /  ___>  /  ___>  |  ___|  |  \/  |  |  __ \  |  |    |  ___|  |  _  \"
Sc3  byte "       /  _  \  \___  \  \___  \  |  ___|  |      |  |  __ <  |  |__  |  ___|  |     /"
Sc4  byte "       \_/ \_/  <_____/  <_____/  |_____|  |_|\/|_|  |_____/  |_____| |_____|  |__|__\"
Sc5  byte "     Это низкоуровневый язык программирования для компьютеров или других программируемых устройств,"
Sc6  byte " он специфичен для конкретной компьютерной архитектуры центрального процессора, что отличает его"
Sc7  byte " от большинства высокоуровневых языков программирования, которые обычно портативны среди разных систем."
StrokaAssembler1  byte "                  .----.  MASM32 - это независимый проект,"
StrokaAssembler2  byte "      .---------. | == |           призванный упростить работу опытных программистов, начинающих"
StrokaAssembler3  byte "      |.-+++++-.| |----|           программировать на ассемблере. Это сложная и требовательная форма"
StrokaAssembler4  byte "      ||MASM 32|| | == |           программирования, которая требует высокой точности кодирования и"
StrokaAssembler5  byte "      ||       || |----|           требует хорошего понимания мнемоники Intel и архитектуры процессора x86,"
StrokaAssembler6  byte "      |'-.....-'| |::::|           используемых в среде операционной системы Windows."
StrokaAssembler7  byte "      `++)---(++` |___.|           "
StrokaAssembler8  byte "     /:::::::::::\+ _  +           "
StrokaAssembler9  byte "    /:::=======:::\`\`\            "
StrokaAssembler10 byte "    `+++++++++++++`  '-'           "


Siz1  byte  "       __      __          ___                                             "
Siz2  byte  "      /\ \  __/\ \        /\_ \                                            "
Siz3  byte  "      \ \ \/\ \ \ \     __\//\ \      ___     ___     ___ ___       __     "
Siz4  byte  "       \ \ \ \ \ \ \  /'__`\\ \ \    /'___\  / __`\ /' __` __`\   /'__`\   "
Siz5  byte  "        \ \ \_/ \_\ \/\  __/ \_\ \_ /\ \__/ /\ \L\ \/\ \/\ \/\ \ /\  __/   "
Siz6  byte  "         \ `\___x___/\ \____\/\____\\ \____\\ \____/\ \_\ \_\ \_\\ \____\  "
Siz7  byte  "          '\/__//__/  \/____/\/____/ \/____/ \/___/  \/_/\/_/\/_/ \/____/  "                                                      
Siz8  byte  "               __                __               ___    ___               "
Siz9  byte  "              /\ \__            /\ \             /\_ \  /\_ \              "
Siz10 byte  "              \ \ ,_\    ___    \ \ \___       __\//\ \ \//\ \             "
Siz11 byte  "               \ \ \/   / __`\   \ \  _ `\   /'__`\\ \ \  \ \ \            "
Siz12 byte  "                \ \ \_ /\ \L\ \   \ \ \ \ \ /\  __/ \_\ \_ \_\ \_          "
Siz13 byte  "                 \ \__\\ \____/    \ \_\ \_\\ \____\/\____\/\____\         "
Siz14 byte  "                  \/__/ \/___/      \/_/\/_/ \/____/\/____/\/____/         "

legend1 byte "Обозначения цветов :" 
legend2 byte "Красным показаны блоки программы" 
legend3 byte "Голубым показано Оглавление" 
legend4 byte "Зеленым показана теоретика и комментарии" 
legend5 byte "Белым показаны куски кода, которые можно использовать в своих программах"

stroka1 byte   "                      Сегментная модель памяти "    
strokaR2 byte   "    .386 "    
strokaR3 byte   "    .model flat, stdcall "    
strokaR4 byte   "    .data                     "    
strokaB5 byte   "        рисунок регистров     "    
strokaG6 byte   "                               -----------------EAX----------------- (32 бита) "    
strokaG7 byte   "                                                 ---------AX-------- (16 бит) "    
strokaG8 byte   "                                                 ---AL----|----AH--- (8 бит) "    
strokaG9 byte   "                            |___________________|_________|_________| "    
strokaG10 byte   "                      EAX/AX/AH/AL (accumulator register) – аккумулятор "    
strokaG11 byte   "                      EBX/BX/BH/BL (base register) –регистр базы "    
strokaG12 byte   "                      ECX/CX/CH/CL (counter register) – счётчик "    
strokaG13 byte   "                      EDX/DX/DH/DL (data register) – регистр данных "    
strokaG14 byte   "                      ESI/SI (source index register) – индекс источника "    
strokaG15 byte   "                      EDI/DI (destination index register) – индекс приёмника (получателя) "    
strokaG16 byte   "                      ESP/SP (stack pointer register) – регистр указателя стека "    
strokaG17 byte   "                      EBP/BP (base pointer register) – регистр указателя базы кадра стека. "    
strokaB18 byte   "    Cинтаксис директив определения данных    "    
strokaG19 byte   "                      db для очень коротких регистров  al - ah, bl - bh и тд "    
strokaG20 byte   "                      dw для коротких регистров ax,bx,cx,dx "    
strokaG21 byte   "                      dd для длинных регистров eax,ebx,ecx,edx "    
strokaB22 byte   "    Системы счисления чисел  "    
strokaG23 byte   "                      48d -десятеричная "    
strokaG24 byte   "                      48h - шестнадцатиричная  "    
strokaG25 byte   "                      48o - восьмиричная "    
strokaR26 byte   "    .code "    
strokaB27 byte   "    Пример создания процедуры (вызов в start: call STEP) "    
stroka28 byte   "              STEP proc "    
stroka29 byte   "                      XCHG ebx,eax "    
stroka30 byte   "              ret "    
stroka31 byte   "              STEP ENDP "    
strokaR32 byte   "    start: "    
strokaB33 byte   "    Операнды  "    
strokaG34 byte   "                      mov ebx,eax        ;присвоить регистру "    
strokaG35 byte   "                      mul ebx            ;произвести умножение на регистр eax и сохранить туда результат "    
strokaG36 byte   "                      div ebx            ;произвести деление регистра eax на ebx и сохранит результат в eax "    
strokaG37 byte   "                      add ebx,eax        ;прибавить регистру "    
strokaG38 byte   "                      sub ebx,eax        ;вычесть из регистра "    
strokaG39 byte   "                      dec ebx            ;аналог i-- "    
strokaG40 byte   "                      inc ebx            ;аналог i++ "    
strokaG41 byte   "                      XCHG ebx,eax       ;swap значениями "    
stroka42 byte   "    ------------------------------------------------------------- "    
strokaB43 byte   "    Меняем числа местами с помощью стека "    
stroka44 byte   "                      mov ax,1234h "    
stroka45 byte   "                      mov bx,5678h "    
stroka46 byte   "                      push ax "    
stroka47 byte   "                      push bx "    
stroka48 byte   "                      pop ax "    
stroka49 byte   "                      pop bx "    
stroka50 byte   "    ------------------------------------------------------------- "    
strokaB51 byte   "    Прыжок по коду(JMP)      "    
stroka52 byte   "                      JMP Label_2 "    
stroka53 byte   "                          Label_1: "    
stroka54 byte   "                              ;--- Участок кода 1 --- "    
stroka55 byte   "                          Label_2:		 Это МЕТКА "    
stroka56 byte   "                              ;--- Участок кода 2 --- "    
stroka57 byte   "                      JMP Label_1 "    
stroka58 byte   "    ------------------------------------------------------------- "    
strokaB59 byte   "    Прыжок по коду УСЛОВНЫЙ(JNA,JNB,JNL,JLE,JL,JB,JBE,JG,JGE) "    
strokaG60 byte   "                      РЕЦЕПТ НАЗВАНИЯ УСЛОВИЯ "    
strokaG61 byte   "                          J + [Not or _] + [GREAT(ABOVE) or LESS(BELOW) or BOTTOM or _] +[EQUAL or _] "    
strokaG62 byte   "                                      Например  JNA - это Jump if Not Above (переход, если НЕ больше). "    
strokaG63 byte   "                                  Так же JBE - Jump if bottom or equal , как “переход, если меньше или равно”. "    
strokaG64 byte   "                                  Чтобы не путать БОЛЬШЕ и МЕНЬШЕ (GREAT и LESS), "    
strokaG65 byte   "                                  которые используются при сравнении операндов со знаком, "    
strokaG66 byte   "                                  при сравнении операндов БЕЗ знака используются понятия ABOVE и BELOW (ВЫШЕ и НИЖЕ). "    
strokaB67 byte   "                  Пример:      "    
stroka68 byte   "                      JNA Label_1 "    
strokaG69 byte   "                              ;---Участок кода для пропуска--- "    
stroka70 byte   "                          Label_1: "    
strokaG71 byte   "                              ;--- Участок кода 1 --- "    
stroka72 byte   "    ------------------------------------------------------------- "    
strokaB73 byte   "    Простой цикл L (возведение в степень) "    
stroka74 byte   "              mov ecx,3 ;-степень "    
stroka75 byte   "              mov eax,1 ;-для хранения "    
stroka76 byte   "              mov ebx,3 ;-число которое будем возводить в степень "    
stroka77 byte   "          L:  mul ebx "    
stroka78 byte   "              dec ecx      "    
stroka79 byte   "              cmp ecx, 0  "    
stroka80 byte   "          jne L "    
stroka81 byte   "    ------------------------------------------------------------- "    
strokaB82 byte   "    Простой цикл LOOPE (Сумма элементов массива c помощью ecx (для cx jcxz) "    
stroka83 byte   "              mov eax,0  "    
stroka84 byte   "              mov ebx,0 "    
stroka85 byte   "              mov ecx,N ;- кол-во эл в массиве "    
stroka86 byte   "          jecxz Exit "    
stroka87 byte   "          CYCL : "    
stroka88 byte   "              add eax,x[ebx] "    
stroka89 byte   "              add ebx,type x "    
stroka90 byte   "              dec ecx "    
stroka91 byte   "              cmp ecx,ecx ;-хитрость - в цикле LOOPE выход происходит при не совпадении,"    
stroka912 byte  "                                                    по этому выходить будем не использую флаг F "
stroka92 byte   "          loope CYCl "    
stroka93 byte   "          Exit: ... "              
stroka94 byte   "    ------------------------------------------------------------- "    
strokaB95 byte   "    Операторы сравнения  "    
strokaG96 byte   "       Пример использования: "    
stroka97 byte   "              A dd 8  "    
stroka98 byte   "              ... "    
stroka99 byte   "              mov    al, A eq 8  al = 0 "    
stroka100 byte   "              cmp    al, 1               если A==8, то "    
stroka101 byte   "              je     m1                  переход на m1 "    
stroka102 byte   "              ... "    
stroka103 byte   "              m1: … "    
strokaG104 byte   "                      eq         ~ | == | "    
strokaG105 byte   "                      ne	 ~ | != | "    
strokaG106 byte   "                      lt	 ~ | <  | "    
strokaG107 byte   "                      le	 ~ | <= | "    
strokaG108 byte   "                      gt	 ~ | >  | "    
strokaG109 byte   "                      ge	 ~ | >= | "    
strokaB110 byte   "    WinAPI "    
strokaG111 byte   "              Если вы решили использовать в своей программе WinAPI то ваш блок start должен начинаться с кода: "    
stroka112 byte   "                        invoke AllocConsole	 "    
stroka113 byte   "                        invoke GetStdHandle, STD_INPUT_HANDLE  "    
stroka114 byte   "                        mov stdin, eax  "    
stroka115 byte   "                        invoke GetStdHandle, STD_OUTPUT_HANDLE                     "    
stroka116 byte   "                        mov stdout, eax  "    
strokaG117 byte   "              И заканчиваться строчками : "    
stroka118 byte   "                        invoke  Sleep, 5000 "    
stroka119 byte   "                        invoke ExitProcess, 0   "    
strokaG120 byte   "              В сердцевине придется использовать разные invoke, вот основные, что мне пригодились: "    
strokaG121 byte   "                        Небольшой совет делать из них макросы!Ведь там используются везде одни и те же аргументы."    
stroka122 byte   "                                  cout macro p1  ;-(аналог)-> cout<<p1 "    
stroka123 byte   "                                            invoke WriteConsole,   stdout,   ADDR p1,   SIZEOF p1,   ADDR cWritten,0 "    
stroka124 byte   "                                  endm "    
stroka125 byte   "                                  cin macro p1  ;-(аналог)-> cin>>p1 Но тут p1 будет в основном buf "    
stroka126 byte   "                                            invoke ReadConsole,   stdin,   ADDR p1,   SIZEOF p1,   ADDR cRead,   0"    
stroka127 byte   "                                  endm "    
strokaG128 byte   "              Процедура преобразования считанной строки в число  "    
stroka129 byte   "                        INPUTint proc  "    
stroka130 byte   "                                  cin buf                                               "    
stroka131 byte   "                                  mov eax, offset buf   ;offset buf - это смещение которое было произведено в buf "    
stroka132 byte   "                                  add eax, cRead    "    
stroka133 byte   "                                  sub cRead,2           ;cRead теперь это кол-во введенных вами символов(было 2 лишних)"    
stroka134 byte   "                                  sub eax, 2                                                 "    
stroka135 byte   "                                  mov byte ptr [eax], 0 ;eax --> в бойтовом виде -->    "    
stroka136 byte   "                                  invoke atol, addr buf   "    
stroka137 byte   "                        ret "    
stroka138 byte   "                        INPUTint endp "    
strokaG139 byte   "              Русификация p1 сообщения (Старайтесь текстовые перменные ставить одним блоком в .data!!) "    
stroka140 byte   "                        invoke CharToOem, ADDR p1, ADDR p1  "    
strokaG141 byte   "              Смена цвета текста "    
stroka142 byte   "                        ... "    
stroka143 byte   "                        ColorWhite  dd  FOREGROUND_RED + FOREGROUND_GREEN + FOREGROUND_BLUE  ;перменная-цвет"    
stroka144 byte   "                        ... "    
stroka145 byte   "                        invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_RED] "    
stroka146 byte   "                        cout +Этот текст будет красный+ "    
stroka147 byte   "                        invoke  SetConsoleTextAttribute, stdout, [ColorW]  ;для возврата в белый цвет  "    
strokaR148 byte   "    end start "                                                                     

nameProg1  byte "    ####   ######  ##   ## #####   ##           ##   ##  ####    ####   ##   ##"
nameProg2  byte "   ##        ##    ### ### ##  ##  ##           ### ### ##  ##  ##      ### ###"
nameProg3  byte "    ####     ##    ## # ## #####   ##           ## # ## ######   ####   ## # ##"
nameProg4  byte "       ##    ##    ##   ## ##      ##           ##   ## ##  ##      ##  ##   ##"
nameProg5  byte "    ####   ######  ##   ## ##      ######       ##   ## ##  ##   ####   ##   ##"

nameProg6F  byte "Простое приложение для помощи студенту."
nameProg7F  byte "Практика/Теория по языку Ассемблера на MASM32."
nameProg8F  byte "По страницам переключаться по кол-ву введенных символов."
nameProg9F  byte "Присутствует небольшой тест чтобы поупражняться"

nameProg6  byte "   ##  ##     ##         ####      * "
nameProg7  byte "   ##  ##   ####        ##  ##     * "
nameProg8  byte "   ##  ##     ##        ##  ##     * "
nameProg9  byte "    ####      ##        ##  ##     * "
nameProg10 byte "     ##       ##   ##    ####"

lev1  byte "                     ((\/~\/~\/))"
lev2  byte "                   (/~\/~\/~\/~\/\)"
lev3  byte "                 (/~\/~\/~ \/ ~\/~/~\)"
lev4  byte "                (/////   ~   ~   \\\\\)"
lev5  byte "               (\\\\(  (0)   (0)  )////)"
lev6  byte "               (\\\\(     _v_     )////)"
lev7  byte "                 (\\\(     ^    )///)"
lev8  byte "                   (\/~\/~V~V~\/~\/"
lev9  byte "                     (\/ \/~\/ \/)"
lev10 byte "                       |   ?    |"
lev11 byte "                       /|  | |  |\"
lev12 byte "                    _/  |  | |  | \____  _____//"
lev13 byte "                  (,,)  (,,)_(,,)  (,,)--------"

msgAboutAutor byte "Тут должен был быть грозный Лев, но он на работе в 121-5, поэтому тут я"
msgAboutAutor2 byte " (С) Федоричев Лев Александрович специалист УИТИ и студент СПБГАСУ "

clear byte "                                                                                                                                                             "
testStert byte "Если готовы к тесту введите номер вопроса(1-?)..."
testStert2 byte "Чтобы перейти к следующему вопросу введите 1..."

YouWin1   byte  "      ::::::::       ::::::::       ::::::::       :::::::::                                          "
YouWin2   byte  "    :+:    :+:     :+:    :+:     :+:    :+:      :+:    :+:                                          "
YouWin3   byte  "   +:+            +:+    +:+     +:+    +:+      +:+    +:+                                           "
YouWin4   byte  "  :#:            +#+    +:+     +#+    +:+      +#+    +:+                                            "
YouWin5   byte  " +#+   +#+#     +#+    +#+     +#+    +#+      +#+    +#+                                             "
YouWin6   byte  "#+#    #+#     #+#    #+#     #+#    #+#      #+#    #+#                                              "
YouWin7   byte  "########       ########       ########       #########                                                "
YouWin8   byte  "   :::   :::       ::::::::      :::    :::         :::       :::       :::::::::::       ::::    ::: "
YouWin9   byte  "  :+:   :+:      :+:    :+:     :+:    :+:         :+:       :+:           :+:           :+:+:   :+:  "
YouWin10   byte  "  +:+ +:+       +:+    +:+     +:+    +:+         +:+       +:+           +:+           :+:+:+  +:+   "
YouWin11   byte  "  +#++:        +#+    +:+     +#+    +:+         +#+  +:+  +#+           +#+           +#+ +:+ +#+    "
YouWin12   byte  "  +#+         +#+    +#+     +#+    +#+         +#+ +#+#+ +#+           +#+           +#+  +#+#+#     "
YouWin13   byte  " #+#         #+#    #+#     #+#    #+#          #+#+# #+#+#            #+#           #+#   #+#+#      "
YouWin14   byte  "###          ########       ########            ###   ###         ###########       ###    ####       "

qwest byte "    Вопрос :"
ans byte "  Ответ :"
errorQwest byte "Такого вопроса пока нет :)"
wintext byte "Поздравляю, вы закончили тест!"

;Qwestion A
qwest11 byte "    1) Присвойте  16-ому регистру, входящему в eax, представление числа 21(hex) системе счисления."
qwest12 byte "  Умножте его на 2 и присвойте его регистру входящему в edx"
ansLen1 byte "   Ответ в 4 строки"
ans11 byte "        mov ax, 21h"
ans12 byte "        mov bx, 2"
ans13 byte "        mul bx"
ans14 byte "        mov dx, bx"
;Qwestion B
qwest21 byte "    2) С помощью 32-bit accumulator register и base register произведите мат. операцию 10-5 "
qwest22 byte "  ответ оставьте в первом регистре."
ansLen2 byte "   Ответ в 3 строки"
ans21 byte "        mov eax, 10"
ans22 byte "        mov ebx, 5"
ans23 byte "        sub eax, ebx"
;Qwestion C
qwest31 byte "     3) Назовите обозначения основных типов данных в ассемблере и  "
qwest32 byte "   колличество байт отведенных им в порядке убывания. (??{Тип} --> ?{байт})"
ansLen3 byte "   Ответ в 4 строки"
ans31 byte "        DQ --> 8 "
ans32 byte "        DD --> 4"
ans33 byte "        DW --> 2"
ans34 byte "        DB --> 1"
;Qwestion D
qwest41 byte "     4) При выполнении операции деления DIV делимое должно быть расположено  "
qwest42 byte "   в 16-ричном регистре обозначенном как..."
ansLen4 byte "   Ответ в 1 строку"
ans41 byte "        ax "
;Qwestion E
qwest51 byte "     5) Задайте переменные,которые понадобятся для MsgBox в случае использования данных вызовов:  "
qwest52 byte "   invoke wsprintf, addr buf, addr fmt, rez ;где rez - это число"
qwest53 byte "   invoke MessageBox, NULL, addr buf, addr title, MB_OK"
qwest54  byte "    ______________________________                                           Формат ответа как под .data"
qwest55  byte "   | Сколько лет                  |  Заголовок --> Сколько лет                 title... "
qwest56  byte "   |______________________________|                                            fmt...       "
qwest57  byte "   |                              |                                            rez..." 
qwest58  byte "   |  Васе 5 лет                  |  Выведено --> Васе 5 лет                   buf..."
qwest59  byte "   |                     _______  |"
qwest510 byte "   |                    |__OK___| |  Только одна кнопка ОК"
qwest511 byte "   |______________________________|"
ansLen5  byte "   Ответ в 4 строки"
ans51    byte "        title db 'Сколько лет', 0 "
ans52    byte "        fmt db 'Васе %d лет', 0"
ans53    byte "        rez dd 5"
ans54    byte "        buf db 64 dup (?) ; размер может отличаться от 64                      "

;Qwestion F
qwest61 byte "     6) Из списка ниже выберите 8-разрядные регистры и напишите их через запятую :  "
qwest62 byte "   AL,CX,EAX,DH,BL,AH,EDX,ECX"
ansLen6 byte "   Ответ в 1 строку"
ans61 byte "        AL,DH,BL,AH "

;Qwestion G
qwest71 byte "     7) Используя переменные X,A,B,D и регистры AX,BX,CX напишите код ( start:),  "
qwest72 byte "   вычисляющий  X = (A+B)(B-1)/(D+8)."
ansLen7 byte "   Ответ в 9 строк"
ans71   byte  "mov CX,D         ; CX = D"
ans72   byte  "add CX,8         ; CX = D + 8"
ans73   byte  "mov BX,B         ; BX = B"
ans74   byte  "dec BX           ; BX = B - 1"
ans75   byte  "mov AX,A         ; AX = A"
ans76   byte  "add AX,B         ; AX = A + B"
ans77   byte  "mul BX           ; AX = AX * BX = (A + B) * (B - 1)"
ans78   byte  "div CX           ; AX = AX / CX = ((A + B) * (B - 1)) / (D + 8)"
ans79   byte  "mov X,AX         ;X = AX"


.data?                                                       
buf         db    BSIZE dup(?)
stdout      dd    ?                                        
cWritten    dd    ?                                           
stdin       dd    ?
cRead       dd    ?

.code  

printtwo macro p1,p2
  invoke WriteConsole,stdout,ADDR p1,SIZEOF p1,ADDR cWritten,0	
    invoke WriteConsole,stdout,ADDR p2,SIZEOF p2,ADDR cWritten,0

endm

printRed macro p1
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_RED+FOREGROUND_INTENSITY] 
    printtwo p1 ,msg1310 
    invoke  SetConsoleTextAttribute, stdout, [ColorW] 
endm

printBlue macro p1
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_BLUE+FOREGROUND_INTENSITY] 
    printtwo p1 ,msg1310 
    invoke  SetConsoleTextAttribute, stdout, [ColorW] 
endm

printGreen macro p1
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN+FOREGROUND_INTENSITY] 
    printtwo p1 ,msg1310 
    invoke  SetConsoleTextAttribute, stdout, [ColorW] 
endm
;Процедура считывания     
    Read proc
            invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN+FOREGROUND_RED]
            invoke ReadConsole, stdin, ADDR buf, BSIZE, ADDR cRead, NULL   ; Console --> buf --> cRead
            invoke  SetConsoleTextAttribute, stdout, [ColorW]
        ret
    Read endp

;Задать положение курсора
curs macro  x,y
        mov  cx, x ;x
        mov  bx, y ;y
        shl  ebx, 16
        mov  bx, cx
        invoke SetConsoleCursorPosition,stdout,ebx
endm
;Заполнение одного элемента загрузки
drop macro procent,x,sleep
 curs 54,12
            invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN+FOREGROUND_INTENSITY] 
        printtwo download,procent

    curs x,13
            invoke  SetConsoleTextAttribute, stdout, [BACKGROUND_GREEN] 
        printtwo downloadChar2,downloadChar2
            invoke  SetConsoleTextAttribute, stdout, [ColorW] 
        invoke  Sleep, sleep
endm 

;процедура загрузки
DownLoadProgramm proc

        invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN+FOREGROUND_INTENSITY] 
    curs 54,12
            invoke WriteConsole,stdout,ADDR download,SIZEOF download,ADDR cWritten,0

    curs 50,13
            invoke  SetConsoleTextAttribute, stdout, [BACKGROUND_GREEN] 
        printtwo downloadChar2,downloadChar2
            invoke  SetConsoleTextAttribute, stdout, [BackColorW] 
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
        printtwo downloadChar1,downloadChar1
            invoke  SetConsoleTextAttribute, stdout, [NULL] 
        invoke  Sleep, 100

        drop  download20 ,52,200
        drop  download30 ,54,400
        drop  download40 ,56,300
        drop  download50 ,58,200
        drop  download60 ,60,200
        drop  download70 ,62,100
        drop  download80 ,64,50
        drop  download90 ,66,200
        drop  download100 ,68,200

    curs 54,12
        printtwo clear,msg1310
    curs 32,13
        printtwo clear,msg1310
    curs 32,13
    curs 0,0

ret
DownLoadProgramm endp
;Процедура преобразования считанной строки в число 
    INPUTint proc 

                call Read    

                mov eax, offset buf     ;offset buf - это смещение которое было произведено в buf                                  
                add eax, cRead                                            
                sub eax, 2                                                
                mov byte ptr [eax], 0   ;eax --> в бойтовом виде -->                                   

                invoke atol, addr buf  
        ret
    INPUTint endp

;Процедура первого экрана      
SqreenOne proc
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN]
    printtwo msg1310,Sc1
    printtwo msg1310,Sc2
    printtwo msg1310,Sc3
    printtwo msg1310,Sc4
    printtwo msg1310,msg1310
    invoke  SetConsoleTextAttribute, stdout, [ColorW]
    printtwo msg1310,Sc5
    printtwo msg1310,Sc6
    printtwo msg1310,Sc7
    printtwo msg1310,msg1310
    printtwo msg1310,StrokaAssembler1
    printtwo msg1310,StrokaAssembler2
    printtwo msg1310,StrokaAssembler3
    printtwo msg1310,StrokaAssembler4
    printtwo msg1310,StrokaAssembler5
    printtwo msg1310,StrokaAssembler6
    printtwo msg1310,StrokaAssembler7
    printtwo msg1310,StrokaAssembler8
    printtwo msg1310,StrokaAssembler9
    printtwo msg1310,StrokaAssembler10
    printtwo msg1310,msg1310
ret
SqreenOne endp
;процедура об авторе
SqreenAutor proc
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN + FOREGROUND_RED ]
    printtwo msg1310,msg1310
    printtwo msg1310,lev1
    printtwo msg1310,lev2
    printtwo msg1310,lev3
    printtwo msg1310,lev4
    printtwo msg1310,lev5
    printtwo msg1310,lev6
    printtwo msg1310,lev7
    printtwo msg1310,lev8
    printtwo msg1310,lev9
    printtwo msg1310,lev10
    printtwo msg1310,lev11
    printtwo msg1310,lev12
    printtwo msg1310,lev13
    printtwo msg1310,msg1310
    invoke  SetConsoleTextAttribute, stdout, [ColorW]
    printtwo msgAboutAutor,msg1310
    printtwo msgAboutAutor2,msg1310
ret
SqreenAutor endp

;процедура второго экрана
SqreenTwo proc
    invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_RED]
    printtwo msg1310,Siz1
    printtwo msg1310,Siz2
    printtwo msg1310,Siz3
    printtwo msg1310,Siz4
    printtwo msg1310,Siz5
    printtwo msg1310,Siz6
    printtwo msg1310,Siz7

    printtwo msg1310,msg1310

    printtwo msg1310,Siz8
    printtwo msg1310,Siz9
    printtwo msg1310,Siz10
    printtwo msg1310,Siz11
    printtwo msg1310,Siz12
    printtwo msg1310,Siz13
    printtwo msg1310,Siz14
    invoke  SetConsoleTextAttribute, stdout, [ColorW]

    printtwo msg1310 ,msg1310
;Обозначения
    printtwo legend1 ,msg1310
invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_RED+FOREGROUND_INTENSITY] 
printtwo legend2 ,msg1310 
invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_BLUE+FOREGROUND_INTENSITY] 
printtwo legend3 ,msg1310 
invoke  SetConsoleTextAttribute, stdout, [FOREGROUND_GREEN+FOREGROUND_INTENSITY] 
printtwo legend4 ,msg1310  
invoke  SetConsoleTextAttribute, stdout, [ColorW] 
printtwo legend5 ,msg1310 
printtwo msg1310 ,msg1310  

;Файл

printtwo stroka1 , msg1310
printRed strokaR2 
printRed strokaR3 

printRed strokaR4 
printBlue strokaB5 
printGreen strokaG6 
printGreen strokaG7 
printGreen strokaG8 
printGreen strokaG9 

printGreen strokaG10 
printGreen strokaG11 
printGreen strokaG12 
printGreen strokaG13 
printGreen strokaG14 
printGreen strokaG15 
printGreen strokaG16 
printGreen strokaG17 
printBlue strokaB18 
printGreen strokaG19 
printGreen strokaG20 
printGreen strokaG21 

printBlue strokaB22 
printGreen strokaG23 
printGreen strokaG24 
printGreen strokaG25 

printRed strokaR26 
printBlue strokaB27 
printtwo stroka28 , msg1310
printtwo stroka29 , msg1310
printtwo stroka30 , msg1310
printtwo stroka31 , msg1310

printRed strokaR32 

printBlue strokaB33 
printGreen strokaG34 
printGreen strokaG35 
printGreen strokaG36 
printGreen strokaG37 
printGreen strokaG38 
printGreen strokaG39 
printGreen strokaG40 
printGreen strokaG41 
printtwo stroka42 , msg1310
printBlue strokaB43 
printtwo stroka44 , msg1310
printtwo stroka45 , msg1310
printtwo stroka46 , msg1310
printtwo stroka47 , msg1310
printtwo stroka48 , msg1310
printtwo stroka49 , msg1310
printtwo stroka50 , msg1310
printBlue strokaB51 
printtwo stroka52 , msg1310
printtwo stroka53 , msg1310
printtwo stroka54 , msg1310
printtwo stroka55 , msg1310
printtwo stroka56 , msg1310
printtwo stroka57 , msg1310

printtwo stroka58 , msg1310
printBlue strokaB59 
printGreen strokaG60 
printGreen strokaG61 
printGreen strokaG62 
printGreen strokaG63 
printGreen strokaG64 
printGreen strokaG65 
printGreen strokaG66 

printBlue strokaB67 
printtwo stroka68 , msg1310
printGreen strokaG69 
printtwo stroka70 , msg1310
printGreen strokaG71 

printtwo stroka72 , msg1310
printBlue strokaB73 

printtwo stroka74 , msg1310
printtwo stroka75 , msg1310
printtwo stroka76 , msg1310
printtwo stroka77 , msg1310
printtwo stroka78 , msg1310
printtwo stroka79 , msg1310
printtwo stroka80 , msg1310
printtwo stroka81 , msg1310
printBlue strokaB82 
printtwo stroka83 , msg1310
printtwo stroka84 , msg1310
printtwo stroka85 , msg1310
printtwo stroka86 , msg1310
printtwo stroka87 , msg1310
printtwo stroka88 , msg1310
printtwo stroka89 , msg1310
printtwo stroka90 , msg1310
printtwo stroka91 , msg1310
printtwo stroka912 , msg1310
printtwo stroka92 , msg1310
printtwo stroka93 , msg1310
            
printtwo stroka94 , msg1310
printBlue strokaB95 
printGreen strokaG96 
printtwo stroka97 , msg1310
printtwo stroka98 , msg1310
printtwo stroka99 , msg1310
printtwo stroka100 , msg1310
printtwo stroka101 , msg1310
printtwo stroka102 , msg1310
printtwo stroka103 , msg1310

printGreen strokaG104 
printGreen strokaG105 
printGreen strokaG106 
printGreen strokaG107 
printGreen strokaG108 
printGreen strokaG109 

printBlue strokaB110 
printGreen strokaG111 
printtwo stroka112 , msg1310
printtwo stroka113 , msg1310
printtwo stroka114 , msg1310
printtwo stroka115 , msg1310
printtwo stroka116 , msg1310

printGreen strokaG117 
printtwo stroka118 , msg1310
printtwo stroka119 , msg1310

printGreen strokaG120 
printGreen strokaG121 
printtwo stroka122 , msg1310
printtwo stroka123 , msg1310
printtwo stroka124 , msg1310

printtwo stroka125 , msg1310
printtwo stroka126 , msg1310
printtwo stroka127 , msg1310

printGreen strokaG128 
printtwo stroka129 , msg1310
printtwo stroka130 , msg1310
printtwo stroka131 , msg1310
printtwo stroka132 , msg1310
printtwo stroka133 , msg1310
printtwo stroka134 , msg1310
printtwo stroka135 , msg1310
printtwo stroka136 , msg1310
printtwo stroka137 , msg1310
printtwo stroka138 , msg1310
printGreen strokaG139 
printtwo stroka140 , msg1310
printGreen strokaG141 
printtwo stroka142 , msg1310
printtwo stroka143 , msg1310
printtwo stroka144 , msg1310
printtwo stroka145 , msg1310
printtwo stroka146 , msg1310
printtwo stroka147 , msg1310


printRed strokaR148 
ret
SqreenTwo endp

;Для превью
prevew macro p1,p2,p3,p4
            invoke WriteConsole,stdout,ADDR p1,SIZEOF p1,ADDR cWritten,0
            invoke  SetConsoleTextAttribute, stdout, [p3]
            invoke WriteConsole,stdout,ADDR p2,SIZEOF p2,ADDR cWritten,0
            invoke  SetConsoleTextAttribute, stdout, [p4]
            invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0
endm

;Блок выхода из вопроса
exitQwest macro p1
    invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        invoke WriteConsole,stdout,ADDR testStert2,SIZEOF testStert2,ADDR cWritten,0
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        invoke WriteConsole,stdout,ADDR consolePost,SIZEOF consolePost,ADDR cWritten,0 
        mov  eax,4
        call INPUTint
        .if eax ==1
            invoke FreeConsole
                invoke AllocConsole	
                    invoke GetStdHandle, STD_INPUT_HANDLE 
                        mov stdin, eax 
                            invoke GetStdHandle, STD_OUTPUT_HANDLE                    
                                mov stdout, eax  
                                
            invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0

                printtwo m1,char           
                printtwo m2,char

                invoke  SetConsoleTextAttribute, stdout, [ColorB]
                invoke WriteConsole,stdout,ADDR m3,SIZEOF m3,ADDR cWritten,0
                invoke SetConsoleTextAttribute, stdout, [ColorW]
                invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0 

                printtwo m4,char 
                printtwo msg1310,msg1310

            call p1
            ret
        .endif
        invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 
        call menu
endm

    qwestnowA proc
        printtwo qwest,msg1310
        ;Вопрос 
        printtwo qwest11,msg1310
        printtwo qwest12,msg1310
        printtwo ansLen1,msg1310
        printtwo msg1310,msg1310
        ;Ответ пользователя
        call Read
        call Read
        call Read
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        ;Ответ программы
        printtwo ans11,msg1310
        printtwo ans12,msg1310
        printtwo ans13,msg1310
        printtwo ans14,msg1310
        ;Блок прорисовки и переадресации
        exitQwest qwestnowB

    ret
    qwestnowA endp

    qwestnowB proc
        printtwo qwest,msg1310
        printtwo qwest21,msg1310
        printtwo qwest22,msg1310
        printtwo ansLen2,msg1310
        printtwo msg1310,msg1310
        call Read
        call Read
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans21,msg1310
        printtwo ans22,msg1310
        printtwo ans23,msg1310
        exitQwest qwestnowC



    ret
    qwestnowB endp

    qwestnowC proc
        printtwo qwest,msg1310
        printtwo qwest31,msg1310
        printtwo qwest32,msg1310
        printtwo ansLen3,msg1310
        printtwo msg1310,msg1310
        call Read
        call Read
        call Read
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans31,msg1310
        printtwo ans32,msg1310
        printtwo ans33,msg1310
        printtwo ans34,msg1310

        exitQwest qwestnowD


    ret
    qwestnowC endp

    qwestnowD proc
        printtwo qwest,msg1310
        printtwo qwest41,msg1310
        printtwo qwest42,msg1310
        printtwo ansLen4,msg1310
        printtwo msg1310,msg1310
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans41,msg1310

        exitQwest qwestnowE



    ret
    qwestnowD endp

    qwestnowE proc
        printtwo qwest,msg1310        
        printtwo qwest51,msg1310
        printtwo qwest52,msg1310
        printtwo qwest53,msg1310
        printtwo qwest54,msg1310
        printtwo qwest55,msg1310
        printtwo qwest56,msg1310
        printtwo qwest57,msg1310
        printtwo qwest58,msg1310
        printtwo qwest59,msg1310
        printtwo qwest510,msg1310
        printtwo qwest511,msg1310
        printtwo ansLen5,msg1310
        printtwo msg1310,msg1310
        call Read
        call Read
        call Read
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans51,msg1310
        printtwo ans52,msg1310
        printtwo ans53,msg1310
        printtwo ans54, msg1310

        exitQwest qwestnowF



    ret
    qwestnowE endp

    qwestnowF proc
        printtwo qwest,msg1310 
        printtwo qwest61,msg1310
        printtwo qwest62,msg1310
        printtwo ansLen6,msg1310
        printtwo msg1310,msg1310
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans61,msg1310
        exitQwest qwestnowG
    ret
    qwestnowF endp

    qwestnowG proc
        printtwo qwest,msg1310 
        printtwo qwest71,msg1310
        printtwo qwest72,msg1310
        printtwo ansLen7,msg1310
        printtwo msg1310,msg1310
        call Read
        call Read
        call Read
        call Read
        call Read
        call Read
        call Read
        call Read
        call Read
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0 
        printtwo ans,msg1310
        printtwo ans71,msg1310
        printtwo ans72,msg1310
        printtwo ans73,msg1310
        printtwo ans74,msg1310
        printtwo ans75,msg1310
        printtwo ans76,msg1310
        printtwo ans77,msg1310
        printtwo ans78,msg1310
        printtwo ans79,msg1310
        exitQwest ExitTestEnd
    ret
    qwestnowG endp

    ExitTestEnd proc
        invoke WriteConsole,stdout,ADDR msg1310,SIZEOF msg1310,ADDR cWritten,0  

        printtwo wintext,msg1310
        
        printGreen YouWin1
        printGreen YouWin2
        printGreen YouWin3
        printGreen YouWin4
        printGreen YouWin5
        printGreen YouWin6
        printGreen YouWin7
        printGreen YouWin8
        printGreen YouWin9
        printGreen YouWin10
        printGreen YouWin11
        printGreen YouWin12
        printGreen YouWin13
        printGreen YouWin14

        invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 
        call menu
    ret
    ExitTestEnd endp

;Процедура первого начального меню
menuShow proc 

            curs 20,0
            printtwo char,m1            
            printtwo char,m2            
            printtwo char,m3          
            printtwo char,m4
            printtwo char,msg1310 
            printtwo msg1310,msg1310
            
            invoke  SetConsoleTextAttribute, stdout, [ColorB]
            printtwo nameProg1,msg1310 
            printtwo nameProg2,msg1310 
            printtwo nameProg3,msg1310 
            printtwo nameProg4,msg1310 
            printtwo nameProg5,msg1310 
            printtwo msg1310,msg1310

            prevew nameProg6,nameProg6F,FOREGROUND_GREEN,ColorB
            prevew nameProg7,nameProg7F,FOREGROUND_GREEN,ColorB
            prevew nameProg8,nameProg8F,FOREGROUND_GREEN,ColorB
            prevew nameProg9,nameProg9F,FOREGROUND_GREEN,ColorB
            printtwo nameProg10,msg1310 
            printtwo msg1310,msg1310
            invoke  SetConsoleTextAttribute, stdout, [ColorW]
            curs 0,2
            invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 

ret
menuShow endp

menu proc   
            call Read 

            sub cRead, 2
            
            invoke FreeConsole
                invoke AllocConsole	
                    invoke GetStdHandle, STD_INPUT_HANDLE 
                        mov stdin, eax 
                            invoke GetStdHandle, STD_OUTPUT_HANDLE                    
                                mov stdout, eax  
                                
                curs 20,0
            invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0
            .if cRead == 1
            
                invoke  SetConsoleTextAttribute, stdout, [ColorB]
                invoke WriteConsole,stdout,ADDR m1,SIZEOF m1,ADDR cWritten,0
                invoke SetConsoleTextAttribute, stdout, [ColorW]
                invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0 

                printtwo m2,char
                printtwo m3,char
                printtwo m4,char
                printtwo msg1310,msg1310
                call SqreenOne
                curs 0,2
                invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 
            .elseif cRead == 2

                printtwo m1,char   

                invoke  SetConsoleTextAttribute, stdout, [ColorB]
                invoke WriteConsole,stdout,ADDR m2,SIZEOF m2,ADDR cWritten,0
                invoke SetConsoleTextAttribute, stdout, [ColorW]
                invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0 
                
                printtwo m3,char
                printtwo m4,char 
                printtwo msg1310,msg1310
                call SqreenTwo
                curs 0,0
                curs 0,2
                invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 

            .elseif cRead == 3

                printtwo m1,char           
                printtwo m2,char

                invoke  SetConsoleTextAttribute, stdout, [ColorB]
                invoke WriteConsole,stdout,ADDR m3,SIZEOF m3,ADDR cWritten,0
                invoke SetConsoleTextAttribute, stdout, [ColorW]
                invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0 

                printtwo m4,char 
                printtwo msg1310,msg1310

                curs 0,2
                invoke WriteConsole,stdout,ADDR testStert,SIZEOF testStert,ADDR cWritten,0
                curs 0,4
                invoke WriteConsole,stdout,ADDR consolePost,SIZEOF consolePost,ADDR cWritten,0 
                mov eax,4

                call INPUTint

                .if eax == 1
                    call qwestnowA
                    ret
                .elseif eax == 2
                    call qwestnowB
                    ret
                .elseif eax == 3
                    call qwestnowC
                    ret
                .elseif eax == 4
                    call qwestnowD
                    ret
                .elseif eax == 5
                    call qwestnowE
                    ret
                .elseif eax == 6
                    call qwestnowF
                    ret
                .elseif eax == 7
                    call qwestnowG
                    ret
                .else
                    invoke WriteConsole,stdout,ADDR errorQwest,SIZEOF errorQwest,ADDR cWritten,0 
                .endif
                
                invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 
            .elseif cRead == 4

                printtwo m1,char              
                printtwo m2,char
                printtwo m3,char

                invoke  SetConsoleTextAttribute, stdout, [ColorB]
                invoke WriteConsole,stdout,ADDR m4,SIZEOF m4,ADDR cWritten,0
                invoke SetConsoleTextAttribute, stdout, [ColorW]
                invoke WriteConsole,stdout,ADDR char,SIZEOF char,ADDR cWritten,0 

                printtwo msg1310,msg1310

                call SqreenAutor
                curs 0,2
                invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 

                .else
                call menuShow
                curs 0,2
                invoke WriteConsole,stdout,ADDR console,SIZEOF console,ADDR cWritten,0 
            .endif

ret
menu endp
                                           
start:

    invoke AllocConsole	
    invoke GetStdHandle, STD_INPUT_HANDLE 
    mov stdin, eax 
    invoke GetStdHandle, STD_OUTPUT_HANDLE                    
    mov stdout, eax 
    invoke CharToOem, ADDR m1, ADDR m1 
        
        call DownLoadProgramm
        call menuShow                                                        
prog:
         
        call menu     
    jmp   prog                                                                                 

end start      
     
