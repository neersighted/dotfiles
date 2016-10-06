static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	"black",   /* after initialization */
	"#002b36", /* during input */
	"#dc322f", /* failed/cleared the input */
};
static const Bool failonclear = True;
