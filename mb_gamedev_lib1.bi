#include once "fbgfx.bi"
#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )
'##############################
'mb_gamedev_lib is a library for game developement 
'Compiled using FreeBASIC version 1.06.0 32 bit win32
'##############################
dim shared as integer s_xwidth,s_ywidth,s_cdepth

'Data Structure for Sprites
TYPE SPRITE
xwidth as integer 'sprite width
ywidth as integer 'sprite height
filename as string 'file name of sprite
spritebuf as any ptr 'pointer to memory of sprite data
sdis as string 'sprite description string
pvalue as integer 'priority value of sprite
flipv as integer 'sprite flip data 0=Normal 1=Flip X 2=Flip Y 3=Flip X & Y
END TYPE

'Data Structure for objects with a single collision detection box
TYPE OBJECTZ
x as integer
y as integer
xwidth as integer
ywidth as integer
active as string
conoff as integer 'collisions on/off 1=On
uname as string
END TYPE  

Dim Shared ObjectCount as integer 
ObjectCount=0 
'#####################################################################################################
'#####################################################################################################
'Data Structure for  Animation/Object
'current X
'current Y
'number of frames

'unique delay between each frame

'sound table index
'number of collision boxes for frame
'collision box data
'starting time of animation
'current frame number
'frame state notes/description string

'xwidth
'ywidth
'filename
'spritebuf
'sdis
'pvalue
'flipv

'Data Structure for  Animation/Object
TYPE ANIM_OBJ
xwidth(1 to 100) as integer 'sprite width
ywidth(1 to 100) as integer 'sprite height
filename(1 to 100) as string 'file name of sprite
spritebuf(1 to 100) as any ptr 'pointer to memory of sprite data
sdis(1 to 100) as string 'sprite description string
pvalue(1 to 100) as integer 'priority value of sprite
flipv(1 to 100) as integer 'sprite flip data 0=Normal 1=Flip X 2=Flip Y 3=Flip X & Y    
    
