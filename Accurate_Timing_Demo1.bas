#include Once "vbcompat.bi"
#include once "fbgfx.bi"
#include "mb_sound_lib2.bi"
#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )



prepare_sound

dim as boolean ok

dim as integer spos

dim as integer hWave(30),sound(30),lasts
dim i as integer

TYPE OBJECTZ
x as integer
y as integer
xwidth as integer
ywidth as integer
active as string
conoff as integer
uname as string
END TYPE  

Dim Shared ObjectCount as integer
ObjectCount=0 

FUNCTION COLLISION(x1 as integer,y1 as integer,x1width as integer,y1width as integer,x2 as integer,y2 as integer,x2width as integer,y2width as integer) as integer
COLLISION=0
if x1+x1width>=x2 then
    if x1<=x2+x2width then
        if y1+y1width>=y2 then
            if y1<=y2+y2width then COLLISION=1
        end if
    end if
end if
END FUNCTION

FUNCTION COLLISION_CHECK(object1 as objectz,object2() as objectz) as string
dim nam as long
COLLISION_CHECK="NO"
for nam=1 to ObjectCount    
    if object1.uname=object2(nam).uname then
    else
    if object2(nam).conoff=1 then
    if COLLISION(object1.x,object1.y,object1.xwidth,object1.ywidth,object2(nam).x,object2(nam).y,object2(nam).xwidth,object2(nam).ywidth)=1 then
    COLLISION_CHECK="YES":exit function
    end if
    end if
    end if
next
END FUNCTION 

FUNCTION GET_BMP_WIDTH(filen as string) as long
dim f1 as long
f1=freefile
dim bmpwidth as long
open filen for binary as #f1
get #f1,19,bmpwidth
close f1
GET_BMP_WIDTH=bmpwidth    
END FUNCTION    

FUNCTION GET_BMP_HEIGHT(filen as string) as long
dim f1 as long
f1=freefile
dim bmpheight as long
open filen for binary as #f1
get #f1,23,bmpheight
close f1
GET_BMP_HEIGHT=bmpheight    
END FUNCTION 

SUB LOAD_IMAGE(dbuff as any ptr,filen as string)
Bload filen,dbuff
END SUB

SUB UPDATE_SCREEN (screenbuf as any ptr)
screenlock
put (0,0),screenbuf,pset
screenunlock
END SUB

TYPE SPRITE
xwidth as integer
ywidth as integer
filename as string
spritebuf as any ptr    
END TYPE 

SUB LOAD_SPRITE(varz as sprite,fname as string)
varz.xwidth=GET_BMP_WIDTH(fname)
varz.ywidth=GET_BMP_HEIGHT(fname)
varz.filename=fname
varz.spritebuf=ImageCreate(varz.xwidth+1, varz.ywidth+1, RGB(0, 0, 0) )
load_image varz.spritebuf,fname  
END SUB 

color 10,0
? "Press B at anytime during the demo to run without a loop delay."
? "This will also show the collision boxes."
? "Press N to return to normal."
?
dim overr as string
dim overd(1 to 4) as double
dim tfps as long
tfps=350
input "Override Defaults for Object Movement Timing? Y=Yes ",overr
if ucase(overr)="Y" then
? "Ball=.03"
? "Phone Booth=.01"
? "Box=.003"
? "Barrel=.06"
for i=1 to 4
? "Delay for object "+str(i)+"="
input " ",overd(i)
next
input "Input Target FPS, Default=350 ",tfps
end if


SCREENRES 640,480,32
WindowTitle "Matt B's Accurate Timing Demo"

Dim buffer1 As Any Ptr = ImageCreate( 640, 480, RGB(0, 0, 0) )
Dim toscreen As Any Ptr = ImageCreate( 640, 480, RGB(0, 0, 0) )
line buffer1,(0,0)-(639,479),RGB(0, 255, 0),b
line buffer1,(10,10)-(629,469),RGB(0, 255, 0),b 
paint buffer1,(1,1),RGB(0, 255, 0)

