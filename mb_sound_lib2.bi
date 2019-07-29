'##############################
'Directory Structure for mb_sound_lib
'
'(parent directory, name does not matter) 
'  |
'  |-+ 
'  | |inc (this must be included)
'  |
'  |-+ 
'  | |
'    |lib (this must be included)
'##############################
'mb_sound_lib is  a set of sound routines/wrapper built upon fbsound-1.0
'##############################
#include "inc/fbsound.bi"
'#####################################################################################################
'mb_sound_lib v2.0 routines
declare sub PREPARE_SOUND()
declare sub CLOSE_SOUND()
declare sub LOAD_MP3_TO_MEM(filen as string,hWave1 as integer,sound1 as integer,sound1_adr as integer)
declare sub PLAY_SOUND(sound_num as integer)
declare function IS_PLAYING(sound_num as integer) as string
declare sub PLAY_SOUND_MC(hWave1 as integer)
declare sub STOP_SOUND(sound_num as integer)
'#####################################################################################################
'===============================================================================
SUB PREPARE_SOUND 
'Initialize Sound
dim z as string
z=" "
dim f as long
dim f2 as long
dim fn(1 to 8) as string
fn(1)="lib/lin32/liblibplug-alsa-32.so"
fn(2)="lib/lin32/libplug-arts-32.so"
fn(3)="lib/lin32/libplug-dsp-32.so"
fn(4)="lib/lin64/libplug-alsa-64.so"
fn(5)="lib/win32/plug-ds-32.dll"
fn(6)="lib/win32/plug-mm-32.dll"
fn(7)="lib/win64/plug-ds-64.dll"
fn(8)="lib/win64/plug-mm-64.dll"

dim i as integer
for i=1 to 8
f=freefile
open fn(i) for binary as #f
f2=freefile
open mid(fn(i),11) for binary as #f2
z=space(lof(f))
get #f,,z
put #f2,,z
close f
close f2
next

dim as boolean ok
ok=fbs_Init()
END SUB
'===============================================================================
SUB CLOSE_SOUND
'Close fbsound  
dim as boolean ok
ok=fbs_Exit()  

dim fn(1 to 8) as string
fn(1)="lib/lin32/liblibplug-alsa-32.so"
fn(2)="lib/lin32/libplug-arts-32.so"
fn(3)="lib/lin32/libplug-dsp-32.so"
fn(4)="lib/lin64/libplug-alsa-64.so"
fn(5)="lib/win32/plug-ds-32.dll"
fn(6)="lib/win32/plug-mm-32.dll"
fn(7)="lib/win64/plug-ds-64.dll"
fn(8)="lib/win64/plug-mm-64.dll"

dim i as integer
dim i2 as integer
for i2=1 to 2
for i=1 to 8
kill mid(fn(i),11)
next
next

END SUB    
'===============================================================================
SUB LOAD_MP3_TO_MEM(filen as string,hWave1 as integer,sound1 as integer,sound1_adr as integer)
'Load an MP3 file to memory
fbs_Load_MP3File(filen,@hWave1)
fbs_create_sound(hWave1,sound1_adr)
END SUB    
'===============================================================================
SUB PLAY_SOUND(sound_num as integer)
'Play the sound or music. 
'If the sound is currently playing it will stop it and restart it.
fbs_play_sound(sound_num)    
END SUB     
'===============================================================================
FUNCTION IS_PLAYING(sound_num as integer) as string
'Is sound_num currently playing?
dim as integer spos
fbs_Get_SoundLoops(sound_num, @spos)
if spos=0 then IS_PLAYING="NO"
if spos=1 then IS_PLAYING="YES"
END FUNCTION
'===============================================================================
SUB PLAY_SOUND_MC(hWave1 as integer)
'Play the sound or music multi-channel. 
'It will play on another channel if the sound is currently playing.
fbs_Play_Wave hWave1
END SUB    
'===============================================================================
SUB STOP_SOUND(sound_num as integer)
'Stop sound_num from playing
fbs_Set_SoundLoops (sound_num,0)    
END SUB    
'===============================================================================
'###############################################################################
