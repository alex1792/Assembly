#include <stdio.h>
#include <time.h>
#define ROW 200
#define COLUMN 198

int main(int argc, char **argv)
{
    double A[200][200], B[200][200], result[200];

    struct timespec read_st, read_end, compute_st, compute_end, output_st, output_end;

    // set result array to zero
    for (int i = 0; i < ROW; i++)
    {
        result[i] = 0.0f;
    }

    clock_gettime(CLOCK_REALTIME, &read_st);
    FILE *fp = fopen("data.txt", "r");
    if (fp == NULL)
    {
        printf("No file named 'data.txt'\n");
        return -1;
    }

    // read A
    for (int i = 0; i < ROW; i++)
    {
        for (int j = 0; j < COLUMN; j++)
        {
            fscanf(fp, "%lf", &A[i][j]);
        }
        fscanf(fp, "\n");
    }
    // read B
    for (int i = 0; i < ROW; i++)
    {
        for (int j = 0; j < COLUMN; j++)
        {
            fscanf(fp, "%lf", &B[i][j]);
        }
        fscanf(fp, "\n");
    }
    fclose(fp);

    clock_gettime(CLOCK_REALTIME, &read_end);
    int read_time = read_end.tv_nsec - read_st.tv_nsec;

    // start computation
    clock_gettime(CLOCK_REALTIME, &compute_st);

    for (int i = 0; i < ROW; i++)
    {
        for (int j = 0; j < ROW; j++)
        {
            for (int k = 0; k < COLUMN; k++)
            {
                double tmp = A[i][k] * B[j][k];
                result[i] += tmp;
            }
        }
    }

    clock_gettime(CLOCK_REALTIME, &compute_end);

    // calculate computation time
    int compute_time = compute_end.tv_nsec - compute_st.tv_nsec;

    clock_gettime(CLOCK_REALTIME, &output_st);

    FILE *fout = fopen("output.txt", "w+t");
    if (fout == NULL)
    {
        printf("Fail To Open output.txt\n");
        return -1;
    } //if

    for (int i = 0; i < ROW; i++)
    {
        fprintf(fout, "%lf\n", result[i]);
    }

    clock_gettime(CLOCK_REALTIME, &output_end);
    int output_time = output_end.tv_nsec - output_st.tv_nsec;

    fprintf(fout, "\n");
    fprintf(fout, "read_time: %d nano_sec\n", read_time);
    fprintf(fout, "compute_time: %d nano_sec\n", compute_time);
    fprintf(fout, "output_time: %d nano_sec\n", output_time);

    return 0;
}
