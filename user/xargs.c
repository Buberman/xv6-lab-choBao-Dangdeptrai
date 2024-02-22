#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"
#include "kernel/fs.h"

#define MAXARGS 10
#define MAXCMDLEN 100

int getcmd(char *buf, int nbuf);
int gettoken(char **ps, char *es, char **q, char **eq);

int
main(int argc, char *argv[])
{
    char *xargs[MAXARGS];
    int xargs_count = 0;

    // Copy command-line arguments into xargs
    for (int i = 1; i < argc && xargs_count < MAXARGS; i++) {
        xargs[xargs_count++] = argv[i];
    }

    static char buf[MAXCMDLEN];
    char *cmd;
    int cmd_len;

    // Read commands from standard input
    while ((cmd_len = getcmd(buf, sizeof(buf))) > 0) {
        cmd = buf;

        // Tokenize the command
        char *token, *eq;
        while ((token = strchr(cmd, ' ')) != 0) {
            *token++ = 0;
            xargs[xargs_count++] = cmd;
            cmd = token;
            if (xargs_count >= MAXARGS) {
                break;
            }
        }
        if (xargs_count >= MAXARGS) {
            break;
        }
        eq = cmd + cmd_len - 1;
        while (eq >= cmd && (*eq == ' ' || *eq == '\n')) {
            *eq-- = 0;
        }
        xargs[xargs_count++] = cmd;

        // Fork and execute the command
        int pid = fork();
        if (pid < 0) {
            fprintf(2, "fork failed\n");
            exit(1);
        } else if (pid == 0) {
            exec(xargs[0], xargs);
            fprintf(2, "exec failed\n");
            exit(1);
        } else {
            wait(0);
        }
    }

    exit(0);
}

// Read a command from standard input
int
getcmd(char *buf, int nbuf)
{
    fprintf(2, "$ ");
    memset(buf, 0, nbuf);
    gets(buf, nbuf);
    if (buf[0] == 0) {
        return -1; // EOF
    }
    return strlen(buf);
}

// Tokenize a command
int
gettoken(char **ps, char *es, char **q, char **eq)
{
    char *s = *ps;
    int ret;

    while (s < es && strchr(" \t\r\n\v", *s)) {
        s++;
    }
    if (q) {
        *q = s;
    }
    ret = *s;
    switch (*s) {
        case 0:
            break;
        default:
            ret = 'a';
            while (s < es && !strchr(" \t\r\n\v", *s)) {
                s++;
            }
            break;
    }
    if (eq) {
        *eq = s;
    }

    while (s < es && strchr(" \t\r\n\v", *s)) {
        s++;
    }
    *ps = s;
    return ret;
}
