#include Once "vbcompat.bi"
#include once "fbgfx.bi"
#include "mb_sound_lib2.bi"
#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

declare sub DEMO(sounds() as integer,hWave1() as integer)

prepare_sound

dim as boolean ok

dim as integer spos

dim as integer hWave(30),sound(30),lasts
dim i as integer
color 10,0
? "Loading"
LOAD_MP3_TO_MEM "sounds/Hadoken1.mp3",hWave(0),sound(0),@sound(0) '0 3 8 12 13 16 17 18 19 
locate 1,8:? "."
LOAD_MP3_TO_MEM "sounds/SF_NewC.mp3",hWave(1),sound(1),@sound(1)
locate 1,8:? ".."
LOAD_MP3_TO_MEM "sounds/skick.mp3",hWave(2),sound(2),@sound(2)
locate 1,8:? "..."
LOAD_MP3_TO_MEM "sounds/sonicboom.mp3",hWave(3),sound(3),@sound(3) 
locate 1,8:? "...."
LOAD_MP3_TO_MEM "sounds/t_horn1.mp3",hWave(4),sound(4),@sound(4)
locate 1,8:? "....."
LOAD_MP3_TO_MEM "sounds/VideoSystem.mp3",hWave(5),sound(5),@sound(5)
locate 1,8:? "......"
LOAD_MP3_TO_MEM "sounds/sf2d_ken.mp3",hWave(6),sound(6),@sound(6)
locate 1,8:? "......."
LOAD_MP3_TO_MEM "sounds/sf_vs.mp3",hWave(7),sound(7),@sound(7)
locate 1,8:? "........"
LOAD_MP3_TO_MEM "sounds/sf_swing.mp3",hWave(8),sound(8),@sound(8)
locate 1,8:? "........."
LOAD_MP3_TO_MEM "sounds/sf_selecting.mp3",hWave(9),sound(9),@sound(9)
locate 1,8:? ".........."
LOAD_MP3_TO_MEM "sounds/sf_selected.mp3",hWave(10),sound(10),@sound(10)
locate 1,8:? "..........."
LOAD_MP3_TO_MEM "sounds/sf_ranking.mp3",hWave(11),sound(11),@sound(11)
locate 1,8:? "............"
LOAD_MP3_TO_MEM "sounds/sf_punch.mp3",hWave(12),sound(12),@sound(12)
locate 1,8:? "............."
LOAD_MP3_TO_MEM "sounds/sf_glass.mp3",hWave(13),sound(13),@sound(13)
locate 1,8:? ".............."
LOAD_MP3_TO_MEM "sounds/sf_game_over.mp3",hWave(14),sound(14),@sound(14)
locate 1,8:? "..............."
LOAD_MP3_TO_MEM "sounds/sf_coin.mp3",hWave(15),sound(15),@sound(15)
locate 1,8:? "................"
LOAD_MP3_TO_MEM "sounds/sf_box.mp3",hWave(16),sound(16),@sound(16)
locate 1,8:? "................."
LOAD_MP3_TO_MEM "sounds/sf_block.mp3",hWave(17),sound(17),@sound(17)
locate 1,8:? ".................."
LOAD_MP3_TO_MEM "sounds/sf_barrel2.mp3",hWave(18),sound(18),@sound(18)
locate 1,8:? "..................."
LOAD_MP3_TO_MEM "sounds/sf_barrel.mp3",hWave(19),sound(19),@sound(19)
locate 1,8:? "...................."
LOAD_MP3_TO_MEM "sounds/ntm_otg.mp3",hWave(20),sound(20),@sound(20)
locate 1,8:? "....................."
LOAD_MP3_TO_MEM "sounds/ntm_bt.mp3",hWave(21),sound(21),@sound(21)
locate 1,8:? "......................"
LOAD_MP3_TO_MEM "sounds/ng_coin.mp3",hWave(22),sound(22),@sound(22)
locate 1,8:? "......................."
LOAD_MP3_TO_MEM "sounds/missile2.mp3",hWave(23),sound(23),@sound(23)
locate 1,8:? "........................"
LOAD_MP3_TO_MEM "sounds/missile1.mp3",hWave(24),sound(24),@sound(24)
locate 1,8:? "........................."
LOAD_MP3_TO_MEM "sounds/KIM_WON.mp3",hWave(25),sound(25),@sound(25)
locate 1,8:? ".........................."
LOAD_MP3_TO_MEM "sounds/gong2.mp3",hWave(26),sound(26),@sound(26)
locate 1,8:? "..........................."
LOAD_MP3_TO_MEM "sounds/genan.mp3",hWave(27),sound(27),@sound(27)
locate 1,8:? "............................"
LOAD_MP3_TO_MEM "sounds/fh_cs.mp3",hWave(28),sound(28),@sound(28)
locate 1,8:? "............................."
LOAD_MP3_TO_MEM "sounds/FFBS.mp3",hWave(29),sound(29),@sound(29)
locate 1,8:? ".............................."
LOAD_MP3_TO_MEM "sounds/DJS_Changeling.mp3",hWave(30),sound(30),@sound(30) 
locate 1,8:? "..............................."
cls
? "[MB Sound Lib v2.0 Demo]"
?
? "1=Start Demo"
? "2=Cycle Through All Sounds"
? "S=Stop Current Sound"
? "ENTER=Echo/Repeat Current Sound"
? "ESC=Exit"
?
? "3=Hadoken 4=SF_NewC 5=Soccer Kick 6=Sonic Boom 7=Train Horn"
? "8=VideoSystem 9=SF2D_Ken 0=SF_VS A=Swing D=Selecting"
? "F=Selected G=SF_Ranking H=Punch J=Glass"
? "K=Game Over U=SF_Coin I=Box L=Block Z=Barrel2 X=Barrel1"
? "C=On The Green! V=Birdie Try B=NG_Coin N=M1 Y=M2"
? "M=KIM WON! Q=gong2 W=Gen-An Theme E=FH_CS Theme"
? "R=FFBS Theme T=DJS_Changeling Theme"

