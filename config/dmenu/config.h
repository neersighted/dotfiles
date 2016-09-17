static Bool topbar        = True;
static unsigned int lines = 0;

static const char *prompt = NULL;
static const char *fonts[] = {
	"Source Code Pro Light-7.5"
};
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#93a1a1", "#002b36" },
	[SchemeSel] = { "#93a1a1", "#073642" },
	[SchemeOut] = { "#000000", "#00ffff" },
};
static const char worddelimiters[] = " ";
