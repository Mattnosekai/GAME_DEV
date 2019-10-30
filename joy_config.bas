#include once "windows.bi"
#include once "win/mmsystem.bi"
#include once "fbgfx.bi"

'This program configs Joystick 1 and Joystick 2.

dim shared as LONG_PTR g_pFBGfxWindowProc
dim shared as integer hwndFbgfx

dim shared as integer jsh_i 'Joystick Initializer

dim shared as integer x,y

jsh_i=0
'declare function mb_joystick_handler ( byval hwnd as HWND, byval uMsg as uinteger, byval wParam as WPARAM, byval lParam as LPARAM ) as integer

FUNCTION mb_joystick_handler ( byval hwnd as HWND, byval uMsg as uinteger, byval wParam as WPARAM, byval lParam as LPARAM ) as LRESULT
dim as double t
dim as integer i,csc,csc2,dv
dim as string p1orp2
p1orp2=""
    select case uMsg
    
     

     case MM_JOY1MOVE

        'print "MM_JOY1MOVE"
        'print "xPos = ", loword(lParam)
        'print "yPos = ", hiword(lParam)
       x=loword(lParam)
       y=hiword(lParam)       
      print "Joystick 1",x,y
      case MM_JOY1BUTTONDOWN

        'print "MM_JOY1BUTTONDOWN"
        'print (wParam AND JOY_BUTTON1)
        'print (wParam AND JOY_BUTTON2)
        'print (wParam AND JOY_BUTTON3)
        'print (wParam AND JOY_BUTTON4)
        'print (wParam AND JOY_BUTTON1CHG)
        if (wParam AND JOY_BUTTON1CHG) then csc=1000 
        if (wParam AND JOY_BUTTON2CHG) then csc=1001
        if (wParam AND JOY_BUTTON3CHG) then csc=1002
        if (wParam AND JOY_BUTTON4CHG) then csc=1003
        'print (1000-csc)+1
      case MM_JOY1BUTTONUP
       ' print (wParam AND JOY_BUTTON1)
       ' print (wParam AND JOY_BUTTON2)
       ' print (wParam AND JOY_BUTTON3)
       ' print (wParam AND JOY_BUTTON4)
        'print "MM_JOY1BUTTONUP"
        if (wParam AND JOY_BUTTON1CHG) then csc=1000 
        if (wParam AND JOY_BUTTON2CHG) then csc=1001
        if (wParam AND JOY_BUTTON3CHG) then csc=1002
        if (wParam AND JOY_BUTTON4CHG) then csc=1003
        'print (1000-csc)+1 
'###########################################
     case MM_JOY2MOVE

       ' print "MM_JOY2MOVE"
       ' print "xPos = ", loword(lParam)
        'print "yPos = ", hiword(lParam)
        x=loword(lParam)
        y=hiword(lParam)
      print "Joystick 2",x,y
      case MM_JOY2BUTTONDOWN

        'print "MM_JOY1BUTTONDOWN"
        'print (wParam AND JOY_BUTTON1)
        'print (wParam AND JOY_BUTTON2)
        'print (wParam AND JOY_BUTTON3)
        'print (wParam AND JOY_BUTTON4)
        'print (wParam AND JOY_BUTTON1CHG)
        if (wParam AND JOY_BUTTON1CHG) then csc=1000 
        if (wParam AND JOY_BUTTON2CHG) then csc=1001
        if (wParam AND JOY_BUTTON3CHG) then csc=1002
        if (wParam AND JOY_BUTTON4CHG) then csc=1003
        'print (1000-csc)+1
      case MM_JOY2BUTTONUP
       ' print (wParam AND JOY_BUTTON1)
       ' print (wParam AND JOY_BUTTON2)
       ' print (wParam AND JOY_BUTTON3)
       ' print (wParam AND JOY_BUTTON4)
        'print "MM_JOY1BUTTONUP"
        if (wParam AND JOY_BUTTON1CHG) then csc=1000 
        if (wParam AND JOY_BUTTON2CHG) then csc=1001
        if (wParam AND JOY_BUTTON3CHG) then csc=1002
        if (wParam AND JOY_BUTTON4CHG) then csc=1003
        'print (1000-csc)+1 
      case WM_KEYUP          
       if jsh_i=0 then 
        dv=joySetCapture( hwnd, JOYSTICKID1, 0, true )
        dv=joySetCapture( hwnd, JOYSTICKID2, 0, true )
       jsh_i=1
       end if
     end select
   





    return CallWindowProc( cast(WNDPROC,g_pFBGfxWindowProc),hWnd, uMsg, wParam, lParam )
END FUNCTION
'===============================================================================

SUB mb_install_joystick_handler
'Before calling this routine make sure the screen resolution has been set
'Call this Sub 1st before any other keyboard routines    



ScreenControl (FB.GET_WINDOW_HANDLE, hwndFbgfx) 
g_pFBGfxWindowProc = SetWindowLongPtr( cast(HWND,hwndFbgfx), GWLP_WNDPROC, cast(LONG,@mb_joystick_handler) )


'print joySetCapture( cast(HWND,hwndFbgfx), JOYSTICKID1, 0, true )

'0=Key Up 1=Key Down



'p1kb_sub=@mb_player1_motion_check
'p2kb_sub=@mb_player2_motion_check
Keybd_event VK_M,0,0,0
Keybd_event VK_M,0,KEYEVENTF_KEYUP,0
END SUB 


screenres 640,480,32
dim wMsg as MSG
dim hWnd as HWND





dim as string z,z2
dim as string joys(1 to 9)

joys(1)="JOYSTICK NEUTRAL    "
joys(2)="JOYSTICK UP         "
joys(3)="JOYSTICK DOWN       "
joys(4)="JOYSTICK LEFT       "
joys(5)="JOYSTICK RIGHT      "
joys(6)="JOYSTICK UP RIGHT  "
joys(7)="JOYSTICK DOWN RIGHT"
joys(8)="JOYSTICK UP LEFT   "
joys(9)="JOYSTICK DOWN LEFT "

dim as string sx(1 to 9),sy(1 to 9)
dim i as integer
z="1"

print "Select which Joystick to configure."
print
print "1=Player 1 Joystick config."
print "2=Player 2 Joystick config."
input z
cls
mb_install_joystick_handler
print
print "To capture JOYSTICK NEUTRAL don't touch the joystick and press Enter."
input z2
sx(i)=str(x)
sy(i)=str(y)
cls
for i=2 to 9
print "Input Player "+z+" "+joys(i)
print "Hold direction on Joystick and press Enter to confirm."
input z2
cls
sx(i)=str(x)
sy(i)=str(y)
next

dim f as long
f=freefile
open "JOYSTICK_Player"+z+"_config.txt" for output as f
for i=1 to 9
print #f,joys(i)+","+sx(i)+","+sy(i)+","
print joys(i)+","+sx(i)+","+sy(i)+","
next
close f    

print
print "Config Output in "+"JOYSTICK_Player"+z+"_config.txt"
print
print
print "Press ESC to exit program....."
do
loop until inkey=chr(27)
END
