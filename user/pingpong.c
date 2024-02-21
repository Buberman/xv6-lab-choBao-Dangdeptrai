#include "kernel/types.h"
#include "user/user.h"

int main(){
    int p[2];
    pipe(p);

    if (fork() ==0){
        close(p[1]);
        char buf;
        read(p[0], &buf,1);
        printf("%d: received ping\n",getpid());
        close(p[0]);
        exit(0);
    }
    else {
        close(p[0]);
        char ping = 'p';
        write(p[1],&ping,1);
        close(p[1]);
        wait(0);
        printf("%d: received pong\n",getpid());
        exit(0);
    }
}