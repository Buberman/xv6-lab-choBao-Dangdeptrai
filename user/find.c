#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find_files(char* directory, char* target) {
    char buffer[512], *ptr;
    int file_descriptor;
    struct dirent directory_entry;
    struct stat file_stat;

    if((file_descriptor = open(directory, 0)) < 0) {
        fprintf(2, "find_files: cannot open %s\n", directory);
        return;
    }

    if(fstat(file_descriptor, &file_stat) < 0) {
        fprintf(2, "find_files: cannot stat %s\n", directory);
        close(file_descriptor);
        return;
    }

    if(file_stat.type != T_DIR) {
        fprintf(2, "find_files: %s is not a directory\n", directory);
        close(file_descriptor);
        return;
    }
    if(strlen(directory) + 1 + DIRSIZ + 1 > sizeof buffer){
        printf("find_files: path too long\n");
        close(file_descriptor);
        return;
    }

    strcpy(buffer, directory);
    ptr = buffer+strlen(buffer);
    *ptr++ = '/';

    while(read(file_descriptor, &directory_entry, sizeof(directory_entry)) == sizeof(directory_entry)) {
        if(directory_entry.inum == 0) 
            continue;
        if(strcmp(directory_entry.name, ".") == 0 || strcmp(directory_entry.name, "..") == 0)
            continue;
        memmove(ptr, directory_entry.name, DIRSIZ);
        ptr[DIRSIZ] = 0;
        if(stat(buffer, &file_stat) < 0) {
            fprintf(2, "find_files: cannot stat %s\n", buffer);
            continue;
        }

        switch (file_stat.type)
        {
        case T_FILE:
            if(strcmp(directory_entry.name, target) == 0) {
                printf("%s\n", buffer);
            }
            break;
        
        case T_DIR:
            find_files(buffer, target);
        }
    }
    close(file_descriptor);
}

int main(int argc, char *argv[]) {
    if(argc < 3){
        fprintf(2, "Usage: find_files path filename\n");
        exit(1);
    }
    find_files(argv[1], argv[2]);
    exit(0);
}

