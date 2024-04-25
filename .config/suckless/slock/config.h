// user and group to drop privileges to
static const char *user = "nobody";
static const char *group = "nobody"; // use "nobody" for arch

static const char *colorname[NUMCOLS] = {
    [INIT] = "black",     // after initialization
    [INPUT] = "#005577",  // during input
    [FAILED] = "#CC3333", // wrong password
};

// insert grid pattern with scale 1:1, the size can be changed with logosize
static const int logosize = 8;
static const int logow =
    12; // grid width and height for right center alignment*/
static const int logoh = 6;

static XRectangle rectangles[] = {
   // x    y   w   h
   { 0,    3,  1,  3 },
   { 1,    3,  2,  1 },
   { 0,    5,  8,  1 },
   { 3,    0,  1,  5 },
   { 5,    3,  1,  2 },
   { 7,    3,  1,  2 },
   { 8,    3,  4,  1 },
   { 9,    4,  1,  2 },
   { 11,   4,  1,  2 },
};

// Xresources preferences to load at startup
ResourcePref resources[] = {
    {"locked", STRING, &colorname[INIT]},
    {"input", STRING, &colorname[INPUT]},
    {"failed", STRING, &colorname[FAILED]},
};

// treat a cleared input like a wrong password (color)
static const int failonclear = 1;

// Enable blur
#define BLUR
static const int blurRadius = 5; // Set blur radius
// Enable Pixelation
// #define PIXELATION
static const int pixelSize = 10; // Set pixelation radius

// allow control key to trigger fail on clear
static const int controlkeyclear = 1;

// time in seconds before the monitor shuts down
static const int monitortime = 5;
