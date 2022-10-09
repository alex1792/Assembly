#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    FILE *fp1 = fopen("data.txt", "w+");
    // FILE *fp2 = fopen("data2.txt", "w+");

    srand((unsigned int)time(NULL));

    for (int i = 0; i < 400; i++)
    {
        for (int j = 0; j < 198; j++)
        {
            float a = ((float)(rand()) / RAND_MAX) * 10;
            // printf("%f\n", a);
            fprintf(fp1, "%f ", a);
            // a = ((float)(rand()) / RAND_MAX) * 10;
            // fprintf(fp2, "%f ", a);
        }
        fprintf(fp1, "\n");
        // fprintf(fp2, "\n");
    }

    fclose(fp1);
    // fclose(fp2);
    printf("Finish writing......\n");

    // fp1 = fopen("data.txt", "r");
    // float tmp;
    // printf("Read from data.txt:\n");
    // while (fscanf(fp1, "%f", &tmp) == 1)
    // {
    //     printf("%f\n", tmp);
    // }
    // fclose(fp1);

    return 0;
}