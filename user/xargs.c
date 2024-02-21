#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"
#include "kernel/fs.h" // Include for 'mkdir' syscall

#define DEBUG 0

#define debug(codes) if(DEBUG) {codes}

void xargs_exec(char* program, char** arguments);

void
xargs(char** first_arg, int size, char* program_name)
{
  char buf[1024];
  debug(
    for (int i = 0; i < size; ++i) {
      printf("first_arg[%d] = %s\n", i, first_arg[i]);
    }
  )
    char* arg[MAXARG];
  int m = 0;
  while (read(0, buf + m, 1) == 1) {
    if (m >= 1024) {
      fprintf(2, "xargs: arguments too long.\n");
      exit(1);
    }
    if (buf[m] == '\n') {
      buf[m] = '\0';
      debug(printf("this line is %s\n", buf);)
        memmove(arg, first_arg, sizeof(char*) * size); // Fixed size of the pointer
      // set a arg index
      int argIndex = size;
      if (argIndex == 0) {
        arg[argIndex] = program_name;
        argIndex++;
      }
      arg[argIndex] = malloc(sizeof(char) * (m + 1)); // Allocate memory for the argument
      if (arg[argIndex] == 0) {
        fprintf(2, "xargs: memory allocation failed.\n");
        exit(1);
      }
      memmove(arg[argIndex], buf, m + 1);
      debug(
        for (int j = 0; j <= argIndex; ++j)
          printf("arg[%d] = *%s*\n", j, arg[j]);
      )
        // exec(char*, char** paraments): paraments ending with zero
        arg[argIndex + 1] = 0;
      xargs_exec(program_name, arg);
      free(arg[argIndex]); // Free the allocated memory
      m = 0;
    }
    else {
      m++;
    }
  }
}

void
xargs_exec(char* program, char** arguments)
{
  if (fork() > 0) {
    wait(0);
  }
  else {
    debug(
      printf("child process\n");
    printf("    program = %s\n", program);

    for (int i = 0; arguments[i] != 0; i++) {
      printf("    arguments[%d] = %s\n", i, arguments[i]);
    }
    )
      if (exec(program, arguments) == -1) {
        fprintf(2, "xargs: Error exec %s\n", program);
      }
    debug(printf("child exit");)
  }
}

int
main(int argc, char* argv[])
{
  debug(printf("main func\n");)
    char* name = "echo";
  if (argc >= 2) {
    name = argv[1];
    debug(
      printf("argc >= 2\n");
    printf("argv[1] = %s\n", argv[1]);
    )
  }
  else {
    debug(printf("argc == 1\n");)
  }
  xargs(argv + 1, argc - 1, name);
  exit(0);
}
