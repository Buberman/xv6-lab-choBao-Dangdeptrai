#include "kernel/types.h"
#include "user/user.h"

#define N 35

void filter(int read_fd,int prime){
    int num;
    while(read(read_fd,&num,sizeof(int))>0){
        if (num % prime != 0){
            printf("prime %d\n", num);
        }
    }
    close(read_fd);
    exit(0);
}

int main(){
    int p[2];
    pipe(p);

    for(int i = 2;i<= N;i++){
        write(p[1],&i,sizeof(int));
    }
    close(p[1]);

    int prime;
    if(read(p[0],&prime,sizeof(int))>0){
        printf("prime %d\n", prime);

        int p2[2];
        pipe(p2);

        if (fork()==0){
            close(p[0]);
            close(p2[1]);
            filter(p2[0], prime);
        } else {
            close(p2[0]);
            filter(p[0],prime);
        }
    }

    wait(0);
    exit(0);
}