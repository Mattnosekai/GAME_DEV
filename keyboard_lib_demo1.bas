#include "mb_keyboard_lib1.bi"

screenres 640,480,32

mb_install_keyboard_handler 'this installs the keyboard handler, always call it AFTER setting the screen resolution

dim as integer i


nok_p1=10 'A total of 10 keys are active for Player 1 
scan_codes_p1(1)=65 'A
scan_codes_p1(2)=83 'S
scan_codes_p1(3)=68 'D
scan_codes_p1(4)=90 'Z
scan_codes_p1(5)=88 'X
scan_codes_p1(6)=67 'C
scan_codes_p1(7)=38 'Up
scan_codes_p1(8)=37 'Left
scan_codes_p1(9)=40 'Down
scan_codes_p1(10)=39 'Right

'this Demo just show the state of the keys and the buffer for Player 1
'tts_d_p1(i) is how long the key was held down before being released

do
locate 1,1
for i=1 to nok_p1
select case kcs_p1(i)
case 1
? scan_codes_p1(i),"Down      ",kps_p1(i),tts_d_p1(i)
case 0
? scan_codes_p1(i),"-         ",kps_p1(i),tts_u_p1(i)
end select
next
?
for i=1 to 30
? kb_p1(i),str(kts_p1(i))+"                     "
next
loop until inkey = chr(27)
