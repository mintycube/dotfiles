/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

static const unsigned int borderpx    = 1;   /* border pixel of windows */
static const unsigned int snap        = 32;  /* snap pixel */
static const int showbar              = 1;   /* 0 means no bar */
static const int topbar               = 0;   /* 0 means bottom bar */
static const int statusmon            = 'A';
static const char buttonbar[]         = "  ";

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype          = INDICATOR_NONE;
static int tiledindicatortype        = INDICATOR_NONE;
static int floatindicatortype        = INDICATOR_TOP_LEFT_SQUARE;
static int fakefsindicatortype       = INDICATOR_PLUS;
static int floatfakefsindicatortype  = INDICATOR_PLUS_AND_LARGER_SQUARE;
// static const char *fonts[]           = { "JetBrainsMono NF DWM:size=9" };
static const char *fonts[]           = { "CaskaydiaCove NF :pixelsize=12" };

static char c000000[]                = "#000000"; // placeholder value

static char normfgcolor[]            = "#bbbbbb";
static char normbgcolor[]            = "#222222";
static char normbordercolor[]        = "#444444";
static char normfloatcolor[]         = "#db8fd9";

static char selfgcolor[]             = "#eeeeee";
static char selbgcolor[]             = "#88c096";
static char selbordercolor[]         = "#88c096";
static char selfloatcolor[]          = "#88c096";

static char titlenormfgcolor[]       = "#bbbbbb";
static char titlenormbgcolor[]       = "#222222";
static char titlenormbordercolor[]   = "#444444";
static char titlenormfloatcolor[]    = "#db8fd9";

static char titleselfgcolor[]        = "#eeeeee";
static char titleselbgcolor[]        = "#88c096";
static char titleselbordercolor[]    = "#88c096";
static char titleselfloatcolor[]     = "#88c096";

static char tagsnormfgcolor[]        = "#bbbbbb";
static char tagsnormbgcolor[]        = "#222222";
static char tagsnormbordercolor[]    = "#444444";
static char tagsnormfloatcolor[]     = "#db8fd9";

static char tagsselfgcolor[]         = "#eeeeee";
static char tagsselbgcolor[]         = "#88c096";
static char tagsselbordercolor[]     = "#88c096";
static char tagsselfloatcolor[]      = "#88c096";

static char hidnormfgcolor[]         = "#88c096";
static char hidselfgcolor[]          = "#227799";
static char hidnormbgcolor[]         = "#222222";
static char hidselbgcolor[]          = "#222222";

static char urgfgcolor[]             = "#bbbbbb";
static char urgbgcolor[]             = "#222222";
static char urgbordercolor[]         = "#ff0000";
static char urgfloatcolor[]          = "#db8fd9";

static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]       = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]        = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]  = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]   = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]   = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]    = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]    = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]     = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]        = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

static const char *const autostart[] = {
	// "st", NULL,
	"dwmblocks", NULL,
	NULL
};

const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x28", NULL };
const char *spcmd2[] = {"st", "-n", "spcalc", "-g", "120x28", "-e", "qalc", "--color", "--interactive", NULL };
const char *spcmd3[] = {"qalculate-gtk", NULL };
const char *spcmd4[] = {"st", "-n", "spmusic", "-g", "100x25", "-e", "ncmpcpp", NULL };
const char *spcmd5[] = {"st", "-n", "spnotes", "-g", "120x34", "-e", "nvim", NULL };
static Sp scratchpads[] = {
   /* name          cmd  */
   {"spterm",    spcmd1},
	 {"spcalc",    spcmd2},
	 {"spcalcgui", spcmd3},
	 {"spmusic",   spcmd4},
	 {"spnotes",   spcmd5},
};

static char *tagicons[][NUMTAGS] =
{
	[DEFAULT_TAGS]        = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};

static const Rule rules[] = {
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
	// RULE(.class = "Gimp", .tags = 1 << 4)
	// RULE(.class = "Firefox", .tags = 1 << 7)
	RULE(.instance = "spterm", .tags = SPTAG(0), .isfloating = 1)
	RULE(.instance = "spcalc", .tags = SPTAG(1), .isfloating = 1)
	RULE(.class = "Qalculate-gtk", .tags = SPTAG(2), .isfloating = 1)
	RULE(.instance = "spmusic", .tags = SPTAG(3), .isfloating = 1)
	RULE(.instance = "spnotes", .tags = SPTAG(4), .isfloating = 1)
	RULE(.class = "volume-ui", .isfloating = 1)
};

