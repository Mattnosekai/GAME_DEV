#include "mb_sound_lib2.bi"
#include "mb_keyboard_lib2.bi"

'===============================================================================
dim shared as boolean ok

dim shared as integer spos

dim shared as integer hWave(30),sound(30),lasts


function hadoken_motion_check_p1 as integer
'this could also be a function to return if a hadoken motion was done on a joystick    
'facing right
mb_keyboard_buffer_sort  kts_p1(),kb_p1()
dim as integer i,i2,d,dd,f,a,hc,rh1
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
rh1=0
for i=1 to 25

if jb_p1(i)="1006D" then
if jb_p1(i+1)="1006U" and jts_p1(i+1)-jts_p1(i)<=.3 then
if jb_p1(i+2)="1010D" and jts_p1(i+1)-jts_p1(i)<=.3 then    
if jb_p1(i+3)="1010U" and jts_p1(i+1)-jts_p1(i)<=.3 then


for i2=i+4 to 30
'make sure none of the other buttons were pressed after the hadoken motion    
if mid(jb_p1(i2),1,4)="1001" then exit for
if mid(jb_p1(i2),1,4)="1002" then exit for
if mid(jb_p1(i2),1,4)="1003" then exit for

if mid(jb_p1(i2),1,4)="1008" then rh1=i2
if mid(jb_p1(i2),1,4)="1000" and rh1<i2 then hc=1:hct=jts_p1(i2)-jts_p1(rh1):exit for
next
if hc=1 and hct<=.3 then
cls

print "Hadoken!"

play_sound_mc sound(0)
print jb_p1(1)
for i2=2 to 30
print jb_p1(i2),jts_p1(i2)-jts_p1(i2-1)    
next    
cls
mb_jb_clear_p1

hadoken_motion_check_p1=1
exit function
else
    
end if
end if
end if
end if

else
    
end if    
next

hadoken_motion_check_p1=0
end function 
'===============================================================================
function sonicboom_motion_check_p1 as integer
'this could also be a function to return if a sonic boom motion was done on a joystick     
'facing right
dim as integer i,i2,d,dd,f,a,hc,hc2
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
hc2=0



for i=1 to 30
if jb_p1(i)="1007U" or jb_p1(i)="1012U" then    
mb_keyboard_buffer_sort jts_p1(),jb_p1()    
hc2=1
exit for
end if
next

if hc2=1 then
for i=1 to 28
if jb_p1(i)="1007U" or jb_p1(i)="1012U" then

if tts_u_p1j(8)>=1 or tts_u_p1j(13)>=1 then
for i2=i+1 to 30
'make sure none of the other joystick directions were pressed during the sonic boom motion    
if mid(jb_p1(i2),1,4)="1005" then exit for
if mid(jb_p1(i2),1,4)="1006" then exit for
if mid(jb_p1(i2),1,4)="1009" then exit for
if mid(jb_p1(i2),1,4)="1010" then exit for
if mid(jb_p1(i2),1,4)="1011" then exit for


if mid(jb_p1(i2),1,4)="1008" then ft=1:att=jts_p1(i2)-jts_p1(i2-1):exit for
next

for i2=i+1 to 30
'make sure none of the other buttons were pressed after the sonic boom motion      
if mid(jb_p1(i2),1,4)="1000" then exit for
if mid(jb_p1(i2),1,4)="1001" then exit for
if mid(jb_p1(i2),1,4)="1002" then exit for

if mid(jb_p1(i2),1,4)="1003" then hc=1:hct=jts_p1(i2)-jts_p1(i2-1):exit for
next

if hc=1 and hct<=.3 and ft=1 and att<=.1  then
cls

print "Sonic Boom!",tts_u_p1j(8)

play_sound_mc sound(1)

print jb_p1(1)
for i2=2 to 30
print jb_p1(i2),jts_p1(i2)-jts_p1(i2-1)    
next    

tts_u_p1j(8)=0 

cls
mb_jb_clear_p1

sonicboom_motion_check_p1=1
exit function
else

end if


end if
end if
next

end if

sonicboom_motion_check_p1=0
end function
'===============================================================================
sub player1_motions_sub
'house all motion detection functions in a single sub    
if hadoken_motion_check_p1=1 then 
mb_jb_clear_p1 'always clear the buffer after a move
exit sub
end if
if sonicboom_motion_check_p1=1 then 
mb_jb_clear_p1 'always clear the buffer after a move
exit sub
end if
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

'This Demo allows both a fireball motion and a sonic boom motion to be detected with a joystick.
'fireball motion+Button 1 for hadoken
'charge left 1 second then right+Button 3 for sonic boom
'tts_d_p1j(i) is how long the key was held down before being released

dim as string joys(1 to 13) 'temporary array to output different joystick states
joys(1)="BUTTON 1"
joys(2)="BUTTON 2"
joys(3)="BUTTON 3"
joys(4)="BUTTON 4"
joys(5)="JOYSTICK NEUTRAL    "
joys(6)="JOYSTICK UP         "
joys(7)="JOYSTICK DOWN       "
joys(8)="JOYSTICK LEFT       "
joys(9)="JOYSTICK RIGHT      "
joys(10)="JOYSTICK UP RIGHT  "
joys(11)="JOYSTICK DOWN RIGHT"
joys(12)="JOYSTICK UP LEFT   "
joys(13)="JOYSTICK DOWN LEFT "

do
locate 1,1
for i=1 to 13'nok_p1
select case jcs_p1(i)
case 1
print joys(i),"Down      ",jps_p1(i),tts_d_p1j(i)
case 0
print joys(i),"-         ",jps_p1(i),tts_u_p1j(i)
end select
next

player1_motions_sub
p1j_tog="N" 'always set this back to "N" after checking motions

print
for i=1 to 30
print jb_p1(i),str(jts_p1(i))+"                     "
next
loop until inkey = chr(27)
close_sound

