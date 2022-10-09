姓名: 龔鈺閎
學號: 408410046
系級: 資工三

解題邏輯:
    1.  r1, r2, r3 數值初始化為
    2.  r0初始化為0
    3.  將係數存到r4
    4.  r0 = r4 * r1
    5.  將係數存到r4
    6.  r1 = r4 * r2
    7.  將係數存到r4
    8.  r2 = r4 * r3
    9.  r0 += r1
    10.  r0 += r2

如何編譯程式:
    ~/arm-tool-20.4/bin/arm-none-eabi-gcc -g hw2.s -o hw2.exe

程式執行環境:
    執行環境為wsl
    在terminal後打指令"~/arm-tool-20.4/bin/arm-none-eabi-insight" 啟動insight後開啟hw2.exe並設定target為simulator