TYPE BALLS
xcord as integer
ycord as integer
pstep as integer
atimer as double
ctime as double
state as string
soundt as integer
'---------------
xwidth as integer
ywidth as integer
filename as string
spritebuf as any ptr 
END TYPE

LOAD_MP3_TO_MEM "sounds/3BH.mp3",hWave(0),sound(0),@sound(0)
LOAD_MP3_TO_MEM "sounds/29H.mp3",hWave(1),sound(1),@sound(1)
LOAD_MP3_TO_MEM "sounds/33H.mp3",hWave(2),sound(2),@sound(2)
LOAD_MP3_TO_MEM "sounds/Gong.mp3",hWave(3),sound(3),@sound(3)
LOAD_MP3_TO_MEM "sounds/SF_Box.mp3",hWave(4),sound(4),@sound(4)
LOAD_MP3_TO_MEM "sounds/SF_Glass.mp3",hWave(5),sound(5),@sound(5)

'PLAY_SOUND_MC sound(lasts)


dim ball(1 to 10) as BALLS
dim ball_sprite(1 to 10) as sprite
dim nam as long
for nam=1 to 1
load_sprite ball_sprite(nam),"sounds/ball4.BMP"
ball(nam).xwidth=ball_sprite(nam).xwidth
ball(nam).ywidth=ball_sprite(nam).ywidth
ball(nam).filename=ball_sprite(nam).filename
ball(nam).spritebuf=ball_sprite(nam).spritebuf
next
load_sprite ball_sprite(2),"sounds/O_2.BMP"
ball(2).xwidth=ball_sprite(2).xwidth
ball(2).ywidth=ball_sprite(2).ywidth
ball(2).filename=ball_sprite(2).filename
ball(2).spritebuf=ball_sprite(2).spritebuf

load_sprite ball_sprite(3),"sounds/O_3.BMP"
ball(3).xwidth=ball_sprite(3).xwidth
ball(3).ywidth=ball_sprite(3).ywidth
ball(3).filename=ball_sprite(3).filename
ball(3).spritebuf=ball_sprite(3).spritebuf

load_sprite ball_sprite(4),"sounds/O_4.BMP"
ball(4).xwidth=ball_sprite(4).xwidth
ball(4).ywidth=ball_sprite(4).ywidth
ball(4).filename=ball_sprite(4).filename
ball(4).spritebuf=ball_sprite(4).spritebuf

SUB UPDATE_BALLS(Balls1() as BALLS,dbuff as any ptr,objects() as objectz)
dim nam as long    
dim as string d,c 
dim as integer x,y,bx,by,p,r
  
for nam=1 to ubound(Balls1)
if Balls1(nam).state="" then
else
if (timer-Balls1(nam).ctime)>=Balls1(nam).atimer then    
d=Balls1(nam).state
x=Balls1(nam).xcord
y=Balls1(nam).ycord
bx=Balls1(nam).xwidth
by=Balls1(nam).ywidth
p=Balls1(nam).pstep


