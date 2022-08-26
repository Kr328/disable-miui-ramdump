#include <stdio.h>
#include <unistd.h>

int main() {
    int fds[2] = {0, 0};

    if (pipe(fds) < 0) {
        printf("Pipe create failed");

        return 1;
    }

    char buf[1] = {0};
    
    return read(fds[0], buf, 1);
}
