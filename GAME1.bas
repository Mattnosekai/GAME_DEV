#include once "mb_gamedev_lib1.bi"
#include once "mb_sound_lib2.bi"
#include once "mb_accurate_timing_lib.bi"
#include once "mb_keyboard_lib2.bi"

SET_SCREEN 640,480,32, "Fighting Game Demo by Matt B." 

mb_install_keyboard_handler 'this installs the keyboard handler, always call it AFTER setting the screen resolution

prepare_sound 'prepare sound library routines

dim as boolean ok

dim as integer spos

'matt_no_sekai_intro 'Intro Logo & Sound

SUB mb_kb_clear_p1t
'clear Player 1's keyboard buffer timers only
dim as integer i
ibuff_p1_c=1
for i=1 to 30
'kb_p1(i)=""
kts_p1(i)=0
next
END SUB

function hadoken_motion_check_p1 as integer
'this could also be a function to return if a hadoken motion    
'facing right
'mb_keyboard_buffer_sort  kts_p1(),kb_p1()
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
if hc=1 and hct<=.2 then
'cls

'print "Hadoken!"

'play_sound_mc sound(0)
'print kb_p1(1)
'for i2=2 to 30
'print kb_p1(i2),kts_p1(i2)-kts_p1(i2-1)    
'next    
'cls
mb_kb_clear_p1

hadoken_motion_check_p1=1
exit function
end if
end if
end if
end if

else
    
end if    
next

hadoken_motion_check_p1=0
end function 


function shoryuken_motion_check_p1 as integer
'Upper Cut
'this could also be a function to return if a shoruyken motion    
'facing right
'mb_keyboard_buffer_sort  kts_p1(),kb_p1()
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
for i=7 to 30
if kb_p1(i)="39U" then 
if kb_p1(i-1)="39D" or kb_p1(i-1)="40U" and kts_p1(i-1)-kts_p1(i)<=.3 then
if kb_p1(i-2)="40U" or kb_p1(i-2)="39D" and kts_p1(i-2)-kts_p1(i-1)<=.3 then
if kb_p1(i-3)="40D" and kts_p1(i-3)-kts_p1(i-2)<=.3 then
if kb_p1(i-4)="39U" and kts_p1(i-4)-kts_p1(i-3)<=.3 then  
if kb_p1(i-5)="39D" and kts_p1(i-5)-kts_p1(i-4)<=.3 then  
'mb_kb_clear_p1

'shoryuken_motion_check_p1=1
'exit function
for i2=i to 30
if mid(kb_p1(i2),1,2)="83" then exit for
if mid(kb_p1(i2),1,2)="68" then exit for
if mid(kb_p1(i2),1,2)="90" then exit for
if mid(kb_p1(i2),1,2)="88" then exit for
if mid(kb_p1(i2),1,2)="67" then exit for
'make sure none of the other buttons were pressed after the shoruyken motion
if mid(kb_p1(i2),1,2)="65" then hc=1:hct=kts_p1(i2)-kts_p1(i2-1):exit for
next
if hc=1 and hct<=.3 then
'cls

'print "Hadoken!"

'play_sound_mc sound(0)
'print kb_p1(1)
'for i2=2 to 30
'print kb_p1(i2),kts_p1(i2)-kts_p1(i2-1)    
'next    
'cls
mb_kb_clear_p1

shoryuken_motion_check_p1=1
exit function
end if
end if
end if
end if
end if
end if

else
    
end if    
next

shoryuken_motion_check_p1=0 
end function 


dim as integer hWave(30),sound(30),lasts

LOAD_MP3_TO_MEM "sounds/SF_Swing.mp3",hWave(0),sound(0),@sound(0)
LOAD_MP3_TO_MEM "sounds/FF2_KIM.mp3",hWave(1),sound(1),@sound(1)
LOAD_MP3_TO_MEM "sounds/Hadoken1.mp3",hWave(2),sound(2),@sound(2)
LOAD_MP3_TO_MEM "sounds/Jumping.mp3",hWave(3),sound(3),@sound(3)
LOAD_MP3_TO_MEM "sounds/SF_Coin.mp3",hWave(4),sound(4),@sound(4)
LOAD_MP3_TO_MEM "sounds/shoryuken.mp3",hWave(5),sound(5),@sound(5)
LOAD_MP3_TO_MEM "sounds/tatsu.mp3",hWave(6),sound(6),@sound(6)
LOAD_MP3_TO_MEM "sounds/MW_5.mp3",hWave(7),sound(7),@sound(7)
LOAD_MP3_TO_MEM "sounds/Matt_SD1.mp3",hWave(8),sound(8),@sound(8)
LOAD_MP3_TO_MEM "sounds/SF_Ryu.mp3",hWave(9),sound(9),@sound(9)
LOAD_MP3_TO_MEM "MW_1.mp3",hWave(10),sound(10),@sound(10)
LOAD_MP3_TO_MEM "MW_2.mp3",hWave(11),sound(11),@sound(11)
LOAD_MP3_TO_MEM "MW_4.mp3",hWave(12),sound(12),@sound(12)

