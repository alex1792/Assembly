姓名: 龔鈺閎
系級: 資工三
學號: 408410046

如何編譯程式:
    假設arm-none-eabi-gcc的執行檔的路徑為"/opt/bin/arm-none-eabi-gcc"，則makefile會在當前路徑下建立一個softlink指向
    /opt/bin/arm-none-eabi-gcc，然後會使用當前路徑下的softlink作為compiler對hw6_test.s以及numsort.s進行編譯。
    建議先make clean之後再make，確保result.txt有被清掉。

程式邏輯說明:
    與作業5差不多，只是多了把result array透過SWI的方式寫到result.txt中。

查看程式執行結果:
    最後會把初始順序以及排序結果輸出在console，並且輸出在result.txt中