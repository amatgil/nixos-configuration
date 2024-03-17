//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	//{"VPN: ", "/home/casenc/scripts/checkVPN.sh",                         1000,		0},
	{"Notis: ", "/home/casenc/scripts/checkNotifState",                      0,		7},
	{"Maus: ", "/home/casenc/scripts/checkMouselessState",                   0,		6},
	{"R: ", "/home/casenc/scripts/memory 2",                                30,		0},
	{"Bright: ", "/home/casenc/scripts/brightness 2",                        0,		4},
	{"Vol: ", "/home/casenc/scripts/volume 2",                               0,		5},
	{"Bat: ", "/home/casenc/scripts/battery 2",                             30,		1},
	{"Temp: ", "/home/casenc/scripts/maxtemp",                              10,		2},
	{"", "/home/casenc/scripts/date",                                       15,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