'LOAD_MP3_TO_MEM "MW_1.mp3",hWave(0),sound(0),@sound(0)
'LOAD_MP3_TO_MEM "MW_2.mp3",hWave(1),sound(1),@sound(1)
'LOAD_MP3_TO_MEM "MW_4.mp3",hWave(3),sound(3),@sound(3)
'LOAD_MP3_TO_MEM "MW_5.mp3",hWave(4),sound(4),@sound(4) 7

matt_no_sekai_intro2 sound(10),sound(11),sound(12),sound(7)

nok_p1=15 'A total of 15 keys are active for Player 1 
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

scan_codes_p1(11)=13 'Enter
scan_codes_p1(12)=32 'Space Bar
scan_codes_p1(13)=76 'L
scan_codes_p1(14)=75 'K
scan_codes_p1(15)=27 'ESC

Dim buffer1 As Any Ptr = ImageCreate( 640, 480, RGB(0, 0, 0) )
Dim toscreen As Any Ptr = ImageCreate( 640, 480, RGB(0, 0, 0) )

dim shared standing_ryu (1 to 6) as sprite

LOAD_SPRITE standing_ryu(1),"graphics/ryu1_0-0.bmp"
LOAD_SPRITE standing_ryu(2),"graphics/ryu1_0-1.bmp"
LOAD_SPRITE standing_ryu(3),"graphics/ryu1_0-2.bmp"
LOAD_SPRITE standing_ryu(4),"graphics/ryu1_0-3.bmp"
LOAD_SPRITE standing_ryu(5),"graphics/ryu1_0-4.bmp"
LOAD_SPRITE standing_ryu(6),"graphics/ryu1_0-5.bmp"

dim shared walkback_ryu (1 to 6) as sprite

LOAD_SPRITE walkback_ryu(1),"graphics/ryu1_21-0.bmp"
LOAD_SPRITE walkback_ryu(2),"graphics/ryu1_21-1.bmp"
LOAD_SPRITE walkback_ryu(3),"graphics/ryu1_21-2.bmp"
LOAD_SPRITE walkback_ryu(4),"graphics/ryu1_21-3.bmp"
LOAD_SPRITE walkback_ryu(5),"graphics/ryu1_21-4.bmp"
LOAD_SPRITE walkback_ryu(6),"graphics/ryu1_21-5.bmp"

dim shared walkforward_ryu (1 to 6) as sprite

LOAD_SPRITE walkforward_ryu(1),"graphics/ryu1_20-0.bmp"
LOAD_SPRITE walkforward_ryu(2),"graphics/ryu1_20-1.bmp"
LOAD_SPRITE walkforward_ryu(3),"graphics/ryu1_20-2.bmp"
LOAD_SPRITE walkforward_ryu(4),"graphics/ryu1_20-3.bmp"
LOAD_SPRITE walkforward_ryu(5),"graphics/ryu1_20-4.bmp"
LOAD_SPRITE walkforward_ryu(6),"graphics/ryu1_20-5.bmp"

dim shared crouch_ryu (1 to 3) as sprite

LOAD_SPRITE crouch_ryu(1),"graphics/ryu1_10-00.bmp"
LOAD_SPRITE crouch_ryu(2),"graphics/ryu1_10-01.bmp"
LOAD_SPRITE crouch_ryu(3),"graphics/ryu1_10-02.bmp"


dim shared jumping_ryu (1 to 7) as sprite

LOAD_SPRITE jumping_ryu(1),"graphics/ryu1_41-0.bmp"
LOAD_SPRITE jumping_ryu(2),"graphics/ryu1_41-1.bmp"
LOAD_SPRITE jumping_ryu(3),"graphics/ryu1_41-2.bmp"
LOAD_SPRITE jumping_ryu(4),"graphics/ryu1_41-3.bmp"
LOAD_SPRITE jumping_ryu(5),"graphics/ryu1_41-4.bmp"
LOAD_SPRITE jumping_ryu(6),"graphics/ryu1_41-5.bmp"
LOAD_SPRITE jumping_ryu(7),"graphics/ryu1_41-6.bmp"

