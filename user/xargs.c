#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define MAXARGS 10

int main(int argc, char *argv[]) {
    char buf[512];
    char *args[MAXARGS + 2];
    int i, n;

    if (argc < 2) {
        fprintf(2, "Usage: %s command [args...]\n", argv[0]);
        exit(1);
    }

    args[0] = argv[1];
    for (i = 2; i < argc && i - 2 < MAXARGS; i++)
        args[i - 1] = argv[i];
    args[i - 1] = buf; 
    args[i] = 0; 

    while ((n = read(0, buf, sizeof(buf))) > 0) {
        char *p = buf;
        char *start = p;

        for (; p < buf + n; p++) {
            if (*p == '\n') {
                *p = '\0';
                args[i - 1] = start;
                if (fork() == 0) {
                    exec(args[0], args);
                    fprintf(2, "exec %s failed\n", args[0]);
                    exit(1);
                } else {
                    wait(0);
                }
                start = p + 1; 
            }
        }

        if (start < buf + n) {
            *p = '\0';
            args[i - 1] = start;
            if (fork() == 0) {
                exec(args[0], args);
                fprintf(2, "exec %s failed\n", args[0]);
                exit(1);
            } else {
                wait(0);
            }
        }
    }

    if (n < 0) {
        fprintf(2, "xargs: read error\n");
        exit(1);
    }

    exit(0);
}