static const BarRule barrules[] = {
	/* monitor   bar  alignment      widthfunc        drawfunc        clickfunc        hoverfunc    name */
	{ -1,        0, BAR_ALIGN_LEFT,  width_stbutton,  draw_stbutton,  click_stbutton,  NULL,        "statusbutton" },
	{ -1,        0, BAR_ALIGN_LEFT,  width_tags,      draw_tags,      click_tags,      hover_tags,  "tags" },
	{ -1,        0, BAR_ALIGN_LEFT,  width_ltsymbol,  draw_ltsymbol,  click_ltsymbol,  NULL,        "layout" },
	{ statusmon, 0, BAR_ALIGN_RIGHT, width_status2d,  draw_status2d,  click_statuscmd, NULL,        "status2d" },
};

/* layout(s) */
static const float mfact     = 0.50;
static const int nmaster     = 1;
static const int resizehints = 0;
static const int lockfullscreen = 1;

/* mouse scroll resize */
static const int scrollsensetivity = 15;
static const int scrollargs[][2] = {
	/* width change         height change */
	{ +scrollsensetivity,	0 },
	{ -scrollsensetivity,	0 },
	{ 0, +scrollsensetivity },
	{ 0, -scrollsensetivity },
};

static const Layout layouts[] = {
	{ "󰙀",  tile },    /* first entry is default */
	{ "󰖲",  NULL },
	{ "󰖯",  monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,  view,         {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,  toggleview,   {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,  tag,          {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,  toggletag,    {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "dwmblocks"

static const char *termcmd[]  = { "st", NULL };
static const char* dmenu_run_cmd[] = { "dmenu_run", "-bw", "2", "-i", "-W", "390", "-X", "961", "-Y", "15", "-l", "15", "-g", "3", NULL };
static const char* clipmenu_cmd[] = { "clipmenu", "-bw", "2", "-i", "-W", "290", "-X", "1061", "-Y", "15", "-l", "15", NULL };
static const Key on_empty_keys[] = {
/* modifier key           function     argument */
	{ 0, XK_w,         spawn,  {.v = (const char*[]){ "firefox", NULL } } },
	{ 0, XK_grave,     spawn,  {.v = (const char*[]){ "dmenunerdsymbols", NULL } } },
	{ 0, XK_BackSpace, spawn,  {.v = (const char*[]){ "sysact", NULL } } },
	{ 0, XK_r,         spawn,  {.v = (const char*[]){ "st", "-e", "lf", NULL } } },
	{ 0, XK_Return,    spawn,  {.v = (const char*[]){ "st", NULL } } },
	{ 0, XK_d,         spawn,  {.v = dmenu_run_cmd } },
	{ 0, XK_a,         spawn,  {.v = (const char*[]){ "dmenu_hub", NULL } } },
	{ 0, XK_space,     spawn,  {.v = (const char*[]){ "dmenu_web", NULL } } },
	{ 0, XK_n,         spawn,  {.v = (const char*[]){ "st", "-e", "nvim", NULL } } },
};

static const Key keys[] = {
	/* modifier           key           function        argument */
	{ 0,XF86XK_AudioMute,               spawn,		      SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; pkill -RTMIN+8 dwmblocks") },
	{ 0,XF86XK_AudioRaiseVolume,        spawn,		      SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%- && wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+; pkill -RTMIN+8 dwmblocks") },
	{ 0,XF86XK_AudioLowerVolume,	      spawn,		      SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%+ && wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-; pkill -RTMIN+8 dwmblocks") },
	{ 0,XF86XK_AudioPrev,		            spawn,		      {.v = (const char*[]){ "mpc", "prev", NULL } } },
	{ 0,XF86XK_AudioNext,		            spawn,		      {.v = (const char*[]){ "mpc",  "next", NULL } } },
	{ 0,XF86XK_AudioPause,		          spawn,		      {.v = (const char*[]){ "mpc", "pause", NULL } } },
	{ 0,XF86XK_AudioPlay,		            spawn,		      {.v = (const char*[]){ "mpc", "play", NULL } } },
	{ 0,XK_F7,                          spawn,          {.v = clipmenu_cmd } },
	{ 0,XF86XK_MonBrightnessUp,	        spawn,		      {.v = (const char*[]){ "xbacklight", "-inc", "15", NULL } } },
	{ 0,XF86XK_MonBrightnessDown,	      spawn,		      {.v = (const char*[]){ "xbacklight", "-dec", "15", NULL } } },
	{ 0,    			        XK_Print,	    spawn,		      {.v = (const char*[]){ "maimpick", NULL } } },
	{ MODKEY,             XK_Print,	    spawn,		      {.v = (const char*[]){ "dmenurecord", NULL } } },
	{ MODKEY|ShiftMask,   XK_Delete,    quit,           {0} },
	{ MODKEY,             XK_Delete,    quit,           {1} },
	{ MODKEY|ControlMask, XK_grave,     setscratch,     {.ui = 0 } },
	{ MODKEY|ShiftMask,   XK_grave,     removescratch,  {.ui = 0 } },
	{ MODKEY,             XK_0,         view,           {.ui = ~SPTAGMASK } },
	{ MODKEY|ShiftMask,   XK_0,         tag,            {.ui = ~SPTAGMASK } },
	TAGKEYS(              XK_1,                         0)
	TAGKEYS(              XK_2,                         1)
	TAGKEYS(              XK_3,                         2)
	TAGKEYS(              XK_4,                         3)
	TAGKEYS(              XK_5,                         4)
	TAGKEYS(              XK_6,                         5)
	TAGKEYS(              XK_7,                         6)
	TAGKEYS(              XK_8,                         7)
	TAGKEYS(              XK_9,                         8)
	{ MODKEY,			        XK_BackSpace,	spawn,		      {.v = (const char*[]){ "sysact", NULL } } },
	{ MODKEY|ShiftMask,		XK_BackSpace,	spawn,		      {.v = (const char*[]){ "sysact", NULL } } },
	{ MODKEY,             XK_Tab,       view,           {0} },
	{ MODKEY,             XK_q,         killclient,     {0} },
	{ MODKEY,			        XK_w,       	spawn,		      {.v = (const char*[]){ "firefox", NULL } } },
	{ MODKEY,			        XK_r,       	spawn,		      {.v = (const char*[]){ "st", "-e", "lf", NULL } } },
	{ MODKEY|ShiftMask,		XK_r,       	spawn,		      {.v = (const char*[]){ "thunar", NULL } } },
	{ MODKEY,		        	XK_t,		      setlayout,	    {.v = &layouts[0]} }, // tiled
	{ MODKEY,		        	XK_y,		      setlayout,	    {.v = &layouts[1]} }, // monocle
	{ MODKEY,		        	XK_u,		      setlayout,	    {.v = &layouts[2]} }, // none
	{ MODKEY,             XK_o,         incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,   XK_o,         incnmaster,     {.i = -1 } },
	{ MODKEY,			        XK_a,       	spawn,		      {.v = (const char*[]){ "dmenu_hub", NULL } } },
	{ MODKEY,             XK_d,         spawn,          {.v = dmenu_run_cmd } },
	{ MODKEY,             XK_f,   togglefakefullscreen, {0} },
	{ MODKEY,             XK_h,         setmfact,       {.f = -0.05} },
	{ MODKEY,             XK_l,         setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,  XK_apostrophe, togglescratch,	{.ui = 2 } },
	{ MODKEY,            XK_apostrophe, togglescratch,  {.ui = 1 } },
	{ MODKEY,             XK_Return,    spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,   XK_Return,    togglescratch,  {.ui = 0 } },
	{ MODKEY,             XK_m,         togglescratch,  {.ui = 3 } },
	{ MODKEY,             XK_comma,     togglescratch,  {.ui = 4 } },
	{ MODKEY,             XK_x,         transfer,       {0} },
	{ MODKEY,             XK_b,         togglebar,      {0} },
	{ MODKEY|ShiftMask,	  XK_b,       	spawn,		      {.v = (const char*[]){ "dmenu_web", "--add" , NULL } } },
	{ MODKEY,			        XK_n,       	spawn,		      {.v = (const char*[]){ "st", "-e", "nvim", NULL } } },
	{ MODKEY|ShiftMask,		XK_n,       	spawn,		      {.v = (const char*[]){ "st", "-e", "newsboat", NULL } } },
	// { MODKEY,	          	XK_m,       	spawn,		      {.v = (const char*[]){ "st", "-e", "ncmpcpp", NULL } } },
	{ MODKEY,             XK_space,     spawn,          {.v = (const char*[]){ "dmenu_web", NULL } } },
	{ MODKEY|ShiftMask,   XK_space,     togglefloating, {0} },
	{ MODKEY,             XK_Left,      focusdir,       {.i = 0 } },
	{ MODKEY,             XK_Right,     focusdir,       {.i = 1 } },
	{ MODKEY,             XK_Up,        focusdir,       {.i = 2 } },
	{ MODKEY,             XK_Down,      focusdir,       {.i = 3 } },
	{ MODKEY|ControlMask, XK_Up,        rotatestack,    {.i = +1 } },
	{ MODKEY|ControlMask, XK_Down,      rotatestack,    {.i = -1 } },
	{ MODKEY|Mod1Mask,    XK_Left,      shiftboth,      { .i = -1 } },
	{ MODKEY|Mod1Mask,    XK_Right,     shiftboth,      { .i = +1 } },
	{ MODKEY|ControlMask, XK_Left,   shiftviewclients,  { .i = -1 } },
	{ MODKEY|ControlMask, XK_Right,  shiftviewclients,  { .i = +1 } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click          event mask button    function           argument */
	{ ClkRootWin,     0,         Button1,  spawn,             SHCMD("dunstctl close-all; killall dmenu") },
	{ ClkRootWin,     0,         Button3,  spawn,             SHCMD("dunstctl close-all; pgrep -x 'dmenu' > /dev/null && killall dmenu || dmenu_hub") },
	{ ClkButton,      0,         Button1,  spawn,             {.v = dmenu_run_cmd } },
	{ ClkButton,      0,         Button3,  spawn,             {.v = (const char*[]){ "dmenu_hub", NULL } } },
	{ ClkLtSymbol,    0,         Button1,  setlayout,         {0} },
	{ ClkLtSymbol,    0,         Button3,  setlayout,         {.v = &layouts[2]} },
	{ ClkStatusText,  0,         Button1,  sigstatusbar,      {.i = 1 } },
	{ ClkStatusText,  0,         Button2,  sigstatusbar,      {.i = 2 } },
	{ ClkStatusText,  0,         Button3,  sigstatusbar,      {.i = 3 } },
	{ ClkStatusText,  0,         Button4,  sigstatusbar,      {.i = 4} },
	{ ClkStatusText,  0,         Button5,  sigstatusbar,      {.i = 5} },
	{ ClkStatusText,  ShiftMask, Button1,  sigstatusbar,      {.i = 6} },
	{ ClkClientWin,   MODKEY,    Button1,  movemouse,         {0} },
	{ ClkClientWin,   MODKEY,    Button2,  togglefloating,    {0} },
	{ ClkClientWin,   MODKEY,    Button3,  resizemouse,       {0} },
	{ ClkClientWin,   MODKEY,    Button4,  resizemousescroll, {.v = &scrollargs[0]} },
	{ ClkClientWin,   MODKEY,    Button5,  resizemousescroll, {.v = &scrollargs[1]} },
	{ ClkClientWin,   MODKEY,    Button6,  resizemousescroll, {.v = &scrollargs[2]} },
	{ ClkClientWin,   MODKEY,    Button7,  resizemousescroll, {.v = &scrollargs[3]} },
	{ ClkTagBar,      0,         Button1,  view,              {0} },
	{ ClkTagBar,      0,         Button3,  toggleview,        {0} },
	{ ClkTagBar,      MODKEY,    Button1,  tag,               {0} },
	{ ClkTagBar,      MODKEY,    Button3,  toggletag,         {0} },
};