dim shared return_ryu (1 to 3) as sprite

LOAD_SPRITE return_ryu(3),"graphics/ryu1_41-2.bmp"
LOAD_SPRITE return_ryu(2),"graphics/ryu1_41-3.bmp"
LOAD_SPRITE return_ryu(1),"graphics/ryu1_41-4.bmp"

dim shared jumpingforward_ryu (1 to 6) as sprite

LOAD_SPRITE jumpingforward_ryu(1),"graphics/ryu1_42-0.bmp"
LOAD_SPRITE jumpingforward_ryu(2),"graphics/ryu1_42-1.bmp"
LOAD_SPRITE jumpingforward_ryu(3),"graphics/ryu1_42-2.bmp"
LOAD_SPRITE jumpingforward_ryu(4),"graphics/ryu1_42-3.bmp"
LOAD_SPRITE jumpingforward_ryu(5),"graphics/ryu1_42-4.bmp"
LOAD_SPRITE jumpingforward_ryu(6),"graphics/ryu1_42-5.bmp"

dim shared standingpunch_ryu (1 to 3) as sprite

LOAD_SPRITE standingpunch_ryu(1),"graphics/ryu1_210-0.bmp"
LOAD_SPRITE standingpunch_ryu(2),"graphics/ryu1_210-1.bmp"
LOAD_SPRITE standingpunch_ryu(3),"graphics/ryu1_210-0.bmp"

dim shared crouchingpunch_ryu (1 to 5) as sprite

LOAD_SPRITE crouchingpunch_ryu(1),"graphics/ryu1_305-0.bmp"
LOAD_SPRITE crouchingpunch_ryu(2),"graphics/ryu1_305-1.bmp"
LOAD_SPRITE crouchingpunch_ryu(3),"graphics/ryu1_305-2.bmp"
LOAD_SPRITE crouchingpunch_ryu(4),"graphics/ryu1_305-1.bmp"
LOAD_SPRITE crouchingpunch_ryu(5),"graphics/ryu1_305-0.bmp"

dim shared jumpingpunch_ryu (1 to 3) as sprite

LOAD_SPRITE jumpingpunch_ryu(1),"graphics/ryu1_355-0.bmp"
LOAD_SPRITE jumpingpunch_ryu(2),"graphics/ryu1_355-1.bmp"
LOAD_SPRITE jumpingpunch_ryu(3),"graphics/ryu1_355-0.bmp"

dim shared standingkick_ryu (1 to 3) as sprite

LOAD_SPRITE standingkick_ryu(1),"graphics/ryu1_250-0.bmp"
LOAD_SPRITE standingkick_ryu(2),"graphics/ryu1_250-1.bmp"
LOAD_SPRITE standingkick_ryu(3),"graphics/ryu1_250-0.bmp"

dim shared crouchingkick_ryu (1 to 5) as sprite

LOAD_SPRITE crouchingkick_ryu(1),"graphics/ryu1_330-0.bmp"
LOAD_SPRITE crouchingkick_ryu(2),"graphics/ryu1_330-1.bmp"
LOAD_SPRITE crouchingkick_ryu(3),"graphics/ryu1_330-2.bmp"
LOAD_SPRITE crouchingkick_ryu(4),"graphics/ryu1_330-3.bmp"
LOAD_SPRITE crouchingkick_ryu(5),"graphics/ryu1_330-4.bmp"

dim shared jumpingkick_ryu (1 to 3) as sprite

LOAD_SPRITE jumpingkick_ryu(1),"graphics/ryu1_405-0.bmp"
LOAD_SPRITE jumpingkick_ryu(2),"graphics/ryu1_405-1.bmp"
LOAD_SPRITE jumpingkick_ryu(3),"graphics/ryu1_405-0.bmp"

dim shared hadoken_ryu (1 to 8) as sprite

LOAD_SPRITE hadoken_ryu(1),"graphics/ryu1_1200-0.bmp"
LOAD_SPRITE hadoken_ryu(2),"graphics/ryu1_1200-1.bmp"
LOAD_SPRITE hadoken_ryu(3),"graphics/ryu1_1200-2.bmp"
LOAD_SPRITE hadoken_ryu(4),"graphics/ryu1_1200-3.bmp"
LOAD_SPRITE hadoken_ryu(5),"graphics/ryu1_1200-4.bmp"
LOAD_SPRITE hadoken_ryu(6),"graphics/ryu1_1200-5.bmp"
LOAD_SPRITE hadoken_ryu(7),"graphics/ryu1_1200-6.bmp"
LOAD_SPRITE hadoken_ryu(8),"graphics/ryu1_1200-7.bmp"

