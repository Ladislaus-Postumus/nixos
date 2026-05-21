static const Block blocks[] = {
	/* Icon  */ /* Command */                         /* Interval */ /* Signal */
	{ "", "/home/pme/.local/bin/status/volume.sh",        0,            1 },
	{ "", "/home/pme/.local/bin/status/network.sh",       10,           2 },
	{ "", "/home/pme/.local/bin/status/bluetooth.sh",     10,           3 },
	{ "",      "/home/pme/.local/bin/status/cpu.sh",      5,            5 },
	{ "",      "/home/pme/.local/bin/status/mem.sh",      5,            5 },
	{ "",      "/home/pme/.local/bin/status/gpu.sh",      5,            5 },

	{ "",      "date '+%H:%M %Y-%m-%d'",                  30,           0 },
};

static char delim[] = " | ";
static unsigned int delimLen = 3;
