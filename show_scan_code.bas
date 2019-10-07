#include "mb_keyboard_lib1.bi"

screenres 640,480,32


mb_install_keyboard_handler 'this installs the keyboard handler, always call it AFTER setting the screen resolution



'This Demo shows the scan code for the last key pressed


do
print keyboard_lkp 'this is a global variable that holds the scan code of the last key pressed in a string
loop until inkey = chr(27)