dim shared fireball (1 to 2) as sprite

LOAD_SPRITE fireball(1),"graphics/ryu1_6110-0.bmp"
'LOAD_SPRITE fireball(2),"graphics/ryu1_6100-1.bmp"
'LOAD_SPRITE fireball(3),"graphics/ryu1_6100-2.bmp"
LOAD_SPRITE fireball(2),"graphics/ryu1_6100-7.bmp"
'LOAD_SPRITE fireball(5),"graphics/ryu1_6110-0.bmp"

dim shared shoryuken_ryu (1 to 6) as sprite

LOAD_SPRITE shoryuken_ryu(1),"graphics/ryu1_1000-0.bmp"
LOAD_SPRITE shoryuken_ryu(2),"graphics/ryu1_1000-1.bmp"
LOAD_SPRITE shoryuken_ryu(3),"graphics/ryu1_1000-2.bmp"
LOAD_SPRITE shoryuken_ryu(4),"graphics/ryu1_1000-3.bmp"
LOAD_SPRITE shoryuken_ryu(5),"graphics/ryu1_1000-4.bmp"
LOAD_SPRITE shoryuken_ryu(6),"graphics/ryu1_1000-5.bmp"

dim shared current_state as string

SUB standing_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Standing Ryu
if current_state="Standing" then exit sub
frame_counts=6
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=standing_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.1
END SUB

SUB walkback_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Walking Backwards
'if current_state="WB" then exit sub
frame_counts=6
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=walkback_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.1
END SUB

SUB walkforward_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Walking Forwards
'if current_state="WF" then exit sub
frame_counts=6
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=walkforward_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.1
END SUB

dim shared input_status as string
dim shared punch_status as string
dim shared kick_status as string
dim shared input_status2 as string

SUB crouch_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Crouching
'if current_state="C" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=crouch_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB jumping_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Jumping Up
'if current_state="J" then exit sub
frame_counts=7
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=jumping_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.1
frame_delays(7)=.1
input_status="OFF"
END SUB

SUB return_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Returning from Being in the Air and Returning to the Ground
'if current_state="A" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=return_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB jumpingforward_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Jumping Forward
'if current_state="JF" then exit sub
frame_counts=6
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=jumpingforward_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.2
input_status="OFF"
END SUB

SUB standingpunch_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Standing Punch
'if current_state="SP" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=standingpunch_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.2
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB crouchingpunch_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Crouching Punch
'if current_state="CP" then exit sub
frame_counts=5
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=crouchingpunch_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.2
frame_delays(4)=.1
frame_delays(5)=.1
input_status="OFF"
END SUB

SUB jumpingpunch_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Jumping Punch
'if current_state="JP" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=jumpingpunch_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.2
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB standingkick_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Standing Kick
'if current_state="SK" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=standingkick_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.2
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB crouchingkick_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Crouching Punch
'if current_state="CK" then exit sub
frame_counts=5
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=crouchingkick_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.25
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
input_status="OFF"
END SUB

SUB jumpingkick_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu Jumping Kick
'if current_state="JK" then exit sub
frame_counts=3
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=jumpingkick_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.2
frame_delays(3)=.1
input_status="OFF"
END SUB

SUB hadoken_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu's Hadoken 
'if current_state="Hadoken" then exit sub
frame_counts=8
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=hadoken_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.1
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.15
frame_delays(7)=.2
frame_delays(8)=.15
input_status="OFF"
END SUB

SUB shoryuken_ryu_call(ani_pointers() as any ptr,frame_delays() as double,byref frame_counts as integer)
'Frame Data for Ryu's Shoryuken Uppercut 
'if current_state="Shoryuken" then exit sub
frame_counts=6
dim i as integer
for i=1 to frame_counts
ani_pointers(i)=shoryuken_ryu(i).spritebuf
next
frame_delays(1)=.1
frame_delays(2)=.1
frame_delays(3)=.4
frame_delays(4)=.1
frame_delays(5)=.1
frame_delays(6)=.1
input_status="OFF"
END SUB