select case d
case "3"
objects(nam).x=objects(nam).x-p 
if COLLISION_CHECK(objects(nam),objects())="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
if r=3 then r=4
if r=5 then r=8
if r=7 then r=6
d=str(r)
objects(nam).x=objects(nam).x+p 
end if
case "4"
objects(nam).x=objects(nam).x+p 
if COLLISION_CHECK(objects(nam),objects())="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
if r=4 then r=3
if r=8 then r=5
if r=6 then r=7
d=str(r)
objects(nam).x=objects(nam).x-p 
end if    
case "1"
objects(nam).y=objects(nam).y-p 
if COLLISION_CHECK(objects(nam),objects())="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
if r=1 then r=2
if r=5 then r=8
if r=6 then r=7
d=str(r)
objects(nam).y=objects(nam).y+p 
end if
case "2"
''1 Up y-1
''2 Down y+1
''3 Left x-1
''4 Right x+1
''5 Up Left x-1,y-1   3 1
''6 Up Right x+1,y-1  1 4
''7 Down Left x-1,y+1 3 2
''8 Down Right x+1,y+1 4 2    
'if y%+by%<469 then
objects(nam).y=objects(nam).y+p 
if COLLISION_CHECK(objects(nam),objects())="NO" then
else
'Play_Sound Balls1(nam).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
if r=2 then r=1
if r=8 then r=5
if r=7 then r=6
d=str(r)
objects(nam).y=objects(nam).y-p     
end if    
case "6"
'Up Right    
objects(nam).x=objects(nam).x+p    
objects(nam).y=objects(nam).y-p     
c=COLLISION_CHECK(objects(nam),objects())    
if c="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
'if r%=3 then r%=4
'if r%=5 then r%=8
'if r%=7 then r%=6
d=str(r)    
objects(nam).x=objects(nam).x-p     
objects(nam).y=objects(nam).y+p
end if 
case "5"
'Up Left    
objects(nam).x=objects(nam).x-p    
objects(nam).y=objects(nam).y-p     
c=COLLISION_CHECK(objects(nam),objects())    
if c="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
'if r%=3 then r%=4
'if r%=5 then r%=8
'if r%=7 then r%=6
d=str(r)    
objects(nam).x=objects(nam).x+p     
objects(nam).y=objects(nam).y+p
end if 
case "7"
'Down Left    
objects(nam).x=objects(nam).x-p    
objects(nam).y=objects(nam).y+p     
c=COLLISION_CHECK(objects(nam),objects())    
if c="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
'if r%=3 then r%=4
'if r%=5 then r%=8
'if r%=7 then r%=6
d=str(r)    
objects(nam).x=objects(nam).x+p     
objects(nam).y=objects(nam).y-p
end if 
case "8"
'Down Right    
objects(nam).x=objects(nam).x+p    
objects(nam).y=objects(nam).y+p     
c=COLLISION_CHECK(objects(nam),objects())    
if c="NO" then
else
'Play_Sound Balls1(nam&).soundt
PLAY_SOUND_MC Balls1(nam).soundt
r=int(rnd*8)+1
'if r%=3 then r%=4
'if r%=5 then r%=8
'if r%=7 then r%=6
d=str(r)    
objects(nam).x=objects(nam).x-p     
objects(nam).y=objects(nam).y-p
end if 
end select    
Balls1(nam).state=d
Balls1(nam).xcord=objects(nam).x
Balls1(nam).ycord=objects(nam).y
Balls1(nam).ctime=timer

'put dbuff,(x%,y%),Balls1(nam&).spritebuf,Trans

end if
'Balls1(nam&).state=d$
Balls1(nam).xcord=objects(nam).x
Balls1(nam).ycord=objects(nam).y
'Balls1(nam&).ctime=timer
put dbuff,(Balls1(nam).xcord,Balls1(nam).ycord),Balls1(nam).spritebuf,Trans
end if
next
END SUB    


ball(1).state="1"
ball(2).state="4"
ball(1).xcord=50
ball(1).ycord=50
ball(2).xcord=100
ball(2).ycord=300
ball(1).ctime=timer
ball(2).ctime=timer
ball(1).atimer=.03'.0007 ball
ball(2).atimer=.01'.0040  phone booth
ball(1).pstep=1
ball(2).pstep=1
ball(1).soundt=sound(3)
ball(2).soundt=sound(5)


ball(3).state="1"
ball(4).state="4"
ball(3).xcord=500
ball(3).ycord=200
ball(4).xcord=250
ball(4).ycord=300
ball(3).ctime=timer
ball(4).ctime=timer
ball(3).atimer=.003'.05 boxes
ball(4).atimer=.06'.16  boxes
ball(3).pstep=1
ball(4).pstep=1

ball(3).soundt=sound(4)
ball(4).soundt=sound(4)


if ucase(overr)="Y" then
for i=1 to 4
ball(i).atimer=overd(i)    
next    
end if    

dim object3(1 to 8) as objectz
for nam=1 to 4
object3(nam).x=ball(nam).xcord
object3(nam).y=ball(nam).ycord
object3(nam).xwidth=ball(nam).xwidth
object3(nam).ywidth=ball(nam).ywidth
object3(nam).active="YES"
object3(nam).conoff=1
object3(nam).uname="Ball "+str(nam)
next
'object3(2).conoff=1

