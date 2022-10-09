系級: 資工三
學號: 408410046
姓名: 龔鈺閎

1. 執行環境與硬體規格
    (i). 環境: WLS2 (Ubuntu 20.04)
    (ii). 硬體規格:
        a. cpu: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
        b. RAM: 8GB
    
2. 如何執行?
    直接在terminal打make後即會產生下列三個檔案:
        (i). generate_data
            在terminal輸入"./generate_data"後便會生成data.txt，當成hw07與hw07_SIMD的data
        (ii). hw07.exe
            在terminal輸入"./hw07.exe"後便會生成output.txt，裡面為計算結果以及讀檔、計算、輸出所花費的時間
        (iii). hw07_SIMD
            在terminal輸入"./hw07_SIMD.exe"後便會生成output_SIMD.txt，裡面為計算結果以及讀檔、計算、輸出所花費的時間

3. Performance
    (i). hw07.exe
        read_time: 17305600 (nano second)
        compute_time: 25928800 (nano second)
        output_time: 234300 (nano second)

    (ii). hw07_SIMD.exe(使用SIMD intrinsic function)
        read_time: 18006100 (nano second)
        compute_time: 18783600 (nano second)
        output_time: 251300 (nano second)

    (iii). SpeedUp
        針對compute的部分下去做分析，得到的結果為:
            25294300 / 18324800 = 1.38 倍的提升

4. 使用的指令
    SSE2的_mm_mul_pd與_mm_add_pd

5. 程式說明
    (i). hw07.c
        a.  讀資料
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
        
        b. 量測時間
            使用clock_gettime(CLOCK_REALTIME, &star_or_end)進行量測，因為時間都在1秒內執行完畢，所
            以我直接用timespec資料結構中的tv_nsec下去做計算，算出執行時間(nano second)
        
        c. 計算結果
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

        d. 輸出到檔案
            for (int i = 0; i < ROW; i++)
            {
                fprintf(fout, "%lf\n", result[i]);
            }
    
    (ii). hw07_SIMD.c
        a. 讀資料
            和hw07.c相同，不過變數宣告不太一樣:
                double data[200][200] __attribute__((aligned(16)));
                double data2[200][200] __attribute__((aligned(16)));
                double result[200] __attribute__((aligned(16)));

        b. 測量時間
            與hw07.c相同

        c. 計算結果
            使用SIMD intrinsic function做加法與乘法
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
        d. 輸出到檔案
            與hw07相同

6. 驗證正確性
    我使用了vimdiff以及使用指令tail去比對與查看兩者的輸出，確實是有一些誤差，不過還在可接受範圍內