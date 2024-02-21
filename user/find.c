#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

#define MAX_PATH 512

char *strcat(char *dest, const char *src);

int match(char *s, char *p) {
    while (*s && *p) {
        if (*p == '*') {
            if (*(p + 1) == '\0') 
                return 1;
            while (*s) {
                if (match(s++, p + 1))
                    return 1;
            }
            return 0;
        } else if (*p == '.' || *s == *p) {
            s++;
            p++;
        } else {
            return 0;
        }
    }
    return *s == '\0' && *p == '\0';
}

void catdir(char *prefix, char *name, char *buf) {
    int prefix_len = strlen(prefix);
    int name_len = strlen(name);
    int i, j;

    for (i = 0; i < prefix_len; i++) {
        buf[i] = prefix[i];
    }

    buf[i++] = '/';

    for (j = 0; j < name_len; j++) {
        buf[i++] = name[j];
    }

    buf[i] = '\0';
}

void find(int fd, char *dir, char *name) {
    struct dirent de;
  
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
            continue;
        char path[MAX_PATH];
        catdir(dir, de.name, path);
        
        struct stat st;
        if (stat(path, &st) < 0) {
            fprintf(2, "find: cannot stat %s\n", path);
            continue;
        }
        
        if (st.type == T_FILE && match(de.name, name)) {
            printf("%s\n", path);
        } else if (st.type == T_DIR) {
            int subfd;
            if ((subfd = open(path, 0)) < 0) {
                fprintf(2, "find: cannot open %s\n", path);
                continue;
            }
            find(subfd, path, name);
            close(subfd);
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(2, "Usage: find dir name\n");
        exit(1);
    }

    char dir[MAX_PATH];
    char name[DIRSIZ + 1];

    if (strlen(argv[1]) > MAX_PATH - 2 || strlen(argv[2]) > DIRSIZ) {
        fprintf(2, "dir or name too long...\n");
        exit(1);
    }

    strcpy(dir, argv[1]);
    strcpy(name, argv[2]);

    int fd;
    struct stat st;

    if ((fd = open(dir, 0)) < 0) {
        fprintf(2, "find: cannot open %s\n", dir);
        exit(1);
    }

    if (fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", dir);
        close(fd);
        exit(1);
    }

    if (st.type != T_DIR) {
        printf("%s is not a directory\n", dir);
    } else {
        find(fd, dir, name);
    }

    close(fd);
    exit(0);
}
