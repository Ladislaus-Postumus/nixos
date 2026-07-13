static const Block blocks[] = {
    /* Icon  */ /* Command */ /* Interval */ /* Signal */
    {"", "volume-stat", 1, 1},
    {"", "network-stat", 5, 2},
    {"", "bluetooth-stat", 10, 3},
    {"", "cpu-stat", 1, 5},
    {"", "mem-stat", 1, 5},
    {"", "gpu-stat", 1, 5},

    {"", "date '+%H:%M %Y-%m-%d'", 30, 0},
};

static char delim[] = " | ";
static unsigned int delimLen = 3;
