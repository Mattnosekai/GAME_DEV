#include "mb_sound_lib2.bi"
#include "mb_keyboard_lib1.bi"

'===============================================================================
dim shared as boolean ok

dim shared as integer spos

dim shared as integer hWave(30),sound(30),lasts


function hadoken_motion_check_p1 as integer
'this could also be a function to return if a hadoken motion    
'facing right
mb_keyboard_buffer_sort  kts_p1(),kb_p1()
dim as integer i,i2,d,dd,f,a,hc
dim as double dt,ddt,ft,att,hct
d=0 'down
dd=0 'down diagnal down & forward at the same time
f=0 'forward
a=0 'a button
dt=0
ddt=0
ft=0
att=0
hc=0
hct=0
for i=1 to 26
if kb_p1(i)="40D" then 
if kb_p1(i+1)="39D" and kts_p1(i+1)-kts_p1(i)<=.12 then
if kb_p1(i+2)="40U" and kts_p1(i+2)-kts_p1(i+1)<=.12 then
if kb_p1(i+3)="39U" and kts_p1(i+3)-kts_p1(i+2)<=.12 then

for i2=i+4 to 30
if mid(kb_p1(i2),1,2)="83" then exit for
if mid(kb_p1(i2),1,2)="68" then exit for
if mid(kb_p1(i2),1,2)="90" then exit for
if mid(kb_p1(i2),1,2)="88" then exit for
if mid(kb_p1(i2),1,2)="67" then exit for
'make sure none of the other buttons were pressed after the hadoken motion
if mid(kb_p1(i2),1,2)="65" then hc=1:hct=kts_p1(i2)-kts_p1(i2-1):exit for
next
if hc=1 and hct<=.05 then
cls

? "Hadoken!"

play_sound_mc sound(0)
? kb_p1(1)
for i2=2 to 30
? kb_p1(i2),kts_p1(i2)-kts_p1(i2-1)    
next    
cls
mb_kb_clear_p1
'exit sub
'return 1
hadoken_motion_check_p1=1
exit function
end if
end if
end if
end if

else
    
end if    
next
'return 0
hadoken_motion_check_p1=0
end function 
'===============================================================================
function sonicboom_motion_check_p1 as integer
'this could also be a function to return if a sonic boom motion    
'facing right
dim as integer i,i2,d,dd,f,a,hc
dim as double dt,ddt,ft,att,hct
d=0 'down
dd=0 'down diagnal down & forward at the same time
f=0 'forward
a=0 'a button
dt=0
ddt=0
ft=0
att=0
hc=0
hct=0



if tts_u_p1(8)>=1 then

mb_keyboard_buffer_sort kts_p1(),kb_p1()    

for i=1 to 29
if kb_p1(i)="37U" or kb_p1(i)="37D" then

for i2=i+2 to 30
if mid(kb_p1(i2),1,2)="38" then exit for
if mid(kb_p1(i2),1,2)="40" then exit for

if mid(kb_p1(i2),1,2)="39" then ft=1:att=kts_p1(i2)-kts_p1(i2-1):exit for
next

for i2=i+2 to 30
if mid(kb_p1(i2),1,2)="65" then exit for
if mid(kb_p1(i2),1,2)="68" then exit for
if mid(kb_p1(i2),1,2)="90" then exit for
if mid(kb_p1(i2),1,2)="88" then exit for
if mid(kb_p1(i2),1,2)="67" then exit for

if mid(kb_p1(i2),1,2)="83" then hc=1:hct=kts_p1(i2)-kts_p1(i2-1):exit for
next

if hc=1 and hct<=.1 and ft=1 and att<=.1  then
cls
'color 10,0
? "Sonic Boom!",tts_u_p1(8)

play_sound_mc sound(1)

? kb_p1(1)
for i2=2 to 30
? kb_p1(i2),kts_p1(i2)-kts_p1(i2-1)    
next    

tts_u_p1(8)=0 

cls
mb_kb_clear_p1

sonicboom_motion_check_p1=1
exit function
end if
end if


next
end if    
sonicboom_motion_check_p1=0
end function
'===============================================================================
sub player1_motions_sub
'house all motion detection functions in a single sub    
if hadoken_motion_check_p1=1 then exit sub
if sonicboom_motion_check_p1=1 then exit sub
end sub
'===============================================================================
screenres 640,480,32

mb_install_keyboard_handler 'this installs the keyboard handler, always call it AFTER setting the screen resolution



prepare_sound



LOAD_MP3_TO_MEM "sounds/Hadoken1.mp3",hWave(0),sound(0),@sound(0)
LOAD_MP3_TO_MEM "sounds/sonicboom.mp3",hWave(1),sound(1),@sound(1)

play_sound sound(0)
play_sound sound(1)

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

'this Demo allows both a fireball motion and a sonic boom motion to be detected
'fireball motion+A for hadoken
'charge left 1 second then right+S for sonic boom
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
if p1kb_tog="Y" then
player1_motions_sub
p1kb_tog="N" 'always set this back to "N" after checking motions
end if
?
for i=1 to 30
? kb_p1(i),str(kts_p1(i))+"                     "
next
loop until inkey = chr(27)
close_sound

