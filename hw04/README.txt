姓名: 龔鈺閎
系級: 資工三
學號: 408410046

如何編譯程式:
    直接在terminal打make,便會使用arm-none-eabi-gcc作為compiler對hw4_test.s以及numsort.s進行編譯

程式邏輯說明:
    先存12個數字在array中，程式一開始會將array的資料一一複製到result array內，接著對result進行
    bubble sort，最後result array的順序就是從小排到大。bubble sort的流程用c語言表示大概如下:

    int idx = array_size;
    while(idx > 0)
    {
        int i = 0;
        for(; i < idx; i++)
        {
            r7 = result[i];
            r8 = result[i + 1];
            if(r7 > r9)
            {
                tmp = r7;
                r7 = r8;
                r8 = tmp;
            }
        }
        idx--;
    }

查看程式執行結果:
    使用arm-none-eabi-insight，選擇hw4.exe，執行後查看register以及memory。
    r9表示array_size, r10表示result_array的address，在memory那塊可以輸入
    result_array的address去看排序後的結果，確認程式結果達到預期效果。