'=====================================================
dim ani_p(1 to 100) as Any Ptr 'animation pointer
dim frame_delay(1 to 100) as double
dim frame_count as integer
'=====================================================
standing_ryu_call ani_p(),frame_delay(),frame_count
current_state="Standing"

dim as string current_state2
current_state2=""

dim tfps as long
tfps=350
dim delay1 as double
delay1=GET_DELAY(tfps) 'Default Target 350 FPS
dim tol1 as double

dim ik as string

dim bgm as string
bgm="ON"
'sleep 2000



dim as integer i,oi,i2,cf,rx,ry,cf2,hx,hy,cff,mnum
dim as double t,st,t2,t3,t4,t5
dim as string r,cs,pk,vector,pvector
cf=1 'current frame index
cf2=1
cff=1 'Current Fireball Frames
t=timer
t2=timer
t3=timer
t4=timer
t5=timer
rx=100
ry=300
vector="G"
input_status="ON"
mnum=1
pvector=vector
dim shared punch as string
dim shared kick as string
punch=""
kick=""
dim as string punch2,punch3,punch4,punch5,bog,hadoken,ftog,shoryuken

dim as string togk,pk2 

dim as string ptsp
togk=""
ptsp=""
bog="Y" 'back on ground
hadoken="N" 'Hadoken Currently Active Y/N
shoryuken="N" 'Shoryuken Currently Active Y/N
do
tol1=TOP_OF_LOOP 'ALWAYS CALL THIS AT THE TOP OF THE MAIN LOOP
'=============================================================
if kcs_p1(8)=1 and input_status="ON" and vector="G" then 'Pressing Left 
if (timer-t3)>.003 then
rx=rx-1
t3=timer
end if
if rx<0 then rx=0
pk="L"
if current_state="WB" then
else
current_state="WB"
cf=1
end if    
else
if pk="L" then current_state="":pk=""    
end if


if kcs_p1(10)=1 and input_status="ON" and vector="G" then 'Pressing Right
if (timer-t3)>.003 then
rx=rx+1
t3=timer
end if
if rx>600 then rx=600
pk="R"
if current_state="WF" then
else
current_state="WF"
cf=1
end if
else
if pk="R" then current_state="":pk=""    
end if


if kcs_p1(9)=1 and vector="G" then 'Pressing Down
input_status="ON"

if pk="D" and current_state="" then
cf=frame_count
if current_state<>"CP" and current_state<>"CK" then current_state="C"
pk="D"
else    
if current_state<>"C" and current_state<>"CP" and current_state<>"CK" then
pk="D"
cf=1
t=timer
current_state="C"
end if
end if
pk="D"

else
if pk="D" and current_state<>"CP" then current_state="":vector="G"
if pk="D" and current_state<>"CK" then current_state="":vector="G"
input_status="ON"
end if


if kcs_p1(7)=1 and kcs_p1(8)=1 and vector="G" and input_status="ON" then 'Jumping Back
pk=""
cf=1
vector="UB"
input_status="OFF"
current_state="JB"
PLAY_SOUND_MC sound(3) 'Jumping Sound
end if

if kcs_p1(7)=1 and kcs_p1(10)=1 and vector="G" and input_status="ON" then 'Jumping Forward
pk=""
cf=1
vector="UF"
input_status="OFF"
current_state="JF"
PLAY_SOUND_MC sound(3) 'Jumping Sound
end if

if kcs_p1(7)=1 and vector="G" and input_status="ON" then 'Jumping
pk=""
cf=1
vector="U"
input_status="OFF"
current_state="J"
PLAY_SOUND_MC sound(3) 'Jumping Sound
end if


'p1kb_tog+" "+keyboard_lks+" "+keyboard_lkp
'if p1kb_tog="Y" then

'if vector="G" and punch="YES" then
'if current_state="Standing" or current_state="" then
'current_state="SP"    
''PLAY_SOUND_MC sound(0) 'Punching Sound    
'punch=""
'end if
'end if
pk2=kb_p1(30)
'if (timer-t4)>=.003 then
mb_keyboard_buffer_sort kts_p1(),kb_p1() 

if vector="G" and hadoken="N" and shoryuken="N" and current_state<>"Hadoken" and current_state<>"Shoryuken" and current_state="Standing" then'and current_state<>"SP" and current_state<>"SK" then
if hadoken_motion_check_p1=1 then
mb_kb_clear_p1    
PLAY_SOUND_MC sound(2) 'Hadoken Sound 
hadoken="Y"
current_state="Hadoken"
punch="NO"
kick="NO"
hx=rx+125
hy=ry+20
cf=1
cff=1
end if
end if