curx as integer 'Current X
cury as integer 'Current Y
nof as integer 'number of frames
frameindex(1 to 100) as integer 'frame index
soundz(1 to 100) as integer 'sound table index -1=no sound
nocb(1 to 100) as integer 'number of collision boxes for frame
cbd_x1(1 to 100) as integer 'collision box data x1
cbd_y1(1 to 100) as integer 'collision box data y1
cbd_x1w(1 to 100) as integer 'collision box data x1 width
cbd_y1w(1 to 100) as integer 'collision box data y1 width
fsta(1 to 100) as string 'frame state string general purpose
cfn as integer 'current frame number
sta as double 'starting time of animation
fand as string 'animation notes/description string
timing(1 to 100) as double 'delay between each frame 
END TYPE
'#####################################################################################################
'#####################################################################################################
'mb_gamedev_lib
declare sub SET_SCREEN(xwidth1 as integer,ywidth1 as integer,cdepth1 as integer,wintitle as string)
declare sub LOAD_IMAGE(dbuff as any ptr,filen as string)
declare sub SAVE_SCREEN(filen as string)
declare sub SAVE_BUFFER(dbuff as any ptr,filen as string)
declare function GET_BMP_WIDTH(filen as string) as integer
declare function GET_BMP_HEIGHT(filen as string) as integer
declare sub DRAW_SPRITE(dbuff as any ptr,x as integer,y as integer,xwidth as integer,ywidth as integer,ibuff as any ptr,dt as integer,ton as integer)
declare sub FREE_RAM(dbuff as any ptr)
declare sub FREE_SPRITE_MEM(varz() as sprite)
declare sub LOAD_SPRITE(varz as sprite,fname as string)
declare sub LOAD_SPRITE_FLIP(varz as sprite,fname as string,ft as integer,ton2 as integer)
declare sub UPDATE_SCREEN (screenbuf as any ptr)
declare function GET_RGBA(col as long) as string
declare function GET_RGB(col as long) as string
declare sub GET_PAL(xwidth as integer,ywidth as integer,ibuff as any ptr,pal() as string)
declare function GET_COLOR_COUNT(xwidth as integer,ywidth as integer,ibuff as any ptr) as long
declare function GET_COLOR_COUNT_SC(scol as long,xwidth as integer,ywidth as integer,ibuff as any ptr) as long
declare sub SAVE_PALETTE(xwidth as integer,ywidth as integer,ibuff as any ptr,filen as string)
declare sub LOAD_PALETTE(filen as string,pal() as long)
declare sub DELIM2(stringz as string,delimiter as string,arrayz() as string)
declare sub LOAD_PALETTE_RGB(filen as string,pal() as long)
declare sub REPLACE_COLOR(ocol as long,ncol as long,xwidth as integer,ywidth as integer,ibuff as any ptr)
declare sub DRAW_PALETTE(dbuff as any ptr,filen as string,ofilen as string)
declare sub DRAW_PALETTE_WTEXT(dbuff as any ptr,filen as string,ofilen as string)
declare function GET_NCP(scol as long,xwidth as integer,ywidth as integer,ibuff as any ptr) as double
declare sub FADE_TO_BLACK(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
declare sub FROM_BLACK(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
declare sub BRIGHT_TO_WHITE(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
declare sub FROM_WHITE(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
declare sub SET_SCREEN_ALPHA(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,a as integer)
declare sub SET_SPRITE_ALPHA(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,a as integer)
declare sub GREY_SCREEN(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer)
declare sub GREY_SPRITE(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer)
declare sub SOLID_SPRITE(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer)
declare sub LIGHT_SWEEP(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,w as integer,tdelay as double)
declare sub LIGHT_SWEEP2(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,w as integer,stepn as integer)
declare sub Shellsort2(sa() as single,ae() as string)
declare sub LINE_PATH(x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare function GET_DISTANCE(x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer) as integer
declare sub SINE_PATHX(x0 As Integer, y0 As Integer,destx as integer,amp as integer,waves as double,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare sub SINE_PATHY(x0 As Integer, y0 As Integer,destx as integer,amp as integer,waves as double,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare sub DELIM(stringz as string,delimiter as string,arrayz() as string)
declare sub CIRCLE_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare sub UARC_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer, byref numsteps as integer)
declare sub DARC_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare function GET_CX(xcoord as integer,varz as sprite) as integer
declare function GET_BY(ycoord as integer,varz as sprite) as integer
declare sub CIRCLE_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare sub MAKE_PATH_ARRAY(inx() as integer,iny() as integer,outx() as integer,outy() as integer,numsteps as integer)
declare sub UARC_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer, byref numsteps as integer)
declare sub DARC_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
declare function COLLISION(x1 as integer,y1 as integer,x1width as integer,y1width as integer,x2 as integer,y2 as integer,x2width as integer,y2width as integer) as integer
declare function COLLISION_CHECK(object1 as objectz,object2() as objectz) as string
declare sub TRANSLATE_CORDS(byref cx1 as integer,byref cy1 as integer,cbx as integer,cby as integer)
'#####################################################################################################
'===============================================================================
SUB SET_SCREEN(xwidth1 as integer,ywidth1 as integer,cdepth1 as integer,wintitle as string)
'sets screen resolution and color depth as well as the title bar of the window
s_xwidth=xwidth1
s_ywidth=ywidth1
s_cdepth=cdepth1
SCREENRES xwidth1,ywidth1,cdepth1
WindowTitle wintitle 
END SUB 
'===============================================================================
SUB LOAD_IMAGE(dbuff as any ptr,filen as string) 
'load an image to buffer dbuff
Bload filen,dbuff
END SUB
'===============================================================================
SUB SAVE_BUFFER(dbuff as any ptr,filen as string)
'save buffer dbuff as an image
BSave filen,dbuff
END SUB
'===============================================================================
SUB SAVE_SCREEN(filen as string)
'save the contents of the computer screen to filen
BSave filen,0
END SUB
'===============================================================================
FUNCTION GET_BMP_WIDTH(filen as string) as integer
'get bitmap x axis width
dim f1 as long
f1=freefile
dim bmpwidth as long
open filen for binary as #f1
get #f1,19,bmpwidth
close f1
GET_BMP_WIDTH=bmpwidth    
END FUNCTION    
'===============================================================================
FUNCTION GET_BMP_HEIGHT(filen as string) as integer
'get bitmap y axis height
dim f1 as long
f1=freefile
dim bmpheight as long
open filen for binary as #f1
get #f1,23,bmpheight
close f1
GET_BMP_HEIGHT=bmpheight    
END FUNCTION 
'===============================================================================
SUB FREE_RAM(dbuff as any ptr)
'Free up ram from image buffer
ImageDestroy dbuff     
END SUB    
'===============================================================================
SUB DRAW_SPRITE(dbuff as any ptr,x as integer,y as integer,xwidth as integer,ywidth as integer,ibuff as any ptr,dt as integer,ton as integer)
'draws a sprite with different flip values

'dbuff=Destination Buffer
'dt%=Draw Type 0 1 2 3
'ton%=Transperancy On/Off
'0=Draw Sprite Regular
'1=Flip X
'2=Flip Y
'3=Flip XY
'x2%=x%+xwidth%
'y2%=y%+ywidth%
dim as long tcol,col
dim as integer x3,y3,x1,y1,x2,y2

ywidth=ywidth-2
xwidth=xwidth-2

tcol=RGB(255, 0, 255) 'transparent color
select case dt
case 0
'Draw Sprite Regular    
x3=0
y3=0    
for y1=y to y+ywidth
for x1=x to x+xwidth
col=point(x3,y3,ibuff)
if col=tcol and ton=1 then
else
if x1>=0 and x1<=(s_xwidth) and y1>=0 and y1<=(s_ywidth) then pset dbuff,(x1,y1),col
end if
x3=x3+1
next
x3=0
y3=y3+1
next
case 1
'Flip X    
x3=0
y3=0
for y1=y to y+ywidth
x2=x+xwidth
for x1=x to x+xwidth
col=point(x3,y3,ibuff)
if col=tcol and ton=1 then
else
if x1>=0 and x1<=(s_xwidth) and y1>=0 and y1<=(s_ywidth) then pset dbuff,(x2,y1),col
end if
x3=x3+1
x2=x2-1
next
x3=0
y3=y3+1
next    
case 2
'Flip Y
x3=0
y3=0    
y2=y+ywidth
for y1=y to y+ywidth
for x1=x to x+xwidth
col=point(x3,y3,ibuff)
if col=tcol and ton=1 then
else
if x1>=0 and x1<=(s_xwidth) and y1>=0 and y1<=(s_ywidth) then pset dbuff,(x1,y2),col
end if
x3=x3+1
next
x3=0
y3=y3+1
y2=y2-1
next
case 3
'Flip XY
x3=0
y3=0    
y2=y+ywidth
for y1=y to y+ywidth
x2=x+xwidth    
for x1=x to x+xwidth
col=point(x3,y3,ibuff)
if col=tcol and ton=1 then
else
if x1>=0 and x1<=(s_xwidth) and y1>=0 and y1<=(s_ywidth) then pset dbuff,(x2,y2),col
end if
x3=x3+1
x2=x2-1
next
x3=0
y3=y3+1
y2=y2-1
next
case else
end select
END SUB 
'===============================================================================
SUB LOAD_SPRITE(varz as sprite,fname as string)
'loads an image to an array using the sprite data structure 
varz.xwidth=GET_BMP_WIDTH(fname) 
varz.ywidth=GET_BMP_HEIGHT(fname)
varz.filename=fname
varz.spritebuf=ImageCreate(varz.xwidth-1, varz.ywidth-1, RGB(0, 0, 0) )
load_image varz.spritebuf,fname  
END SUB  
'===============================================================================
SUB LOAD_SPRITE_FLIP(varz as sprite,fname as string,ft as integer,ton2 as integer)
'loads an image with flip values to an array using the sprite data structure

'ft%=Draw Type 0 1 2 3
'ton%=Transperancy On/Off
'0=Draw Sprite Regular
'1=Flip X
'2=Flip Y
'3=Flip XY
varz.xwidth=GET_BMP_WIDTH(fname)
varz.ywidth=GET_BMP_HEIGHT(fname)
varz.filename=fname
varz.spritebuf=ImageCreate( varz.xwidth-1, varz.ywidth-1, RGB(0, 0, 0) )
dim tmpbuf as any ptr=ImageCreate( varz.xwidth-1, varz.ywidth-1, RGB(0, 0, 0) )
load_image tmpbuf,fname
DRAW_SPRITE varz.spritebuf,0,0,varz.xwidth,varz.ywidth,tmpbuf,ft,ton2
ImageDestroy tmpbuf
END SUB 
'===============================================================================
SUB FREE_SPRITE_MEM(varz() as sprite)
'Free up Ram from Sprite Array
dim as long nam
for nam=1 to ubound(varz)
varz(nam).xwidth=0
varz(nam).ywidth=0
varz(nam).filename=""
varz(nam).sdis=""
ImageDestroy varz(nam).spritebuf    
next
END SUB
'===============================================================================
SUB UPDATE_SCREEN (screenbuf as any ptr)
'call this to blit to screen
screenlock
put (0,0),screenbuf,pset
screenunlock
END SUB 
'===============================================================================
FUNCTION GET_RGBA(col as long) as string
'returns Red, Green, Blue, Alpha values in a string
Dim As UInteger r, g, b, a

r = RGBA_R( col )
g = RGBA_G( col )
b = RGBA_B( col )
a = RGBA_A( col )
if r<1 then r=0
if g<1 then g=0
if b<1 then b=0
if a<1 then a=0
if r>255 then r=255
if g>255 then g=255
if b>255 then b=255
if a>255 then a=255
GET_RGBA=str(r)+","+str(g)+","+str(b)+","+str(a)+","
END FUNCTION
'===============================================================================
FUNCTION GET_RGB(col as long) as string
'returns Red, Green, Blue values in a string
Dim As UInteger r, g, b, a

r = RGBA_R( col )
g = RGBA_G( col )
b = RGBA_B( col )

if r<1 then r=0
if g<1 then g=0
if b<1 then b=0

if r>255 then r=255
if g>255 then g=255
if b>255 then b=255

GET_RGB=str(r)+","+str(g)+","+str(b)+","
END FUNCTION
'===============================================================================
SUB GET_PAL(xwidth as integer,ywidth as integer,ibuff as any ptr,pal() as string)
'Returns palette into array pal()
dim as long tcol,col,c,nam
dim as integer x,y
dim as string z,hit
tcol=RGB(255, 0, 255) 'transparent color
c=0
for y=0 to ywidth-1
    for x=0 to xwidth-1
    col=point(x,y,ibuff) 
    if col=tcol then
    else
    z=GET_RGB(col)
    hit=""
    for nam=1 to ubound(pal)
    if pal(nam)=z then hit="1":exit for
    next
    if hit="" then
    c=c+1
    pal(c)=z
    end if
    end if
next
next 
END SUB 
'===============================================================================
FUNCTION GET_COLOR_COUNT(xwidth as integer,ywidth as integer,ibuff as any ptr) as long
'Returns the total number of unique colors without counting the transparent color.
dim as long tcol,col,c,nam,ai
dim as integer x,y
dim as string hit

redim pal(1 to 32000) as long
ai=32000
tcol=RGB(255, 0, 255) 'transparent color
c=0
for y=0 to ywidth-1
    for x=0 to xwidth-1
    col=point(x,y,ibuff) 
    if col=tcol then
    else
    hit=""
    for nam=1 to ai
    if pal(nam)=col then hit="1":exit for
    next
    if hit="" then
    c=c+1
    if c>32000 then
    redim preserve pal(1 to c)
    ai=c
    end if    
    pal(c)=col
    end if
    end if
next
next
GET_COLOR_COUNT=c   
END FUNCTION
'===============================================================================
FUNCTION GET_COLOR_COUNT_SC(scol as long,xwidth as integer,ywidth as integer,ibuff as any ptr) as long
'Returns the total number of unique colors while not counting the skip color.
'scol = Skip Color
dim as long tcol,col,c,nam,ai
dim as integer x,y
dim as string hit

redim pal(1 to 32000) as long
ai=32000
c=0
for y=0 to ywidth-1
    for x=0 to xwidth-1
    col=point(x,y,ibuff) 
    if col=scol then
    else
    hit=""
    for nam=1 to ai
    if pal(nam)=col then hit="1":exit for
    next
    if hit="" then
    c=c+1
    if c>32000 then
    redim preserve pal(1 to c)
    ai=c
    end if    
    pal(c)=col
    end if
    end if
next
next
GET_COLOR_COUNT_SC=c   
END FUNCTION
'===============================================================================
SUB SAVE_PALETTE(xwidth as integer,ywidth as integer,ibuff as any ptr,filen as string)
'Saves the palette to a file 
dim as long tcol,col,c,nam,ai,f1
dim as integer x,y
dim as string hit

redim pal(1 to 32000) as long
ai=32000
tcol=RGB(255, 0, 255) 'transparent color
c=0
for y=0 to ywidth-1
    for x=0 to xwidth-1
    col=point(x,y,ibuff) 
    if col=tcol then
    else
    hit=""
    for nam=1 to ai
    if pal(nam)=col then hit="1":exit for
    next
    if hit="" then
    c=c+1
    if c>32000 then
    redim preserve pal(1 to c)
    ai=c
    end if    
    pal(c)=col
    end if
    end if
next
next

f1=freefile
open filen for output as #f1
for nam=1 to c
print #f1,pal(nam)
next
close f1  

f1=freefile
open "RGB_"+filen for output as #f1
for nam=1 to c
print #f1,GET_RGB(pal(nam))
next
close f1 
END SUB
'===============================================================================
SUB LOAD_PALETTE(filen as string,pal() as long)
'Load raw RGB values into an array
dim as string z
dim as long f1
dim as integer rc
z=" "
f1=freefile
open filen for input as #f1
rc=0
do
line input #f1,z
rc=rc+1
pal(rc)=val(z)
loop until eof(f1)
close f1
END SUB 
'===============================================================================
SUB DELIM2(stringz as string,delimiter as string,arrayz() as string)
'Break string into array elements based on the delimiter
dim as integer dc
dim as string z,z2,d
dim as long nam
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
'===============================================================================
SUB LOAD_PALETTE_RGB(filen as string,pal() as long)
'Load formated RGB values into an array
dim as string z
dim as long f1
dim as integer rc
dim ca(1 to 6) as string
z=" "
f1=freefile
open filen for input as #f1
rc=0
do
line input #f1,z
rc=rc+1
delim2 z,",",ca()
pal(rc)=RGB(ca(1),ca(2),ca(3))
loop until eof(f1)
close f1
END SUB 
'===============================================================================
FUNCTION GET_NCP(scol as long,xwidth as integer,ywidth as integer,ibuff as any ptr) as double
'Returns Not Color Percentage. What percentage of the image is not scol
dim as integer x,y
dim as long tcol
dim as double c,ta
ta=0
c=0
for y=0 to ywidth-1
    for x=0 to xwidth-1
        tcol=point(x,y,ibuff)
        if tcol=scol then 
        ta=ta+1
        else
        ta=ta+1
        c=c+1
        end if
    next
next
GET_NCP=((c*100)/ta)    
END FUNCTION    
'===============================================================================
SUB REPLACE_COLOR(ocol as long,ncol as long,xwidth as integer,ywidth as integer,ibuff as any ptr)
'Replace the color ocol with the new color ncol
dim as integer x,y
dim as long tcol
for y=0 to ywidth-1
    for x=0 to xwidth-1
        tcol=point(x,y,ibuff)
        if tcol=ocol then pset ibuff,(x,y),ncol
    next
next
END SUB 
'===============================================================================
SUB DRAW_PALETTE(dbuff as any ptr,filen as string,ofilen as string)
'Draw a palette from formated RGB data in a file
dim as integer x,y,x2,y2,r,g,b
x=0
y=10
dim delim1(1 to 100) as string
dim as string z
dim as long f1
z=" "
f1=freefile
open filen for input as #f1
do
line input #f1,z
delim2 z,",",delim1()
r=val(delim1(1))
g=val(delim1(2))
b=val(delim1(3))
for y2=y to y+19
 for x2=x to x+19
 pset dbuff,(x2,y2),RGB(r,g,b)
next
next
if x<s_xwidth then 
    x=x+22
else
x=0
if y<s_ywidth then y=y+22
end if    

loop until eof(f1)
close f1
Bsave ofilen,dbuff
END SUB
'===============================================================================
SUB DRAW_PALETTE_WTEXT(dbuff as any ptr,filen as string,ofilen as string)
'Draw a palette with text
'Draw a palette from formated RGB data in a file with text showing RGB values
dim as integer x,y,x2,y2,r,g,b
x=0
y=10
dim delim1(1 to 100) as string
dim as string z
dim as long f1,c
z=" "
f1=freefile
open filen for input as #f1
do
line input #f1,z
delim2 z,",",delim1()
r=val(delim1(1))
g=val(delim1(2))
b=val(delim1(3))
for y2=y to y+19
 for x2=x to x+19
 pset dbuff,(x2,y2),RGB(r,g,b)
next
next

if x<s_xwidth then 
    x=x+22
else
x=0
if y<s_ywidth then y=y+22
end if    

loop until eof(f1)
close f1

y2=y2+10
c=0
f1=freefile
open filen for input as #f1
do
line input #f1,z
c=c+1
delim2 z,",",delim1()
r=val(delim1(1))
g=val(delim1(2))
b=val(delim1(3))

Draw String dbuff,(10,y2),"Color #"+str(c)+" R="+str(r)+" G="+str(g)+" B="+str(b), RGB(r,g,b)
if y2<s_ywidth then y2=y2+10
loop until eof(f1)
close f1

Bsave ofilen,dbuff
END SUB
'===============================================================================
SUB FADE_TO_BLACK(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
'Fades Screen to Black
'dbuff=destination buffer
'img=source buffer
dim as double t
dim as any ptr j,tmp
dim as integer a
j = imagecreate (xwidth, ywidth, 0)
tmp=imagecreate (xwidth, ywidth, 0)
t=timer
for a = 0 to 255
   PUT tmp,(0, 0), img, PSET  
   PUT tmp,(0, 0), j, ALPHA, a
   PUT dbuff,(xcord, ycord), tmp, PSET
do
loop until (timer-t)>=tdelay
t=timer
next    
ImageDestroy j  
ImageDestroy tmp
END SUB    
'===============================================================================
SUB FROM_BLACK(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
'Brings Screen from total Blackness to current image
'dbuff=destination buffer
'img=source buffer
dim as double t
dim as any ptr j,tmp
dim as integer a
j = imagecreate (xwidth, ywidth, 0)
tmp=imagecreate (xwidth, ywidth, 0)
t=timer
for a = 255 to 0 step -1
   PUT tmp,(0, 0), img, PSET  
   PUT tmp,(0, 0), j, ALPHA, a
   PUT dbuff,(xcord, ycord), tmp, PSET
do
loop until (timer-t)>=tdelay
t=timer
next    
ImageDestroy j  
ImageDestroy tmp
END SUB    
'===============================================================================
SUB BRIGHT_TO_WHITE(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
'Brings Screen to complete Whiteness
'dbuff=destination buffer
'img=source buffer
dim as double t
dim as any ptr j,tmp
dim as integer a
j = imagecreate (xwidth, ywidth, RGB(255,255,255))
tmp=imagecreate (xwidth, ywidth, RGB(255,255,255))
t=timer
for a = 0 to 255
   PUT tmp,(0, 0), img, PSET  
   PUT tmp,(0, 0), j, ALPHA, a
   PUT dbuff,(xcord, ycord), tmp, PSET
do
loop until (timer-t)>=tdelay
t=timer
next    
ImageDestroy j  
ImageDestroy tmp
END SUB    
'===============================================================================
SUB FROM_WHITE(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,tdelay as double)
'Brings Screen from total Whiteness to current image
'dbuff=destination buffer
'img=source buffer
dim as double t
dim as any ptr j,tmp
dim as integer a
j = imagecreate (xwidth, ywidth, RGB(255,255,255))
tmp=imagecreate (xwidth, ywidth, RGB(255,255,255))
t=timer
for a = 255 to 0 step -1
   PUT tmp,(0, 0), img, PSET  
   PUT tmp,(0, 0), j, ALPHA, a
   PUT dbuff,(xcord, ycord), tmp, PSET
do
loop until (timer-t)>=tdelay
t=timer
next    
ImageDestroy j  
ImageDestroy tmp
END SUB    
'===============================================================================
SUB SET_SCREEN_ALPHA(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,a as integer)
'Sets the Screen tint to r,g,b with a being the alpha level between 0 and 255 
'dbuff=destination buffer
'img=source buffer
dim as any ptr j,tmp
j = imagecreate (xwidth, ywidth, RGB(r,g,b))
tmp=imagecreate (xwidth, ywidth, RGB(r,g,b))    
   PUT tmp,(0, 0), img, PSET  
   PUT tmp,(0, 0), j, ALPHA, a
   PUT dbuff,(xcord, ycord), tmp, PSET    
ImageDestroy j  
ImageDestroy tmp    
END SUB    
'===============================================================================
SUB SET_SPRITE_ALPHA(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,a as integer)
'Sets the Sprite tint to r,g,b with a being the alpha level between 0 and 255
'dbuff=destination buffer
'spritez.spritebuf=source image buffer
dim as integer x,y
dim as any ptr j,mask1,tmp
dim as long tcol
tcol=RGB(255, 0, 255)
j = imagecreate (spritez.xwidth-1, spritez.ywidth-1, RGB(r,g,b))
tmp=imagecreate (spritez.xwidth-1, spritez.ywidth-1, RGB(r,g,b))     
mask1=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)    

for y=0 to spritez.ywidth
    for x=0 to spritez.xwidth
if point(x,y,spritez.spritebuf)=tcol then 
    pset mask1,(x,y),tcol 
else
    pset mask1,(x,y),0
end if    
next
next

   PUT tmp,(0, 0), spritez.spritebuf, PSET  
   PUT tmp,(0, 0), j, ALPHA, a

for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
if point(x,y,mask1)=tcol then pset tmp,(x,y),tcol
next
next

PUT dbuff,(xcord, ycord), tmp, Trans 
ImageDestroy j  
ImageDestroy tmp 
ImageDestroy mask1
END SUB    
'===============================================================================    
SUB GREY_SCREEN(dbuff as any ptr,img as any ptr,xwidth as integer,ywidth as integer,xcord as integer,ycord as integer)
'Sets the Screen to Grey using the Grey Scale
dim as long RGB1,R,G,B
dim as uinteger I,C1
dim as integer x,y
for y=0 to ywidth
    for x=0 to xwidth
RGB1 = point(x,y,img) 'Get color value for a given point'
R = RGBA_R(RGB1)   'Break down color value into RGB value'
G = RGBA_G(RGB1)
B = RGBA_B(RGB1)
I = ((R*306)+(G*601)+(B*117)) 'Formula for intensity value using RGB'
C1 = I \ 1024
pset dbuff,(x,y),rgb(C1,C1,C1) 'setting all RGB values the same creates grayscale'
next
next
END SUB
'===============================================================================    
SUB GREY_SPRITE(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer)
'Sets the Sprite to Grey using the Grey Scale
dim as any ptr mask1,tmp
dim as long tcol
tcol=RGB(255, 0, 255)
dim as long RGB1,R,G,B
dim as uinteger I,C1
dim as integer x,y

tmp=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)     
mask1=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)    

for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
if point(x,y,spritez.spritebuf)=tcol then 
    pset mask1,(x,y),tcol 
else
    pset mask1,(x,y),0
end if    
next
next

   PUT tmp,(0, 0), spritez.spritebuf, PSET 


for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
RGB1 = point(x,y,spritez.spritebuf) 'Get color value for a given point'
R = RGBA_R(RGB1)   'Break down color value into RGB value'
G = RGBA_G(RGB1)
B = RGBA_B(RGB1)
I = ((R*306)+(G*601)+(B*117)) 'Formula for intensity value using RGB'
C1 = I \ 1024
pset tmp,(x,y),rgb(C1,C1,C1) 'setting all RGB values the same creates grayscale'
next
next

for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
if point(x,y,mask1)=tcol then pset tmp,(x,y),tcol
next
next

PUT dbuff,(xcord, ycord), tmp, Trans 
 
ImageDestroy tmp 
ImageDestroy mask1

END SUB
'===============================================================================
SUB SOLID_SPRITE(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer)
'Sets the non-transparent colors of a Sprite to the Solid Color r,g,b
dim as any ptr tmp
dim as long tcol,ncol
tcol=RGB(255, 0, 255)
dim as integer x,y
ncol=RGB(r,g,b)
tmp=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)     

for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
if point(x,y,spritez.spritebuf)=tcol then 
    pset tmp,(x,y),tcol
    else
    pset tmp,(x,y),ncol
end if    
next
next

   PUT dbuff,(xcord, ycord), tmp, Trans 
ImageDestroy tmp 
END SUB
'===============================================================================
SUB LIGHT_SWEEP(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,w as integer,tdelay as double)  
'Static Subroutine that performs a downward diagonal Light Sweep effect
'Currently runs very slowly even with tdelay set to .00
static ep as integer
static as any ptr tmp,tmp2,tmp3,pb
static as double t
static as long tcol,ncol,pc1,pc2
static as integer x1,y1,x2,y2,x,y,i,c

  
if ep=0 then
  
tcol=RGB(255, 0, 255)    
ncol=RGB(r,g,b)
pb=spritez.spritebuf
tmp=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0) 
tmp2=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)   
tmp3=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)
ep=1
t=timer
x1=0
x2=0'spritez.xwidth-1
y1=0
y2=y1-w

else

    
if pb=spritez.spritebuf then
if (timer-t)>=tdelay then 
    t=timer
line tmp,(x1,y1)-(x2,y2),ncol
c=0    
for i=1 to w
c=c+1
line tmp,(x1,y1+c)-(x2,y2+c),ncol
next
    

line tmp,(x1,y1+w)-(x2,y2+w),ncol

'pset tmp,(x1,y1),RGB(0,255,0)
for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
pc1=point(x,y,spritez.spritebuf)
pc2=point(x,y,tmp)
if pc1=tcol then 
    'pset dbuff,(x,y),tcol
    else
    if pc2=ncol then 
        pset tmp3,(x,y),ncol
    else
        pset tmp3,(x,y),pc1
    end if
    
end if    
next
next
y1=y1+1
x2=x2+1
put dbuff,(xcord,ycord),tmp3,Trans
put tmp,(0,0),tmp2,PSET
put tmp3,(0,0),tmp2,PSET
if (y1-w)>(spritez.ywidth*2) then
ep=0
ImageDestroy tmp
ImageDestroy tmp2
ImageDestroy tmp3
exit sub
end if
else
    
end if    

   
end if
end if

END SUB    
'===============================================================================
SUB LIGHT_SWEEP2(dbuff as any ptr,spritez as sprite,xcord as integer,ycord as integer,r as integer,g as integer,b as integer,w as integer,stepn as integer)
'Slightly faster but still slow Light Sweep effect routine
'stepn can be incremented in steps of 3 or higher for faster speed
'stepn initial value shoule be oi=oi-sprite1(1).xwidth
'Remarked out example below:
'dim as integer i,oi
'oi=oi-sprite1(1).xwidth
'i=oi
'do
'LIGHT_SWEEP2 0,sprite1(1),100,100,255,255,255,10,i
'i=i+3
'if i>60 then i=oi
'loop until inkey=chr(27)

static as any ptr tmp,tmp2

static as long tcol,ncol,pc1
static as integer x1,y1,x2,y2,x,y,i,c,w2
tcol=RGB(255, 0, 255)    
ncol=RGB(r,g,b)    
   

tmp=imagecreate (spritez.xwidth-1, spritez.ywidth-1, tcol) 
tmp2=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)   
'tmp3=imagecreate (spritez.xwidth-1, spritez.ywidth-1, 0)
x1=0
y1=spritez.ywidth
x2=spritez.xwidth'stepn
'y2=y1-w
y2=0'y2+stepn
line tmp,(x1,y1)-(x2,y2),ncol
c=0    
for i=1 to w
c=c+1
line tmp,(x1,y1+c)-(x2,y2+c),ncol
next
'line tmp,(x1,y1+w)-(x2,y2+w),ncol

