#include "mb_keyboard_lib2.bi"

screenres 640,480,32


mb_install_keyboard_handler 'this installs the keyboard handler, always call it AFTER setting the screen resolution

dim as integer i,i2


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
'This Demo shows the state of the joystick and the buffer for Player 1
'tts_d_p1(i) is how long the key was held down before being released


do
locate 1,1

for i=13 to 1 step -1
if i=4 then print
select case jcs_p1(i)
case 1
if i>=5 then 'Display Buttons 1 to 4 status
print
print joys(i),"Down      ",jps_p1(i),tts_d_p1j(i)
else
print joys(i),"Down      ",jps_p1(i),tts_d_p1j(i)
end if    
case 0
if i>=5 then 'Display Joystick Current State. 9 possible states total.
print
print joys(i),"-         ",jps_p1(i),tts_u_p1j(i)
else
print joys(i),"-        ",jps_p1(i),tts_u_p1j(i)
end if      

end select
next
print
print "Buffer=" 'Show Input Buffer
for i=1 to 30
i2=val(mid(jb_p1(i),1,4))
i2=i2-1000
i2=i2+1
print joys(i2),jb_p1(i),str(jts_p1(i))+"           " 
next
loop until inkey = chr(27)
