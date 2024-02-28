#include <stdio.h>

int *generate_nums(int n)
{
    int *elems = (int *)malloc(n * sizeof(int));

    if (!elems) {
        fprintf(stderr, "Malloc failed at %s:%d\n", __FILE__, __LINE__);
        exit(-1);
    }

    for (int i = 0; i < n; ++i)
        elems[i] = 2 * i + 2;
    
    return elems;
}

int main(void)
{
    int *elems = generate_even(10);
    for (int i = 0; i < 10; ++i)
        printf("%d ", elems[i]);
    printf("\n");

    free(elems);

    return 0;
}