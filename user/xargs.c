#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define MAXARGS 32
#define MAXLINE 128

// Function to execute a program with arguments
void xargs_exec(char *program, char **arguments) {
    if (fork() == 0) {
        exec(program, arguments);
        fprintf(2, "xargs: exec %s failed\n", program);
        exit(1);
    } else {
        wait(0);
    }
}

// Function to read input from standard input
void xargs(char *program, char **arguments) {
    char buf[MAXLINE];
    int len;
    char *args[MAXARGS + 1]; // Additional space for NULL terminator
    int argc;

    while ((len = read(0, buf, sizeof(buf))) > 0) {
        // Null-terminate the string
        buf[len] = '\0';

        argc = 0;
        args[argc++] = program; // The first argument is the program itself

        // Tokenize the input line
        char *token = strtok(buf, " \t\r\n\v");
        while (token != NULL && argc < MAXARGS) {
            args[argc++] = token;
            token = strtok(NULL, " \t\r\n\v");
        }
        args[argc] = NULL; // Null-terminate the argument list

        // Execute the program with arguments
        xargs_exec(program, args);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: %s <program>\n", argv[0]);
        exit(1);
    }

    // Pass the program name and arguments to xargs
    xargs(argv[1], &argv[1]);

    exit(0);
}