object3(5).x=0
object3(5).y=0
object3(5).xwidth=10
object3(5).ywidth=480
object3(5).active="YES"
object3(5).conoff=1
object3(5).uname="Left Wall"

object3(6).x=629
object3(6).y=0
object3(6).xwidth=10
object3(6).ywidth=480
object3(6).active="YES"
object3(6).conoff=1
object3(6).uname="Right Wall"

object3(7).x=0
object3(7).y=0
object3(7).xwidth=640
object3(7).ywidth=10
object3(7).active="YES"
object3(7).conoff=1
object3(7).uname="Top Wall"

object3(8).x=0
object3(8).y=469
object3(8).xwidth=640
object3(8).ywidth=10
object3(8).active="YES"
object3(8).conoff=1
object3(8).uname="Bottom Wall"
ObjectCount=8


SUB DELIM(stringz as string,delimiter as string,arrayz() as string)
dim as string z,d,z2
dim as integer nam,dc
dc=0
z=stringz
d=delimiter
z2=""
for nam=1 to len(z)
if mid(z,nam,1)=d then
dc=dc+1
arrayz(dc)=z2
z2=""
else  
z2=z2+mid(z,nam,1)    
end if
next
END SUB

FUNCTION FPS_DATA as string
'returns the current FPS, Average FPS, Last FPS    
static t as double
static fps as long
static avg as long
static avg2 as long
static last as long

if timer-t>=1 and fps>0 then
if avg2>=2 then 
    avg=avg+fps:avg=(avg/2) 
else
avg2=avg2+1    
end if    
end if

if timer-t>=1 then last=fps:fps=0
if fps=0 then t=timer
fps=fps+1
FPS_DATA=str(fps)+","+str(avg)+","+str(last)+","
END FUNCTION

FUNCTION GET_DELAY(Target_FPS as long) as double
'convert target fps/cycles per second to decimal fractions of a second
GET_DELAY=1/Target_FPS
END FUNCTION

FUNCTION TOP_OF_LOOP as double
'always capture this at the top of the main loop
TOP_OF_LOOP=timer
END FUNCTION

SUB LOOP_SLEEP(tol as double,delay as double)
'always call this at the bottom of the main loop    
if (timer-tol)<delay then 
do    
loop until (timer-tol)>=delay    
end if    
END SUB    

'Get current & average FPS data
'Get Delay (1/Target_FPS)
'Loop_Sleep

dim showbox as string
dim tol1 as double

showbox="N"
dim fps_sd(1 to 3) as string

dim delay1 as double
delay1=GET_DELAY(tfps) 'Default Target 350 FPS
do
tol1=TOP_OF_LOOP 'ALWAYS CALL THIS AT THE TOP OF THE MAIN LOOP

if multikey(&h30)=-1 then showbox="Y"
if multikey(&h31)=-1 then showbox="N"

screenlock
put toscreen,(0,0),buffer1,pset    
UPDATE_BALLS ball(),toscreen,object3()
if showbox="Y" then
for nam=1 to ObjectCount
if object3(nam).active="YES" and object3(nam).conoff=1 then 
line toscreen,(object3(nam).x,object3(nam).y)-(object3(nam).x+object3(nam).xwidth-1,object3(nam).y+object3(nam).ywidth-1),RGB(0, 255, 0),b     
draw string toscreen,(object3(nam).x,object3(nam).y),"Matt B",RGB(int(rnd*255), int(rnd*255),int(rnd*255))    
    
end if    
next
end if 
delim FPS_DATA,",",fps_sd()
draw string toscreen,(200,100),"FPS="+fps_sd(1)
draw string toscreen,(200,110),"Last FPS="+fps_sd(3)
draw string toscreen,(200,120),"AVG FPS="+fps_sd(2)
draw string toscreen,(200,140),"Target="+str(tfps)
put (0,0),toscreen,pset
screenunlock
if showbox="N" then
LOOP_SLEEP tol1,delay1 'ALWAYS CALL THIS AT THE BOTTOM OF THE MAIN LOOP
end if
loop until inkey=chr(27)

ImageDestroy buffer1
ImageDestroy toscreen
close_sound






















