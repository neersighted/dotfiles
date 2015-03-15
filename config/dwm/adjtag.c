static void
adjtag(int n) {
    {
        int i, curtags;
        int seltag = 0;
        Arg arg;

        if (selmon != NULL) {
            curtags = (selmon->tagset[selmon->seltags] & TAGMASK);
        } else {
            return;
        }
        for (i = 0; i < LENGTH(tags); i++) {
            if ((curtags & (1 << i)) != 0) {
                seltag = i;
                break;
            }
        }

        seltag = (seltag + n) % (int)LENGTH(tags);
        if (seltag < 0)
            seltag += LENGTH(tags);

        arg.ui = (1 << seltag);
        view(&arg);
    }
}

static void
nexttag(const Arg *arg) {
    (void)arg;
    adjtag(+1);
}

static void
prevtag(const Arg *arg) {
    (void)arg;
    adjtag(-1);
}
