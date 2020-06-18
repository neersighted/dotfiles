#include <signal.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main(void) {
  setbuf(stdout, NULL);

  if (signal(SIGHUP, SIG_IGN) != SIG_DFL) {
    perror("signal(SIGHUP)");
    return 1;
  }

  if (ioctl(STDIN_FILENO, TIOCSCTTY, 0) != 0) {
    perror("ioctl(TIOCSCTTY)");
    return 1;
  }

  if (ioctl(STDIN_FILENO, TIOCNOTTY) != 0) {
    perror("ioctl(TIOCNOTTY)");
    return 1;
  }

  for (;;)
    pause();
}