put tmp2,(0,0),spritez.spritebuf,PSET
put tmp2,(stepn,stepn),tmp,Trans

for y=0 to spritez.ywidth-1
    for x=0 to spritez.xwidth-1
pc1=point(x,y,spritez.spritebuf)

if pc1=tcol then pset tmp2,(x,y),tcol
   
next
next

'put dbuff,(100,100),tmp,Trans
put dbuff,(xcord,ycord),tmp2,Trans

ImageDestroy tmp
ImageDestroy tmp2

END SUB
'===============================================================================
SUB Shellsort2(sa() as single,ae() as string) 
'This Sub does a shellsort of data in sa() from least to greatest
'lbound(sa(1))=Least
'ubound(sa(1))=Greatest
     dim iNN as single
     dim iD as single
     dim iJ as single
     dim iI as single
     dim s as single
     iNN = Ubound(sa)
     iD = 4
     dim as string aee
     Do While iD < iNN 
          iD = iD + iD
     Loop
     iD = iD - 1
     Do
          iD = iD \ 2
          If iD < 1 Then Exit Do
          For iJ = 1 To iNN - iD
               For iI = iJ To 1 Step -iD
                    If sa(iI + iD) >= sa(iI) Then Exit For
                    
                    s = sa(iI):aee=ae(iI)
                    sa(iI) = sa(iI + iD):ae(iI)=ae(iI + iD)
                    sa(iI + iD) = s:ae(iI + iD)=aee
                    
               Next iI
          Next iJ
     Loop