do
select case ucase(inkey)
case "1"
DEMO sound(),hWave()    
case "2"
for i=0 to 30
select case i
case 4
case 6
case 27
case 28 
case 29    
case 30    
case else    
play_sound sound(i)
do
'if IS_PLAYING(sound(i))="NO" then exit do    
loop until IS_PLAYING(sound(i))="NO"
end select
next
for i=0 to 30
select case i
case 4
case 6
case 27
case 28 
case 29    
case 30    
case else    
play_sound sound(i)
end select
next
for i=30 to 0 step -1
select case i
case 4
case 6
case 27
case 28 
case 29    
case 30    
case else   
sleep 500    
play_sound sound(i)
end select
next
sleep
for i=0 to 30
if IS_PLAYING(sound(i))="YES" then
STOP_SOUND sound(i)
end if    
next
case "S"
if IS_PLAYING(sound(lasts))="YES" then
STOP_SOUND sound(lasts)
end if
case chr(27)
close_sound
end
case chr(13)
PLAY_SOUND_MC sound(lasts)    
case "3"
lasts=0
play_sound sound(lasts)
case "4"
lasts=1    
play_sound sound(lasts)
case "5"
lasts=2    
play_sound sound(lasts)
case "6"
lasts=3
play_sound sound(lasts)
case "7"
lasts=4
play_sound sound(lasts)
case "8"    
lasts=5
play_sound sound(lasts)
case "9"
lasts=6
play_sound sound(lasts)
case "0"
lasts=7
play_sound sound(lasts)
case "A"
lasts=8
play_sound sound(lasts)
case "D"
lasts=9
play_sound sound(lasts)
case "F"
lasts=10
play_sound sound(lasts)
case "G"
lasts=11
play_sound sound(lasts)
case "H"
lasts=12
play_sound sound(lasts)
case "J"
lasts=13
play_sound sound(lasts)
case "K"
lasts=14
play_sound sound(lasts)
case "U"
lasts=15
play_sound sound(lasts)
case "I"    
lasts=16
play_sound sound(lasts)
case "L"
lasts=17
play_sound sound(lasts)
case "Z"
lasts=18
play_sound sound(lasts)
case "X"
lasts=19
play_sound sound(lasts)
case "C"
lasts=20
play_sound sound(lasts)
case "V"
lasts=21
play_sound sound(lasts)
case "B"
lasts=22
play_sound sound(lasts)
case "N" 
lasts=23
play_sound sound(lasts)
case "Y"
lasts=24
play_sound sound(lasts)
case "M"
lasts=25
play_sound sound(lasts)
case "Q"
lasts=26
play_sound sound(lasts)
case "W"
lasts=27
play_sound sound(lasts)
case "E"
lasts=28
play_sound sound(lasts)
case "R"
lasts=29
play_sound sound(lasts)
case "T"    
lasts=30 
play_sound sound(lasts)
end select
loop


SUB DEMO(sounds() as integer,hWave1() as integer)
dim i as integer    
   
