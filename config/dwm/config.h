static const char *fonts[] = {
    "Source Code Pro Light:size=7.5",
};
static const char dmenufont[]       = "Source Code Pro Light-7.5";
static const char normbordercolor[] = "#073642";
static const char normbgcolor[]     = "#002b36";
static const char normfgcolor[]     = "#93a1a1";
static const char selbordercolor[]  = "#586e75";
static const char selbgcolor[]      = "#073642";
static const char selfgcolor[]      = "#93a1a1";

// Status bar.
static const Bool showbar     = True;
static const Bool showsystray = True;
static const Bool topbar      = True;

// Border size.
static const unsigned int borderpx = 1;
// Snap factor.
static const unsigned int snap = 8;

// Monitor to open dmenu on.
static char dmenumon[2] = "0";

static const char *dmenucmd[]      = { "dmenu_run.pl", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]       = { "st", "-c", "fish", NULL };
static const char *lockcmd[]       = { "xautolock", "-locknow", NULL };
static const char *locktogglecmd[] = { "xautolock", "-toggle", NULL };

// Number of master windows.
static const int nmaster = 1;
// Size of master windows.
static const float mfact = 0.5;
// Ignore resize/window size hints.
static const Bool resizehints = False;

static const char *tags[]     = { "1", "2", "3", "q", "w", "e", "a", "s", "d", "z", "x", "c" };

#include "btile.c"
#include "gaplessgrid.c"
static const Layout layouts[] = {
	/* symbol   arrange function */
	{ "[T]",      tile },
	{ "[B]",      btile },
	{ "[G]",      gaplessgrid },
	{ "[M]",      monocle},
	{ "[F]",      NULL },
};

static const Rule rules[] = {
	/* xprop(1):
	*	WM_CLASS(STRING) = instance, class
	*	WM_NAME(STRING) = title
	*/
	/* class                      instance    title       tags mask     isfloating   monitor */
	{ "st-meta-256color",         "fish",     NULL,       1 << 0,       False,       0 },
	{ "Gvim",                     NULL,       NULL,       1 << 1,       False,       0 },
	{ "st-meta-256color",         "vim",      NULL,       1 << 1,       False,       0 },
	{ "Spacefm",                  NULL,       NULL,       1 << 2,       False,       0 },
	{ "st-meta-256color",         "ranger",   NULL,       1 << 2,       False,       0 },
	{ "Transmission-remote-gtk",  NULL,       NULL,       1 << 3,       False,       0 },
	{ "Virt-manager",             NULL,       NULL,       1 << 6,       False,       0 },
	{ "VirtualBox",               NULL,       NULL,       1 << 6,       False,       0 },
	{ "st-meta-256color",         "htop",     NULL,       1 << 8,       False,       0 },

	{ "Google-chrome",            NULL,       NULL,       1 << 0,       False,       1 },
	{ "Chromium",                 NULL,       NULL,       1 << 0,       False,       1 },
	{ "Telegram",                 NULL,       NULL,       1 << 1,       False,       1 },
	{ "st-meta-256color",         "irssi",    NULL,       1 << 1,       False,       1 },
	{ "Thunderbird",              NULL,       NULL,       1 << 2,       False,       1 },
	{ "st-meta-256color",         "mutt",     NULL,       1 << 2,       False,       1 },
	{ "libreoffice",              NULL,       NULL,       1 << 3,       False,       1 },
	{ "Spotify",                  NULL,       NULL,       1 << 6,       False,       1 },
	{ "Vlc",                      NULL,       NULL,       1 << 7,       False,       1 },
	{ "mpv",                      NULL,       NULL,       1 << 7,       False,       1 },
	{ "Popcorntime",              NULL,       NULL,       1 << 7,       False,       1 },
	{ "Pavucontrol",              NULL,       NULL,       1 << 8,       False,       1 },
	{ "Paprefs",                  NULL,       NULL,       1 << 8,       False,       1 },

	{ "feh",                      NULL,       NULL,       0,            True,        -1 },
	{ "Gimp",                     NULL,       NULL,       0,            True,        -1 },
	{ "Zenity",                   NULL,       NULL,       0,            True,        -1 },
};

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#include "push.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_Return, spawn,          {.v = dmenucmd} },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd} },
	{ MODKEY,                       XK_grave,  spawn,          {.v = lockcmd} },
	{ MODKEY|ShiftMask,             XK_grave,  spawn,          {.v = locktogglecmd} },
	{ MODKEY,                       XK_Escape, killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_Escape, quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_Escape, quit,           {1} },
	{ MODKEY,                       XK_space,  zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_Tab,    setlayout,      {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1} },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1} },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1} },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1} },
	{ MODKEY,                       XK_h,      focusstack,     {.i = +1} },
	{ MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      focusstack,     {.i = -1} },
	{ MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1} },
	{ MODKEY|ShiftMask,             XK_j,      pushdown,       {0} },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1} },
	{ MODKEY|ShiftMask,             XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_b,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1} },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0} },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_q,                      3)
	TAGKEYS(                        XK_w,                      4)
	TAGKEYS(                        XK_e,                      5)
	TAGKEYS(                        XK_a,                      6)
	TAGKEYS(                        XK_s,                      7)
	TAGKEYS(                        XK_d,                      8)
	TAGKEYS(                        XK_z,                      9)
	TAGKEYS(                        XK_x,                      10)
	TAGKEYS(                        XK_c,                      11)
};

#include "cyclelayout.c"
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        nextlayout,    {0} },
	{ ClkLtSymbol,          0,              Button3,        prevlayout,    {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = dmenucmd } },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        toggleview,     {0} },
	{ ClkTagBar,            0,              Button3,        view,           {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
