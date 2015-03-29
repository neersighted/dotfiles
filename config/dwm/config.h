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

static const Bool showbar = True;
static const Bool topbar  = True;

static const unsigned int borderpx = 1;

static const unsigned int snap = 32;

static char dmenumon[2] = "0";

static const char *dmenucmd[]      = { "dmenu_run.pl", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]       = { "st", NULL };
static const char *lockcmd[]       = { "xautolock", "-locknow", NULL };
static const char *locktogglecmd[] = { "xautolock", "-toggle", NULL };

static const int nmaster = 1;
static const float mfact = 0.7;

static const char *tags[]     = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static int def_layouts[1 + LENGTH(tags)]  = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "[M]",      monocle},
	{ "><>",      NULL },
};
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
};
static const Bool resizehints = False;

#include "adjtag.c"
#include "push.c"

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      toggletag,      {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      tag,            {.ui = 1 << TAG} },
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_c,      quit,           {0} },
	{ MODKEY,                       XK_r,      quit,           {1} },
	{ MODKEY,                       XK_x,      spawn,          {.v = lockcmd} },
	{ MODKEY|ShiftMask,             XK_x,      spawn,          {.v = locktogglecmd} },
	{ MODKEY,                       XK_Return, spawn,          {.v = dmenucmd} },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd} },
	{ MODKEY,                       XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_space,  zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_q,      setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_q,      view,           {0} },
	{ MODKEY,                       XK_h,      focusstack,     {.i = +1} },
	{ MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      focusstack,     {.i = -1} },
	{ MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1} },
	{ MODKEY|ShiftMask,             XK_j,      pushdown,       {0} },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1} },
	{ MODKEY|ShiftMask,             XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1} },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1} },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1} },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1} },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1} },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0} },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0} },
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

static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = dmenucmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        toggleview,     {0} },
	{ ClkTagBar,            0,              Button3,        view,           {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