color 15,0
? "Let's put a coin in the get things started!"
play_sound sounds(22)
do
loop until IS_PLAYING(sounds(22))="NO"     
? "How about another coin?"
play_sound sounds(15)
do
loop until IS_PLAYING(sounds(15))="NO" 
color 7,0
? "Hadoken!"
play_sound sounds(0)
do
loop until IS_PLAYING(sounds(0))="NO" 
color 14,0
? "Sonic Boom!"
play_sound sounds(3)
do
loop until IS_PLAYING(sounds(3))="NO" 
color 10,0
? "Hadoken & Sonic Boom!"
play_sound sounds(0)
play_sound sounds(3)
do
loop until IS_PLAYING(sounds(3))="NO" 
color 11,0
? "2 Hadokens at the same time!"
play_sound sounds(0)
sleep 100
play_sound_mc sounds(0)
do
loop until IS_PLAYING(sounds(0))="NO"
? "Hadoken Battle!"
for i=1 to 6
play_sound sounds(0)
sleep 100
play_sound_mc sounds(0)
do
loop until IS_PLAYING(sounds(0))="NO"
next
color 14,0
? "Sonic Boom Battle!"
for i=1 to 2
play_sound sounds(3)
sleep 100
play_sound_mc sounds(3)
do
loop until IS_PLAYING(sounds(3))="NO"
next
color 11,0
? "Play Multiple Copies of the Same Sound Without Restarting"
color 10,0
? "KIM WON!"
play_sound sounds(25)
do
loop until IS_PLAYING(sounds(25))="NO"
dim z as string
z="!"
for i=1 to 20
? "KIM WON"+z
z=z+"!"
play_sound_mc sounds(25)
sleep 500
next
sleep 3000
color 10,2
? "ON THE GREEN!"
play_sound sounds(20)
do
loop until IS_PLAYING(sounds(20))="NO"
z="!"
for i=1 to 20
? "ON THE GREEN"+z
z=z+"!"
play_sound_mc sounds(20)
sleep 400
next
sleep 500
play_sound sounds(20)
do
loop until IS_PLAYING(sounds(20))="NO"
sleep 1000
color 13,2
? "BIRDIE TRY!"
play_sound sounds(21)
do
loop until IS_PLAYING(sounds(21))="NO"
z="!"
for i=1 to 20
? "BIRDIE TRY"+z
z=z+"!"
play_sound_mc sounds(21)
sleep 500
next
sleep 500
play_sound sounds(21)
do
loop until IS_PLAYING(sounds(21))="NO"
sleep 2000
color 15,13
? "VideoSystem!"
play_sound sounds(5)
do
loop until IS_PLAYING(sounds(5))="NO"
? "VideoSystem!"
play_sound sounds(5)
do
loop until IS_PLAYING(sounds(5))="NO"
? "VideoSystem!"
play_sound sounds(5)
do
loop until IS_PLAYING(sounds(5))="NO"
z="!"
for i=1 to 20
? "VideoSystem"+z
z=z+"!"
play_sound_mc sounds(5)
sleep 600
next
sleep 1000
play_sound sounds(5)
do
loop until IS_PLAYING(sounds(5))="NO"
sleep 4000
color 14,0
? "Play some background music while playing sound fx"
'0 3 8 12 13 16 17 18 19 26  6 28
play_sound sounds(28) 
randomize timer
dim n as integer
sleep 6000
do
n=int(rnd*21)
sleep 500
select case n
case 0 to 3
if IS_PLAYING(sounds(0))="NO" then play_sound sounds(0)
case 4 to 7
if IS_PLAYING(sounds(3))="NO" then play_sound sounds(3)    
case 8 to 11
if IS_PLAYING(sounds(8))="NO" then play_sound sounds(8)
case 12 to 15
if IS_PLAYING(sounds(12))="NO" then play_sound sounds(12)
case 16
if IS_PLAYING(sounds(13))="NO" then play_sound sounds(13)
case 17
if IS_PLAYING(sounds(16))="NO" then play_sound sounds(16)
case 18
if IS_PLAYING(sounds(17))="NO" then play_sound sounds(17)
case 19
if IS_PLAYING(sounds(18))="NO" then play_sound sounds(18)
case 20
if IS_PLAYING(sounds(19))="NO" then play_sound sounds(19)
case 21    
if IS_PLAYING(sounds(26))="NO" then play_sound sounds(26)
end select
if inkey=chr(13) then stop_sound sounds(28):exit do
loop until IS_PLAYING(sounds(28))="NO"

