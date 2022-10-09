#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <xmmintrin.h>
#define ROW 200
#define COLUMN 198

int main(int argc, char **argv)
{
    double data[200][200] __attribute__((aligned(16)));
    double data2[200][200] __attribute__((aligned(16)));
    double result[200] __attribute__((aligned(16)));
    __m128d *a, *b;
    double tmp[2] __attribute__((aligned(16)));
    __m128d *tmp2 = (__m128d *)tmp;

    struct timespec read_st, read_end, compute_st, compute_end, output_st, output_end;

    // initialize result array
    for (int i = 0; i < ROW; i++)
    {
        result[i] = 0.0f;
    }

    // read data from data.txt
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
            fscanf(fp, "%lf", &data[i][j]);
        }
        fscanf(fp, "\n");
    }

    // read B
    for (int i = 0; i < ROW; i++)
    {
        for (int j = 0; j < COLUMN; j++)
        {
            fscanf(fp, "%lf", &data2[i][j]);
        }
        fscanf(fp, "\n");
    }
    fclose(fp);

    clock_gettime(CLOCK_REALTIME, &read_end);
    int read_time = read_end.tv_nsec - read_st.tv_nsec;

    // computation
    clock_gettime(CLOCK_REALTIME, &compute_st);

    for (int i = 0; i < ROW; i++)
    {
        tmp[0] = 0.0;
        tmp[1] = 0.0;
        a = (__m128d *)data[i];

        for (int j = 0; j < ROW; j++)
        {
            b = (__m128d *)data[j];
            // cause I use the double type which is 8 byte(64 bit), so each time can
            // only deal with two data
            for (int k = 0; k < (COLUMN / 2); k++)
            {
                *tmp2 = _mm_add_pd(*tmp2, _mm_mul_pd(a[k], b[k]));
            }
            result[i] = tmp[0] + tmp[1];
        }
    }

    clock_gettime(CLOCK_REALTIME, &compute_end);
    int compute_time = compute_end.tv_nsec - compute_st.tv_nsec;

    // output
    clock_gettime(CLOCK_REALTIME, &output_st);

    FILE *fout = fopen("output_SIMD.txt", "w+t");
    if (fout == NULL)
    {
        printf("Fail To Open output_SIMD.txt\n");
        return -1;
    }

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
    fclose(fout);

    return 0;
}