END SUB
'===============================================================================
SUB LINE_PATH(x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
'Bresenham's line algorithm
'Returns Coordinates for a Direct Line Path
 
    Dim As Integer dx = Abs(x1 - x0), dy = Abs(y1 - y0)
    Dim As Integer sx = IIf(x0 < x1, 1, -1)
    Dim As Integer sy = IIf(y0 < y1, 1, -1)
    Dim As Integer er = IIf(dx > dy, dx, -dy) \ 2, e2
numsteps=0
    Do
        
        numsteps=numsteps+1
        xcords(numsteps)=x0
        ycords(numsteps)=y0
        If (x0 = x1) And (y0 = y1) Then Exit Do
        e2 = er
        If e2 > -dx Then Er -= dy : x0 += sx
        If e2 <  dy Then Er += dx : y0 += sy
    Loop
END SUB
'===============================================================================
FUNCTION GET_DISTANCE(x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer) as integer
'Calculate the distance between two points

if (x0 = x1) And (y0 = y1) then GET_DISTANCE=0:exit function 'exit early if same coordinates
if y0=y1 then GET_DISTANCE=abs(x0-x1):exit function 'exit early if same Y axis
if x0=x1 then GET_DISTANCE=abs(y0-y1):exit function 'exit early if same X axis 

'Calculate the distance between two points using Bresenham's line algorithm
    Dim As Integer dx = Abs(x1 - x0), dy = Abs(y1 - y0)
    Dim As Integer sx = IIf(x0 < x1, 1, -1)
    Dim As Integer sy = IIf(y0 < y1, 1, -1)
    Dim As Integer er = IIf(dx > dy, dx, -dy) \ 2, e2
    Dim as Integer numsteps=0

    Do
        
        numsteps=numsteps+1
        
        If (x0 = x1) And (y0 = y1) Then Exit Do
        e2 = er
        If e2 > -dx Then Er -= dy : x0 += sx
        If e2 <  dy Then Er += dx : y0 += sy
    Loop
GET_DISTANCE=numsteps
END FUNCTION
'===============================================================================
SUB SINE_PATHX(x0 As Integer, y0 As Integer,destx as integer,amp as integer,waves as double,xcords() as integer,ycords() as integer,byref numsteps as integer)
'X Axis Sine Wave

'amp Y axis    distance between waves X axis lower number=more distance
'waves 05 to .25 seems to be a good range
numsteps=0
dim as integer xx,my
xx=x0

for xx=x0 to destx
    my=amp*sin(waves*xx)+y0
numsteps=numsteps+1
xcords(numsteps)=xx
ycords(numsteps)=my
next
END SUB
'===============================================================================
SUB SINE_PATHY(x0 As Integer, y0 As Integer,destx as integer,amp as integer,waves as double,xcords() as integer,ycords() as integer,byref numsteps as integer)
'Y Axis Sine Wave
dim as integer tmpx,tmpy
tmpx=x0
tmpy=y0
x0=tmpy
y0=tmpx
numsteps=0
dim as integer xx,my
for xx=x0 to destx
    my=amp*sin(waves*xx)+y0
numsteps=numsteps+1
xcords(numsteps)=my
ycords(numsteps)=xx
next
END SUB
'===============================================================================
SUB DELIM(stringz as string,delimiter as string,arrayz() as string)
dim as integer dc=0
dim as string z,d,z2
dim as long nam
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
'===============================================================================
SUB CIRCLE_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
  Dim As Integer f = 1 - radius
  Dim As Integer ddF_x = 1
  Dim As Integer ddF_y = -2 * radius
  Dim As Integer x = 0
  Dim As Integer y = radius
  numsteps=0
  'PSet(x0, y0 + radius), clr 
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0+radius
  'PSet(x0, y0 - radius), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0-radius
  'PSet(x0 + radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0+radius
  ycords(numsteps)=y0
  'PSet(x0 - radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-radius
  ycords(numsteps)=y0
  Do While(x < y)
 
    If f >= 0 Then 
      y -= 1
      ddF_y += 2
      f += ddF_y
    End If
    x += 1
    ddF_x += 2
    f += ddF_x    
    'PSet(x0 + x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0+y
    'PSet(x0 - x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0+y
    'PSet(x0 + x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0-y
    'PSet(x0 - x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0-y
    'PSet(x0 + y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0+x
    'PSet(x0 - y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0+x
    'PSet(x0 + y, y0 - x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0-x
    'PSet(x0 - y, y0 - x), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0-x
Loop
'Upper Circle Arc*************
dim as integer ns2
dim as long nam
ns2=0

for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1     
next    
dim xcords2(1 to ns2) as single
dim cords2(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1:xcords2(ns2)=xcords(nam):cords2(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords2(),cords2()
'*****************************
'Lower Circle Arc*************
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1     
next    
dim xcords3(1 to ns2) as single
dim cords3(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1:xcords3(ns2)=xcords(nam):cords3(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords3(),cords3()
'*****************************
'print numsteps
'sleep
ns2=0
dim delim1(1 to 100) as string
dim as string z
for nam=1 to ubound(cords2)
ns2=ns2+1
z=cords2(nam)
delim z,",",delim1()
xcords(ns2)=val(delim1(1))
ycords(ns2)=val(delim1(2))
'if ns2>=2 then
'if xcords(ns2)=xcords(ns2-1) and ycords(ns2-1)>ycords(ns2) then 
'    ns2=ns2-1
'else
'if xcords(ns2)=xcords(ns2-1) and abs(ycords(ns2-1)-ycords(ns2))>1 then ns2=ns2-1     
'end if
'end if
next

for nam=ubound(cords3) to 1 step -1
ns2=ns2+1
z=cords3(nam)
delim z,",",delim1()
xcords(ns2)=val(delim1(1))
ycords(ns2)=val(delim1(2))
'if ns2>=2 then
'if xcords(ns2)=xcords(ns2-1) and ycords(ns2-1)>ycords(ns2) then 
'    ns2=ns2-1
'else
'if xcords(ns2)=xcords(ns2-1) and abs(ycords(ns2-1)-ycords(ns2))>1 then ns2=ns2-1     
'end if
'end if
next
numsteps=ns2
END SUB 
'===============================================================================
SUB UARC_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer, byref numsteps as integer)
  'upper arc path
  Dim As Integer f = 1 - radius
  Dim As Integer ddF_x = 1
  Dim As Integer ddF_y = -2 * radius
  Dim As Integer x = 0
  Dim As Integer y = radius
  numsteps=0
  'PSet(x0, y0 + radius), clr 
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0+radius
  'PSet(x0, y0 - radius), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0-radius
  'PSet(x0 + radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0+radius
  ycords(numsteps)=y0
  'PSet(x0 - radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-radius
  ycords(numsteps)=y0
  Do While(x < y)
    'ddF_x == 2 * x + 1;
    'ddF_y == -2 * y;
    'f == x*x + y*y - radius*radius + 2*x - y + 1;
    If f >= 0 Then 
      y -= 1
      ddF_y += 2
      f += ddF_y
    End If
    x += 1
    ddF_x += 2
    f += ddF_x    
    'PSet(x0 + x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0+y
    'PSet(x0 - x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0+y
    'PSet(x0 + x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0-y
    'PSet(x0 - x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0-y
    'PSet(x0 + y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0+x
    'PSet(x0 - y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0+x
    'PSet(x0 + y, y0 - x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0-x
    'PSet(x0 - y, y0 - x), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0-x
Loop
'Upper Circle Arc*************
dim as integer ns2
dim as long nam
ns2=0
for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1     
next    
dim xcords2(1 to ns2) as single
dim cords2(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1:xcords2(ns2)=xcords(nam):cords2(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords2(),cords2()
'*****************************
'Lower Circle Arc*************
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1     
next    
dim xcords3(1 to ns2) as single
dim cords3(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1:xcords3(ns2)=xcords(nam):cords3(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords3(),cords3()
'*****************************
ns2=0
numsteps=0
dim delim1(1 to 100) as string
for nam=1 to ubound(cords2)
ns2=ns2+1
dim as string z
z=cords2(nam)
delim z,",",delim1()
numsteps=numsteps+1
xcords(ns2)=val(delim1(1))
ycords(ns2)=val(delim1(2))
next
END SUB
'===============================================================================
SUB DARC_PATH(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
  'lower arc path
  Dim As Integer f = 1 - radius
  Dim As Integer ddF_x = 1
  Dim As Integer ddF_y = -2 * radius
  Dim As Integer x = 0
  Dim As Integer y = radius
  numsteps=0
  'PSet(x0, y0 + radius), clr 
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0+radius
  'PSet(x0, y0 - radius), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0
  ycords(numsteps)=y0-radius
  'PSet(x0 + radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0+radius
  ycords(numsteps)=y0
  'PSet(x0 - radius, y0), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-radius
  ycords(numsteps)=y0
  Do While(x < y)
    'ddF_x == 2 * x + 1;
    'ddF_y == -2 * y;
    'f == x*x + y*y - radius*radius + 2*x - y + 1;
    If f >= 0 Then 
      y -= 1
      ddF_y += 2
      f += ddF_y
    End If
    x += 1
    ddF_x += 2
    f += ddF_x    
    'PSet(x0 + x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0+y
    'PSet(x0 - x, y0 + y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0+y
    'PSet(x0 + x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+x
  ycords(numsteps)=y0-y
    'PSet(x0 - x, y0 - y), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-x
  ycords(numsteps)=y0-y
    'PSet(x0 + y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0+x
    'PSet(x0 - y, y0 + x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0+x
    'PSet(x0 + y, y0 - x), clr
    numsteps=numsteps+1
  xcords(numsteps)=x0+y
  ycords(numsteps)=y0-x
    'PSet(x0 - y, y0 - x), clr
  numsteps=numsteps+1
  xcords(numsteps)=x0-y
  ycords(numsteps)=y0-x
Loop
'Upper Circle Arc*************
dim as integer ns2
ns2=0
dim as long nam
for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1     
next    
dim xcords2(1 to ns2) as single
dim cords2(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)<=y0 then ns2=ns2+1:xcords2(ns2)=xcords(nam):cords2(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords2(),cords2()
'*****************************
'Lower Circle Arc*************
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1     
next    
dim xcords3(1 to ns2) as single
dim cords3(1 to ns2) as string 
ns2=0
for nam=1 to numsteps
if ycords(nam)>=y0 then ns2=ns2+1:xcords3(ns2)=xcords(nam):cords3(ns2)=str(xcords(nam))+","+str(ycords(nam))+","      
next
Shellsort2 xcords3(),cords3()
'*****************************
ns2=0
numsteps=0
dim delim1(1 to 100) as string
dim as string z
ns2=0
numsteps=0
for nam=1 to ubound(cords3)
ns2=ns2+1
numsteps=numsteps+1
z=cords3(nam)
delim z,",",delim1()
xcords(ns2)=val(delim1(1))
ycords(ns2)=val(delim1(2))
next
END SUB
'===============================================================================
FUNCTION GET_CX(xcoord as integer,varz as sprite) as integer
'Get Center of X axis for sprite at current x coordinate
GET_CX=int(varz.xwidth/2)+xcoord    
END FUNCTION
'===============================================================================
FUNCTION GET_BY(ycoord as integer,varz as sprite) as integer
'Get Bottom of Y axis for sprite at current y coordinate
'Remember to subtract radius from y current coordinate in Circle_Path sub rountine and other routines
GET_BY=int(varz.ywidth)+ycoord    
END FUNCTION
'===============================================================================
SUB CIRCLE_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
'Use this, better than circle_path
'Returns cordinates for a circle
'Circle begins at the bottom directly below the center straight down at the radius distance
dim as integer x,y,px,py,jx,jy,nam,angle
px=x0
py=y0+radius
jx=x0
jy=y0
angle=90
numsteps=0

for nam=1 to 360
    x = x0+radius*cos(2.0*3.14*angle/360.0)    
    y = y0+radius*sin(2.0*3.14*angle/360.0)

    if x>px then jx=jx+abs(x-px)
    if x<px then jx=jx-abs(x-px)
    if y>py then jy=jy+abs(y-py)
    if y<py then jy=jy-abs(y-py)
    px=x
    py=y
numsteps=numsteps+1    
xcords(numsteps)=jx  
ycords(numsteps)=jy 
angle=angle+1
if angle>360 then angle=0    
next    
    
END SUB
'===============================================================================
SUB MAKE_PATH_ARRAY(inx() as integer,iny() as integer,outx() as integer,outy() as integer,numsteps as integer)
'Makes a cordinate path lookup table
'Puts the contents of a path array into a pre-calculated path array that can be used anywhere without recalculation

dim as integer nam    
outx(1)=0
outy(1)=0
for nam=2 to numsteps
outx(nam)=inx(nam)-inx(nam-1)
outy(nam)=iny(nam)-iny(nam-1)
next    
    
END SUB
'===============================================================================
SUB UARC_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
'Use this, better than uarc_path
'Returns cordinates for a upper half circle
'Half Circle begins at beginning of half circle on left side
dim as integer x,y,px,py,jx,jy,nam,angle
px=x0
py=y0+radius
jx=x0
jy=y0
angle=180
numsteps=0

for nam=180 to 360
    x = x0+radius*cos(2.0*3.14*angle/360.0)    
    y = y0+radius*sin(2.0*3.14*angle/360.0)

    if x>px then jx=jx+abs(x-px)
    if x<px then jx=jx-abs(x-px)
    if y>py then jy=jy+abs(y-py)
    if y<py then jy=jy-abs(y-py)
    px=x
    py=y
numsteps=numsteps+1    
xcords(numsteps)=jx  
ycords(numsteps)=jy 
angle=angle+1
if angle>360 then angle=0    
next    
END SUB
'===============================================================================
SUB DARC_PATH2(x0 As Integer, y0 As Integer, radius as integer,xcords() as integer,ycords() as integer,byref numsteps as integer)
'Use this, better than darc_path
'Returns cordinates for a lower half circle
'Half Circle begins at beginning of half circle on right side
dim as integer x,y,px,py,jx,jy,nam,angle
px=x0
py=y0+radius
jx=x0
jy=y0
angle=0
numsteps=0

for nam=0 to 179
    x = x0+radius*cos(2.0*3.14*angle/360.0)    
    y = y0+radius*sin(2.0*3.14*angle/360.0)

    if x>px then jx=jx+abs(x-px)
    if x<px then jx=jx-abs(x-px)
    if y>py then jy=jy+abs(y-py)
    if y<py then jy=jy-abs(y-py)
    px=x
    py=y
numsteps=numsteps+1    
xcords(numsteps)=jx  
ycords(numsteps)=jy 
angle=angle+1
if angle>360 then angle=0    
next    
END SUB
'===============================================================================


'Data Structure for  Animation/Object
'TYPE ANIM_OBJ
'xwidth(1 to 100) as integer 'sprite width
'ywidth(1 to 100) as integer 'sprite height
'filename(1 to 100) as string 'file name of sprite
'spritebuf(1 to 100) as any ptr 'pointer to memory of sprite data
'sdis(1 to 100) as string 'sprite description string
'pvalue(1 to 100) as integer 'priority value of sprite
'flipv(1 to 100) as integer 'sprite flip data 0=Normal 1=Flip X 2=Flip Y 3=Flip X & Y    
    
'curx as integer 'Current X
'cury as integer 'Current Y
'nof as integer 'number of frames
'frameindex(1 to 100) as integer 'frame index
'soundz(1 to 100) as integer 'sound table index -1=no sound
'nocb(1 to 100) as integer 'number of collision boxes for frame
'cbd_x1(1 to 100) as integer 'collision box data x1
'cbd_y1(1 to 100) as integer 'collision box data y1
'cbd_x1w(1 to 100) as integer 'collision box data x1 width
'cbd_y1w(1 to 100) as integer 'collision box data y1 width
'fsta(1 to 100) as string 'frame state string general purpose
'cfn as integer 'current frame number
'sta as double 'starting time of animation
'fand as string 'animation notes/description string
'timing(1 to 100) as double 'delay between each frame 
'END TYPE
'SUB LOAD_SPRITE(varz as sprite,fname as string)
''loads an image to an array using the sprite data structure 
'varz.xwidth=GET_BMP_WIDTH(fname) 
'varz.ywidth=GET_BMP_HEIGHT(fname)
'varz.filename=fname
'varz.spritebuf=ImageCreate(varz.xwidth-1, varz.ywidth-1, RGB(0, 0, 0) )
'load_image varz.spritebuf,fname  
'END SUB 

'===============================================================================
FUNCTION COLLISION(x1 as integer,y1 as integer,x1width as integer,y1width as integer,x2 as integer,y2 as integer,x2width as integer,y2width as integer) as integer
'Returns 1 if a collision occured. Returns 0 if no collision happened.
COLLISION=0
if x1+x1width>=x2 then
    if x1<=x2+x2width then
        if y1+y1width>=y2 then
            if y1<=y2+y2width then COLLISION=1
        end if
    end if
end if
END FUNCTION
'===============================================================================
FUNCTION COLLISION_CHECK(object1 as objectz,object2() as objectz) as string
'The global variable ObjectCount must be set to reflect the current amount of active objects
'Returns if a collision happened or not among a number of objects.
'If a collision occurs it will return the unique names of the objects that collided.
dim nam as long
dim CC as string
COLLISION_CHECK=""
CC=""
for nam=1 to ObjectCount    
    if object1.uname=object2(nam).uname then
    else
    if object2(nam).conoff=1 then
    if COLLISION(object1.x,object1.y,object1.xwidth,object1.ywidth,object2(nam).x,object2(nam).y,object2(nam).xwidth,object2(nam).ywidth)=1 then
    CC=CC+"YES,"+object1.uname+","+object2(nam).uname+","':exit function
    end if
    end if
    end if
next
if len(CC)=0 then 
    COLLISION_CHECK="NO"
else
    COLLISION_CHECK=CC
end if    
END FUNCTION 
'===============================================================================
SUB TRANSLATE_CORDS(byref cx1 as integer,byref cy1 as integer,cbx as integer,cby as integer)
'Translate Collision Box Coordinates to current coordinates.
'cx1 cy1 = current coordinates
'cbx cby = collision box offsets
cx1=cx1+cbx
cy1=cy1+cby
END SUB
'===============================================================================