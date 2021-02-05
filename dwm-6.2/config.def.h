/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 20;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 20;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Mononoki Nerd Font:size=10", "JoyPixels:pixelsize=12:antialias=true:autohint=true" };
static const char dmenufont[]       = "Mononoki Nerd Font:size=16";
static const char col_gray1[]       = "#282828";
static const char col_gray2[]       = "#928374";
static const char col_gray3[]       = "#d5c4a1";
static const char col_gray4[]       = "#ebdbb2";
static const char col_cyan[]        = "#3c3836";
static const char col_norm[]        = "#d65d0e";
static const char col_norm2[]        = "#b16286";
static const char col_norm3[]        = "#d79921";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] 		 = { col_norm, col_cyan, col_cyan},

	[SchemeSel]  		 = { col_gray4, col_norm2,  col_norm3  },
	[SchemeStatus] 	 = { col_norm2, col_cyan,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}

	[SchemeTagsSel]  = { col_gray1, col_norm3,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
  [SchemeTagsNorm] = { col_norm2, col_cyan,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}

  [SchemeInfoSel]  = { col_gray4, col_cyan,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
  [SchemeInfoNorm] = { col_norm2, col_cyan,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

static const char *const autostart[] = {
	//"$HOME/.dwm/autostart.sh", NULL,
	/*"pulsemixer", "-k", NULL,
	"firefox", NULL,
	"variety", NULL,
	"redshift", NULL,
	"picom", "--experimental-backends", "--detect-rounded-corners", NULL,
	"setxkbmap","us,ru,fi",",winkeys","grp:alt_shift_toggle", NULL,
	"$HOME/.local/scripts/status/launch", NULL,
	"enact", "--pos", "top", NULL,
	"pulseaudio","-k", NULL,
	*/
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "ﳎ ", " ", " ", " ", "", "", " ", " ", "龎 " };
static const char *tagsalt[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/* launcher commands (They must be NULL terminated) */
static const char* spotify[]      = { "spotify", "spotify", NULL };

static const Launcher launchers[] = {
       /* command       name to display */
	{ spotify,         "阮 " },
};


static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
/* class      instance    title       tags mask     isfloating   monitor    scratch key */
{ "Gimp",     NULL,       NULL,       0,            1,           -1,        0  },
{ "firefox",  NULL,       NULL,       1 << 1,       0,           -1,        0  },
{ "spotify",  NULL,       NULL,       7     ,       0,           -1,        0  },
{ NULL,       NULL,   "scratchpad",   0,            1,           -1,       's' },
{ NULL,       NULL,   "sp_volume",    0,            1,           -1,       'v' },
{ NULL,       NULL,   "Todoist",   0,            1,           -1,       't' },
{ NULL,       NULL,   "PomoDoneApp",   0,            1,           -1,       'p' },
{ NULL,       NULL,   "ScratchEmacs", 0,            1,           -1,       'e' },
{ NULL,       NULL,   "Task - No Summary", 0,            1,           -1,       0 }
};
// default gaps
/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands  ,*/
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, "-c", "-l", "20", NULL};
static const char *termcmd[]  = { "alacritty", NULL };
static const char *flameshot[]  = { "flameshot","gui", NULL };
static const char *deadd_notify[]  = {  "/home/horhik/.local/scripts/deadd_notify", NULL};

/*First arg only serves to match against key in rules*/
static const char *scratchpadcmd[] = {"s", "alacritty", "-t", "scratchpad", NULL};
static const char *sp_emacs[] = {"e", "emacs", "-T", "ScratchEmacs", NULL};
static const char *sp_volume_control[] = {"v","alacritty", "-t", "sp_volume","-e", "pulsemixer", NULL};
static const char *tasks[] = {"t","todoist", NULL};
static const char *pomo[] = {"p","pomodone", NULL};
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = flameshot } },
	{ MODKEY|Mod1Mask,              XK_space,  spawn,          {.v = deadd_notify } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|Mod1Mask,              XK_h,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_l,      incrgaps,       {.i = -10 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +10 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -10 } },
	{ MODKEY|Mod1Mask|ControlMask,  XK_h,      incrigaps,      {.i = +10 } },
	{ MODKEY|Mod1Mask|ControlMask,  XK_l,      incrigaps,      {.i = -10 } },
	{ MODKEY|Mod1Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_y,      incrihgaps,     {.i = +10 } },
	{ MODKEY,                       XK_o,      incrihgaps,     {.i = -10 } },
	{ MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +10 } },
	{ MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -10 } },
	{ MODKEY|Mod1Mask,              XK_y,      incrohgaps,     {.i = +10 } },
	{ MODKEY|Mod1Mask,              XK_o,      incrohgaps,     {.i = -10 } },
	{ MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +10 } },
	{ MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -10 } },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -5 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +5 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	/*SCRATCHPADS*/
	{ MODKEY,                       XK_u,      togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY|ShiftMask,             XK_m,      togglescratch,  {.v = sp_volume_control } },
	{ MODKEY,                       XK_e,      togglescratch,  {.v = sp_emacs } },
	{ MODKEY|ShiftMask,             XK_d,      togglescratch,  {.v = tasks } },
	{ MODKEY,             XK_d,      togglescratch,  {.v = pomo } },
	{ MODKEY,                       XK_n,      togglealttag,   {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

