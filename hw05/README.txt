姓名: 龔鈺閎
系級: 資工三
學號: 408410046

如何編譯程式:
    直接在terminal打make,便會使用arm-none-eabi-gcc作為compiler對hw4_test.s以及numsort.s進行編譯

程式邏輯說明:
    先存12個數字在array中，程式一開始會先call malloc()分配result array的記憶體空間，將array的資料一一複製到
    result array內，接著對result進行bubble sort，最後result array的順序就是從小排到大。這次使用apcs的寫法，
    bl NumSort之後會把result address存放在r0暫存器，最後再用r9.r10做為輸出的for loop counter，再call printf()
    把result array的值輸出在console中。

查看程式執行結果:
    最後會把初始順序以及排序結果輸出在console