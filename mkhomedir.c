/*
 *  mkhomedir
 *
 *  create and chown home folder
 *  need to be setuid to work
 *
 *  make
 *  sudo make install
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#ifdef OSX
# include <uuid/uuid.h>
#endif

int main(int argc, char **argv)
{
  uid_t         uid;
  gid_t         gid;
  struct passwd *p;

  uid = getuid();
  if (!uid) // no root
    return (-1);

  gid = getgid();

  p = getpwuid(uid);
  if (!p)
    return (-2);

  //  printf("uid: %u, gid: %u, home: %s\n", uid, gid, p->pw_dir);
  mkdir(p->pw_dir, 0700);
  chmod(p->pw_dir, 0700);
  chown(p->pw_dir, uid, gid);

  return (0);
}
