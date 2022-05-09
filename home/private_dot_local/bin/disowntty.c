#include <signal.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main(void) {
  /* check that stdin is a tty */
  if (!isatty(STDIN_FILENO)) {
    perror("isatty()");
    goto end;
  }

  /* close the stdout buffer */
  setbuf(stdout, NULL);

  /* ignore the HUP signal */
  if (signal(SIGHUP, SIG_IGN) != SIG_DFL) {
    perror("signal(SIGHUP, IGN)");
    goto end;
  }

  /* make sure we're the sole owner of the tty */
  if (ioctl(STDIN_FILENO, TIOCSCTTY, 0) != 0) {
    perror("ioctl(TIOCSCTTY)");
    goto end;
  }

  /* disown the tty */
  if (ioctl(STDIN_FILENO, TIOCNOTTY) != 0) {
    perror("ioctl(TIOCNOTTY)");
    goto end;
  }

end:
  /* loop until killed */
  for (;;)
    pause();

  /* we should never get here, so this is an error */
  return 1;
}
