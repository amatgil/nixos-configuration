/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 1;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
/*static const char *fonts[]          = {"mononoki Nerd Font:size=10" };*/
static const char *fonts[]          = {" mononoki Nerd Font:style=Bold:size=9.8" };
/* static const char dmenufont[]       = "monospace:size=10";*/
static const char dmenufont[]       = "mononoki Nerd Font:style=Bold:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_red1[]         = "#ed3715";
static const char col_red2[]         = "#f84e2e";
static const char *colors[][4]      = {
	/*               fg         bg         border      float*/
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2, col_red2 },
	[SchemeSel] =  { col_gray4, col_cyan,  col_cyan, col_red1 },
	[SchemeStatus]  = { col_gray3, col_gray1,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { col_gray4, col_cyan,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  = { col_gray3, col_gray1,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  = { col_gray4, col_cyan,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  = { col_gray3, col_gray1,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

static const char *const autostart[] = { // Autostart real està a scripts/autostart
	"zsh", "-c", "/home/casenc/.config/suckless/dwm/dwmblocks/dwmblocks", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "Qalculate",NULL,       NULL,       0,            1,           -1 },
	{ "kalarm",   NULL,       NULL,       0,            1,           -1 },
	{ "ktimer",   NULL,       NULL,       0,            1,           -1 },
	{ "qt5autoclick",   NULL,       NULL,       0,            1,           -1 },
};


/* scripts */
static const char *transparencyToggle[] = {"~/.config/suckless/dwm/scripts/dmenu/compositor", "", NULL };
static const char *quitOrRestart[] = { "~/.config/suckless/dwm/scripts/dmenu/power", NULL };
static const char *displays[] = { "~/.config/suckless/dwm/scripts/dmenu/displays", NULL };
static const char *rofiPrompt[] = { "~/.config/suckless/dwm/scripts/rofi", NULL };
static const char *browser[] = { "/usr/bin/firefox", NULL };
static const char *saveScreenshot[] = { "~/.config/suckless/dwm/scripts/saveScreenshot", NULL };
static const char *seeScreenshot[] = { "~/.config/suckless/dwm/scripts/viewLastScreenshot", NULL };
static const char *clipboardScreenshot[] = { "~/.config/suckless/dwm/scripts/clipboardScreenshot", NULL };
static const char *wallpapers[] = { "~/.config/suckless/dwm/scripts/dmenu/wallpapers", NULL };
static const char *horari[] = { "~/.config/suckless/dwm/scripts/horari", NULL };
static const char *emacs[] = { "~/.config/suckless/dwm/scripts/emacs", NULL };
static const char *timeNStuff[] = { "~/.config/suckless/dwm/scripts/dmenu/timeNStuff", NULL };
static const char *emojiSelect[] = { "~/.config/suckless/dwm/scripts/dmenu/selectEmoji", NULL };
static const char *volumeUp[] = { "~/.config/suckless/dwm/scripts/volume", "1",  NULL }; 
static const char *volumeDown[] = { "~/.config/suckless/dwm/scripts/volume", "0",  NULL }; 
static const char *volumeMute[] = { "~/.config/suckless/dwm/scripts/volume", "-1",  NULL };
static const char *brightnessUp[] = { "~/.config/suckless/dwm/scripts/brightness", "1",  NULL };
static const char *brightnessDown[] = { "~/.config/suckless/dwm/scripts/brightness", "0",  NULL };
static const char *xmouseless[] = { "~/.config/xmouseless/xmouselessStart",  NULL };
//static const char *xmouseless[] = { "~/scripts/toggleMouseless",  NULL };
static const char *keynav[] = { "~/.config/keynav/keynavExecute",  NULL };
static const char *passwords[] = { "~/.config/suckless/dwm/scripts/passes",  NULL };




/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static int attachbelow = 1;    /* 1 means attach after the currently active window */

#include "horizgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster }, /*Unused because it probably looks ugly */
	{ "###",      horizgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      comboview,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      combotag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/zsh", "-c", cmd, NULL } }

/* helper for launching gtk application */
#define GTKCMD(cmd) { .v = (const char*[]){ "/usr/bin/gtk-launch", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *layoutmenu_cmd = { "/home/casenc/.config/suckless/dwm/layoutmenu.sh", NULL };

#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	// Start My section 
	{ MODKEY,                       XK_w,      spawn,          {.v = transparencyToggle} }, /* Toggle transparency */
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = quitOrRestart} }, /* Show quit menu */
	{ MODKEY|ControlMask,           XK_p,      spawn,          {.v = displays} }, /* Show display menu */
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = dmenucmd} }, /* Show dmenu prompt */
	{ MODKEY,                       XK_r,      spawn,          {.v = rofiPrompt} }, /* Show rofi prompt */
	{ MODKEY,                       XK_v,      spawn,          {.v = browser} }, /* Open Browser */
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = saveScreenshot} }, /* Take screenshot and save it to ~/.scrot */
	{ MODKEY|Mod1Mask,              XK_a,      spawn,          {.v = seeScreenshot} }, /* View the last N screenshots in ~/.scrot, where N is dictated by the script */
	{ MODKEY,                       XK_a,      spawn,          {.v = clipboardScreenshot} }, /* Take screenshot and save it to clipboard */
	{ MODKEY,                       XK_b,      spawn,          {.v = wallpapers} }, /* Select wallpapers */
	{ MODKEY,                       XK_c,      spawn,          {.v = horari} }, /* Show horari */
	{ MODKEY|ShiftMask,             XK_c,      spawn,          {.v = passwords} }, /* Show passwords menu */
	{ MODKEY,                       XK_e,      spawn,          {.v = emacs} }, /* Launch emacs */
	{ MODKEY|ShiftMask,             XK_e,      spawn,          {.v = emojiSelect} }, /* Bring up emoji selector (puts selected emoji into clipboard) */
	{ MODKEY,                       XK_g,      spawn,          {.v = timeNStuff} }, /* Display Misc menu */
	{ MODKEY,                       XK_m,      spawn,          {.v = volumeUp} }, /* Increase volume */
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = volumeDown} }, /* Decrease volume */
	{ MODKEY|Mod1Mask,              XK_m,      spawn,          {.v = volumeMute} }, /* Toggle mute */
	{ MODKEY,                       XK_n,      spawn,          {.v = brightnessUp} }, /* Increase brightness */
	{ MODKEY|ShiftMask,             XK_n,      spawn,          {.v = brightnessDown} }, /* Decrease brightness */
	{ MODKEY,                       XK_y,      spawn,          {.v = xmouseless} }, /* Start xmouseless script, to not have to use the mouse */
	{ MODKEY|ShiftMask,             XK_y,      spawn,          {.v = keynav} }, /* Start keynav script, to move the mouse to a specific part of the screen */
	{ MODKEY,                       XK_Left,   view_adjacent,  {.i = -1 } }, /* View tag on left */
	{ MODKEY,                       XK_Right,  view_adjacent,  {.i = +1 } }, /* View tag on right */
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } }, /* Move tag down */
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } }, /* Move tag up */
	{ MODKEY|ControlMask,           XK_j,      rotatestack,    {.i = +1 } }, /* Rotate stack down */
	{ MODKEY|ControlMask,           XK_k,      rotatestack,    {.i = -1 } }, /* Rotate stack up */
	{ MODKEY|ControlMask,           XK_w,      focusmon,       {.i = -1 } }, /* Focus monitor on left */
	{ MODKEY|ShiftMask|ControlMask, XK_w,      tagmon,         {.i = -1 } }, /* Send to monitor on left */
	{ MODKEY|ControlMask,           XK_e,      focusmon,       {.i = +1 } }, /* Focus monitor on right */
	{ MODKEY|ShiftMask|ControlMask, XK_e,      tagmon,         {.i = +1 } }, /* Send to monitor on right */
	// End My section
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } }, /* Spawn terminal */
	//{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } }, // Move down the stack
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } }, // Move up the stack
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = +1 } }, //Increase number of windows in master stack
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } }, //Decrase number of windows in master stack
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} }, // "Set master factor", how wide is the master stack
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} }, // "Set master factor", how wide is the master stack
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} }, // Make windows taller in tiling layout
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} }, // Make windows shorter in tiling layout
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f = 0.00} }, // Reset window height in tiling layout
	{ MODKEY,                       XK_space,  zoom,           {0} }, // Switch current window with master window
	{ MODKEY,                       XK_Tab,    view,           {0} }, // View last tag
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} }, // Kill window

	// Binding one key to the menu is the better way (menu can also be brought up by pressing the layout indicator next to the tags)
	{ MODKEY,                       XK_u,      layoutmenu,     {0} }, /* Bring up menu with options to change layout */

	{ MODKEY|ShiftMask,             XK_f,      togglefloating, {0} }, // Toggle floating
	{ MODKEY,                       XK_f,      togglefullscr,  {0} }, // Toggle fullscreen
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } }, /*View every tag*/
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } }, /*Move to every tag*/
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } }, /* Focus monitor on left */
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } }, /* Focus monitor on right */
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } }, /* Send to monitor on left */
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } }, /* Send to monitor on right */
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = -1 } }, /* Make gaps smaller */
	{ MODKEY,                       XK_minus,  setgaps,        {.i = +1 } }, /* Make gaps larger */
	{ MODKEY|Mod1Mask,              XK_minus,  setgaps,        {.i = 0  } }, /* Reset gaps */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
/* 1 is left, 2 is mid, 3 is right */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} }, /* Switch to previous layout */
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} }, /* Clicking on layout indicator prompts to change it */
	{ ClkMonNum,            0,              Button1,        focusmon,       {.i = +1} },
	{ ClkMonNum,            0,              Button3,        focusmon,       {.i = -1} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} }, /* Clicking title sets as master */
	// { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } }, /* Spawn terminal when clicking dwmblocks (time, mem, etc.) */
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} }, /* Mod+M1 moves window */
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} }, /* Mod+middle mouse sets floating */
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} }, /* Mod+M2 resizes */
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