if vector="G" and shoryuken="N" and current_state<>"Hadoken" and current_state<>"Shoryuken" and current_state="Standing" then
if shoryuken_motion_check_p1=1 then
mb_kb_clear_p1    
PLAY_SOUND_MC sound(5) 'Shoryuken Sound 
shoryuken="Y"
current_state="Shoryuken"
punch="NO"
kick="NO"
'hx=rx+125
'hy=ry+20
cf=1
'cff=1
bog="N"
vector="U"
input_status="OFF"
end if
end if


if pk2<>kb_p1(30) then
    togk="Y"
if pk2<>"65D" and kb_p1(30)="65D" then punch="YES":':PLAY_SOUND_MC sound(0)
if pk2<>"83D" and kb_p1(30)="83D" then kick="YES":
else
    togk="N"
if mid(current_state,len(current_state),1)<>"P" then punch="NO"   
if mid(current_state,len(current_state),1)<>"K" then kick="NO" 
end if

't4=timer
'end if
if kick="YES" and vector="G" then 'Standing Kick
if current_state="" or current_state="Standing" or current_state="WB" or current_state="WF" then

pk=""
cf=1
input_status="OFF"
current_state="SK"
PLAY_SOUND_MC sound(3) 'Kicking Sound  
kick="NO"

end if    
end if

if current_state="C" and kick="YES" then 'Crouching Kick
if kcs_p1(9)=1 and kcs_p1(2)=1 then    

pk="D"
cf=1
input_status="OFF"
current_state="CK"
PLAY_SOUND_MC sound(3) 'Kicking Sound 
kick="NO"

end if    
end if


if punch="YES" and vector="G" then 'Standing Punch
if current_state="" or current_state="Standing" or current_state="WB" or current_state="WF" then

pk=""
cf=1
input_status="OFF"
current_state="SP"
PLAY_SOUND_MC sound(0) 'Punching Sound  
punch="NO"

end if    
end if

if current_state="C" and punch="YES" then 'Crouching Punch
if kcs_p1(9)=1 and kcs_p1(1)=1 then    

pk="D"
cf=1
input_status="OFF"
current_state="CP"
PLAY_SOUND_MC sound(0) 'Punching Sound 
punch="NO"

end if    
end if


if punch="YES" and vector<>"G" and current_state<>"JP" and current_state<>"JK" and bog="Y" then 'Jumping Punch
'if mid(current_state,len(current_state),1)="J" or current_state="A" then
if ry<300 then
pk=""
cf2=cf
current_state2=current_state
cf=1
input_status="OFF"
current_state="JP"
PLAY_SOUND_MC sound(0) 'Punching Sound  
bog="N"
punch="NO"
kick="NO"
end if
end if    
'end if

if kick="YES" and vector<>"G" and current_state<>"JP" and current_state<>"JK" and bog="Y" then 'Jumping Kick
'if mid(current_state,len(current_state),1)="J" or current_state="A" then
if ry<300 then
pk=""
cf2=cf
current_state2=current_state
cf=1
input_status="OFF"
current_state="JK"
PLAY_SOUND_MC sound(3) 'Kicking Sound  
kick="NO"
punch="NO"
bog="N"
end if
end if   

'if (timer-t4)>=.003 and input_status="ON" then
'mb_keyboard_buffer_sort kts_p1(),kb_p1() 
'if kb_p1(30)="65D" and punch="" and current_state<>"SP" then
'PLAY_SOUND_MC sound(0) 'Punching Sound
'punch="YES"
'else
''if kb_p1(30)<>"65D" and punch="YES" and current_state<>"SP" then punch=""    
'end if
't4=timer
'end if


'p1kb_tog="N"
'end if

select case current_state
case ""
standing_ryu_call ani_p(),frame_delay(),frame_count
current_state="Standing"
't=timer
if pvector<>"G" then mb_kb_clear_p1 
case "Standing"
standing_ryu_call ani_p(),frame_delay(),frame_count