dim t as single
t=timer
do
n=int(rnd*30)
sleep 250
select case n
case 0 to 3
if IS_PLAYING(sounds(17))="NO" then play_sound sounds(17)
case 4 to 7
if IS_PLAYING(sounds(9))="NO" then play_sound sounds(9)    
case 8 to 11
if IS_PLAYING(sounds(8))="NO" then play_sound sounds(8)
case 12 to 15
if IS_PLAYING(sounds(10))="NO" then play_sound sounds(10)
case 16
if IS_PLAYING(sounds(11))="NO" then play_sound sounds(11)
case 17
if IS_PLAYING(sounds(14))="NO" then play_sound sounds(14)
case 18
if IS_PLAYING(sounds(2))="NO" then play_sound sounds(2)
case 19
if IS_PLAYING(sounds(16))="NO" then play_sound sounds(16)
case 20
if IS_PLAYING(sounds(13))="NO" then play_sound sounds(13)
case 21    
if IS_PLAYING(sounds(7))="NO" then play_sound sounds(7)
case 24    
if IS_PLAYING(sounds(26))="NO" then play_sound sounds(26)
case else
if IS_PLAYING(sounds(8))="NO" then play_sound sounds(8)    
end select
if inkey=chr(13) then stop_sound sounds(28):exit do
loop until timer-t>45
'2 8 9 10 11 14 17 16 13 7 24


play_sound sounds(6) 
sleep 6000
do
n=int(rnd*21)
sleep 200
select case n
case 0 to 3
if IS_PLAYING(sounds(0))="NO" then play_sound sounds(0)
case 4 to 7
if IS_PLAYING(sounds(3))="NO" then play_sound sounds(3)    
case 8 to 11
if IS_PLAYING(sounds(8))="NO" then play_sound sounds(8)
case 12 to 15
if IS_PLAYING(sounds(12))="NO" then play_sound sounds(12)
case 16
if IS_PLAYING(sounds(13))="NO" then play_sound sounds(13)
case 17
if IS_PLAYING(sounds(16))="NO" then play_sound sounds(16)
case 18
if IS_PLAYING(sounds(17))="NO" then play_sound sounds(17)
case 19
if IS_PLAYING(sounds(18))="NO" then play_sound sounds(18)
case 20
if IS_PLAYING(sounds(19))="NO" then play_sound sounds(19)
case 21    
if IS_PLAYING(sounds(26))="NO" then play_sound sounds(26)
end select
if inkey=chr(13) then stop_sound sounds(6):exit do
loop until IS_PLAYING(sounds(6))="NO"
color 11,0
? "We will need to put in a ton of coins to get this next part going!!!"
sleep 2000
for i=1 to 50
play_sound_mc sounds(22)
sleep 200
play_sound_mc sounds(15)
sleep 200
next
color 15,0
? "A train is coming............"
sleep 2000
? "Can you hear it???????"
sleep 2000
play_sound sounds(4)
SCREENRES 640,480,32
WindowTitle "Matt's Sound Demo for mb_sound_lib v2.0"
bload "sounds/train_1.bmp" 
sleep 15000
cls
bload "sounds/train_2.bmp"
sleep 10000
cls
bload "sounds/train_3.bmp"
do
if inkey=chr(13) then stop_sound(sounds(4)):exit do
if inkey=chr(27) then exit sub
loop until IS_PLAYING(sounds(4))="NO"
'27 29 30
play_sound sounds(27)
cls
bload "sounds/genan_stage.bmp"
do
if inkey=chr(13) then stop_sound(sounds(27)):exit do    
if inkey=chr(27) then exit sub
loop until IS_PLAYING(sounds(27))="NO"

do
play_sound sounds(29)
cls
bload "sounds/train_2.bmp" 
if inkey=chr(27) then exit sub
sleep 
cls
bload "sounds/train_3.bmp"
if inkey=chr(27) then exit sub
sleep
stop_sound sounds(29)
play_sound sounds(30)
cls
bload "sounds/train_2.bmp"
if inkey=chr(27) then exit sub
sleep 
cls
bload "sounds/train_3.bmp"
if inkey=chr(27) then exit sub
sleep
stop_sound sounds(30)
play_sound sounds(27)
cls
bload "sounds/train_2.bmp"
if inkey=chr(27) then exit sub
sleep 
cls
bload "sounds/train_3.bmp"
if inkey=chr(27) then exit sub
sleep
stop_sound sounds(27)
play_sound sounds(4)
cls
bload "sounds/train_2.bmp"
if inkey=chr(27) then exit sub
sleep 
cls
bload "sounds/train_3.bmp"
if inkey=chr(27) then exit sub
sleep
loop until inkey=chr(27)

END SUB

