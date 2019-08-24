'##############################
'mb_accurate_timing_lib is  a set of routines to make programs run at the same speed on all computers
'##############################
'#####################################################################################################
'mb_accurate_timing_lib
declare function FPS_DATA as string
declare function GET_DELAY(Target_FPS as long) as double
declare function TOP_OF_LOOP as double
declare sub LOOP_SLEEP(tol as double,delay as double)
'#####################################################################################################
'===============================================================================
FUNCTION FPS_DATA as string
'returns the current FPS, Average FPS, Last FPS    
'place this in the center of the main loop and always before calling LOOP_SLEEP
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
'===============================================================================
FUNCTION GET_DELAY(Target_FPS as long) as double
'convert target fps/cycles per second to decimal fractions of a second
GET_DELAY=1/Target_FPS
END FUNCTION
'===============================================================================
FUNCTION TOP_OF_LOOP as double
'always capture this at the top of the main loop
TOP_OF_LOOP=timer
END FUNCTION
'===============================================================================
SUB LOOP_SLEEP(tol as double,delay as double)
'always call this at the bottom of the main loop    
if (timer-tol)<delay then 
do    
loop until (timer-tol)>=delay    
end if    
END SUB 
'===============================================================================