case "WB"
walkback_ryu_call ani_p(),frame_delay(),frame_count     
case "WF"
walkforward_ryu_call ani_p(),frame_delay(),frame_count 
case "C"
crouch_ryu_call ani_p(),frame_delay(),frame_count 
case "J"
jumping_ryu_call ani_p(),frame_delay(),frame_count  
case "A"
return_ryu_call ani_p(),frame_delay(),frame_count  
case "JF"
jumpingforward_ryu_call ani_p(),frame_delay(),frame_count     
case "JB"
jumpingforward_ryu_call ani_p(),frame_delay(),frame_count  
case "SP"
standingpunch_ryu_call ani_p(),frame_delay(),frame_count
mb_kb_clear_p1
case "CP"
crouchingpunch_ryu_call ani_p(),frame_delay(),frame_count
case "JP"
jumpingpunch_ryu_call ani_p(),frame_delay(),frame_count
case "SK"
standingkick_ryu_call ani_p(),frame_delay(),frame_count
case "CK"
crouchingkick_ryu_call ani_p(),frame_delay(),frame_count
case "JK"
jumpingkick_ryu_call ani_p(),frame_delay(),frame_count
case "Hadoken"
hadoken_ryu_call ani_p(),frame_delay(),frame_count
case "Shoryuken"
shoryuken_ryu_call ani_p(),frame_delay(),frame_count
end select

pvector=vector
if (timer-t2)>=.003 and vector<>"G" and current_state<>"Standing" and current_state<>"" then 'Vector Up to Down
if vector<>"G" then input_status="OFF"
t2=timer    
'if vector="U" and current_state="J" and ry>150 then ry=ry-2    
if vector="U" and current_state<>"Shoryuken" and ry>150 then ry=ry-2
'if ry<=150 and cf=frame_count then vector="D"':current_state="A":cf=1
if ry<=150 and current_state="J" and cf>frame_count then vector="D":current_state="A":cf=1 
'if vector="D" and current_state="A" then ry=ry+2
if vector="D" and ry<300 then ry=ry+2
if vector="D" and ry>=300 then ry=300:vector="G":input_status="ON":current_state="":cf=1:bog="Y"
'if vector="D" and current_state="A" and ry>=300 then ry=300
if vector="D" and current_state="A" and cf>=frame_count and ry>=300 then ry=300:vector="G":input_status="ON":current_state="":cf=1:bog="Y":mb_kb_clear_p1 

'if vector="UF" and current_state="JF" and ry>150 then ry=ry-2
'if vector="UF" and current_state="JF" and rx<600 then rx=rx+2    
if vector="UF" and ry>150 then ry=ry-2
if vector="UF" and rx<600 then rx=rx+1
'if vector="UF" and ry<=150 then vector="DF"':current_state="A":cf=1
if ry<=150 and current_state="JF" and cf>frame_count then vector="DF":current_state="A":cf=1    
if current_state="JF" and cf>=frame_count then cf=frame_count    

if vector="DF" then ry=ry+2
if vector="DF" then rx=rx+1
'if vector="DF" and current_state="A" and ry>=300 then ry=300
if vector="DF" and rx>=600 then rx=600
if vector="DF" and ry>=300 then ry=300
'if vector="DF" and ry>=300 then ry=300:vector="G":input_status="ON":current_state="":cf=1
if vector="DF" and current_state="A" and cf>=frame_count and ry>=300 then ry=300:vector="G":input_status="ON":current_state="":cf=1:bog="Y":mb_kb_clear_p1 
if current_state="A" and cf>=frame_count then cf=frame_count 

'if vector="UB" and current_state="JB" and ry>150 then ry=ry-2
'if vector="UB" and current_state="JB" and rx>0 then rx=rx-2    
if vector="UB" and ry>150 then ry=ry-2
if vector="UB" and rx>0 then rx=rx-1

'if vector="UB" and current_state<>"JB" and ry<=150 then vector="DB":current_state="A":cf=1
if ry<=150 and current_state="JB" and cf>frame_count then vector="DB":current_state="A":cf=1    

if current_state="JB" and cf>=frame_count then cf=frame_count 

if vector="DB" then ry=ry+2
if vector="DB" then rx=rx-1
if vector="DB" and rx<=0 then rx=0
if vector="DB" and ry>=300 then ry=300
'if vector="DF" and current_state="A" and ry>=300 then ry=300
if vector="DB" and current_state="A" and rx<=0 then rx=0
if vector="DB" and current_state="A" and cf>=frame_count and ry>=300 then ry=300:vector="G":input_status="ON":current_state="":cf=1:bog="Y":mb_kb_clear_p1 

end if    



if (timer-t)>=frame_delay(cf) then
 
if current_state="C" and cf=frame_count then 
else
if current_state="J" and cf>frame_count then
    else
if current_state="A" and cf=frame_count then
    else
cf=cf+1
if cf>frame_count and current_state="JP" then cf=1:current_state="A":vector="D"'current_state2
if cf>frame_count and current_state="JK" then cf=1:current_state="A":vector="D"'current_state2
if cf>frame_count and vector="G" and current_state="CP" then current_state="C":cf=3'frame_count
if cf>frame_count and vector="G" and current_state="CK" then current_state="C":cf=3'frame_count
if cf>frame_count and vector="G" then current_state="":cf=1
t=timer
end if
end if
end if
end if



'if hadoken="Y" and current_state="Hadoken" and cf>=3 then
'put toscreen,(rx,ry),ani_p(cf),Trans
''if cff>1 then cff=1
'if cff<3 then hx=hx+1
'put toscreen,(hx-10,hy-8),fireball(cff).spritebuf,Trans
'if (timer-t5)>=.1 then 
'cff=cff+1
'if cff>3 then cff=3
't5=timer:hx=hx+6
'end if
'else
    
'if hadoken="Y" and current_state<>"Hadoken" then

'if (timer-t5)>=.01 then
'if cff=1 then
'    cff=cff+1
'    hx=hx+3
'    t5=timer
'    else
'if cff>=5 then
'    cff=4
'else
'    cff=5
'end if  
'end if
't5=timer
'hx=hx+3
'end if
'if hx>=660 then hadoken="N":mb_kb_clear_p1
'put toscreen,(hx,hy),fireball(cff).spritebuf,Trans
'end if
put toscreen,(0,0),buffer1,PSET

if hadoken="Y" and current_state<>"Hadoken" then
if (timer-t5)>=.01 then
t5=timer
hx=hx+3
if cff=2 then
    cff=1
else
    cff=2
end if
end if
if hx>=660 then hadoken="N":mb_kb_clear_p1
if current_state="Shoryuken" and cf=3 then ry=ry-1
if cf<=frame_count then put toscreen,(rx,ry),ani_p(cf),Trans
put toscreen,(hx,hy),fireball(cff).spritebuf,Trans
if current_state="Shoryuken" and cf>=frame_count then current_state="A":vector="D":shoryuken="N":input_status="ON"
else

if hx>=660 then hadoken="N"
if current_state="Shoryuken" and cf=3 then ry=ry-1
if cf<=frame_count then put toscreen,(rx,ry),ani_p(cf),Trans
if current_state="Shoryuken" and cf>=frame_count then current_state="A":vector="D":shoryuken="N":input_status="ON"
end if

draw string toscreen,(0,0),vector+" "+current_state+" "+str(cf)+" "+str(frame_count)+"   "+str(rx)+" "+str(ry)+" "+current_state2
'draw string toscreen,(0,30),p1kb_tog+" "+keyboard_lks+" "+keyboard_lkp
'if p1kb_tog="Y" then p1kb_tog="N"
draw string toscreen,(0,30),punch+" "+kb_p1(30)+" "+togk

if hadoken="Y" or shoryuken="Y" then
draw string toscreen,(0,50),str(hx)+" "+str(cff)+" "+current_state+" "+str(cf)    
'put toscreen,(hx,hy),fireball(cff),Trans
end if    

put (0,0),toscreen,PSET



'=============================================================
'ik=inkey
if bgm="ON" then
if IS_PLAYING(sound(mnum))="NO" then
PLAY_SOUND sound(mnum)    
end if    
else
STOP_SOUND sound(mnum)    
end if

ik=""
if kcs_p1(11)=1 then ik=chr(13):kcs_p1(11)=0
if kcs_p1(12)=1 then ik=chr(32):kcs_p1(12)=0
if kcs_p1(13)=1 then ik=chr(76):kcs_p1(13)=0
if kcs_p1(14)=1 then ik=chr(75):kcs_p1(14)=0
if kcs_p1(15)=1 then ik=chr(27):kcs_p1(15)=0

select case ik
case "L"
if mnum=1 then
    mnum=9
else
  mnum=1
end if
case "K"'chr(77)
'M BGM On/Off  
if bgm="ON" then 
bgm="OFF"
else    
bgm="ON"    
end if    
case chr(32)
'SPC Bar Software Demonstration By Matt Sound    
PLAY_SOUND_MC sound(8)
case chr(49)
'1 Coin Sound  
PLAY_SOUND_MC sound(4)
case chr(13)
'Enter Matt's World Sound  
PLAY_SOUND_MC sound(7)
end select    
'=============================================================
LOOP_SLEEP tol1,delay1 'ALWAYS CALL THIS AT THE BOTTOM OF THE MAIN LOOP
loop until ik=chr(27)

close_sound 'close the sound library

