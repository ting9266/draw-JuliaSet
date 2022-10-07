# draw-JuliaSet

## 開發平台
Windows 10

## 開發環境
Code Block
Integrated Development Environment; IDE
GNU Compiler Collection (GCC)


## 題目說明
使用ARM Assembly 處理文字以及做簡易加減法,並在程式結束後讓畫面產生Julia Set 動畫,此專題需要掌握組合語言記憶體配置的方式、二維陣列位置的計算。


## 說明

程式總共分成3個function : Name, ID, draww, Main。

Name和ID與midterm project都相同，主要在draww這個function，它的主要目的就是賦予Frame二維陣列裡每個元素的值，這些元素的值，會決定它們投影在畫面上的顏色，利用老師提供的C範例程式碼，來建立與其具有相同功能的組合語言程式碼，其中有draww, preSet, preFor2, for2, while, whileStatement, processColor, for2Statement, for1Statement等label，下面會重點說明這些label的作用，最終一樣以main呼叫並執行即可。

## 設計重點說明

Name:
我們都使用r0來load組別和組員姓名的位置，每load完一個位置就printf印出來，最後便把組別和組員姓名印出完畢。

ID:
我們使用r0來load “%d”，並用r1將學號分別儲存進ALLId這個label，3個學號都輸入並儲存完成之後，用r2, r3, r4來分別儲存學號的位置，再將它們定址，把r2, r3, r4的值add到r5，用r0來load ”%s”，並讀取使用者輸入至r1，判斷r1是不是 ‘p’，若是，就把學號和學號的總和分行印出來，若不是，就結束。

以下為draww主要label之說明:

draww:
將fp, lr放入堆疊裡，讓fp指回fp，將r4~r10放入堆疊，r4~r10要來拿儲存某些變數的值，它們在這個function中不會再變成其他變數，在sp建立16bit的空間也是為了儲存變數，賦值給r4~r10，讓它們分別=cX, cY, width=640, height=480, i=0, x=0, y=0為後續的使用，最後呼叫for1Statement這個label。

preFor2:
賦值0給r10，每次for迴圈開始都要將y歸零，呼叫for2Statement這個label。

for2:
r6算術右移1個位元再賦值給r3，r2=r9-r3，將r1定址為1500拿來做乘法用，r0=r2*r1，將r3賦值給r1，呼叫__aeabi_idiv來做除法，除完的值會在r0，將r0賦值給r3並存進stack裡，以上可以完成C的zx = 1500 * (x - (width>>1)) / (width>>1) ; zy = 1000 * (y - (height>>1)) / (height>>1) ;也是相同作法，最後將r8賦值0然後呼叫whileStatement這個label。

while:
load zx的值給r2和r3，r2=r2*r3，load zy的值給r1和r3，r3=r1*r3，將它們相減，r2=r2-r3，將這個值給r0，賦值1000給r1，呼叫__aeabi_idiv來做除法，除完的值會在r0，r3=r0+r4，將r3存進stack裡，5，讓r3算數左移並賦值給r3，load zy的值給r2，r0=r2*r3，賦值1000給r1，呼叫__aeabi_idiv來做除法，除完的值會在r0，r3=r0+r5，將r3存在stack裡，將tmp之值load給zx，最後讓r8--。

whileStatement:
load zx的值給r2和r3，r2=r2*r3，load zy的值給r1和r3，r3=r1*r3，將它們相加，r2=r2+r3，load 399999給r3，比較r2和r3，若>則呼叫processColor這個label，若<=則將r8賦值給r3，比較r3和0，若>=則呼叫while這個label。

processColor:
將r8算術左移8個位元再賦值給r3，r8賦值給r2，r2和r3 or在一起變成16bit，將r3儲存進stack裡，r3=r3的補數並存進stack裡，將r10賦值給r2和r3，r3算術左移2個位元，r3=r2+r3，r3算術左移8個位元，最後加上陣列的起始位置，再加上x極為目前要存進二維陣列的位置，最後讓r10++。

for2Statement:
將r10賦值給r2，r7賦值給r3，比較r2和r3之大小，若<就進入for2這個label，若>=就讓r9++。

for1Statement:
將r9賦值給r2，r6賦值給r3，比較r2和r3之大小，若<=就進入preFor2這個label，若>就return並結束。


## 相關說明螢幕截圖
【NAME 起始位址】0x8774
![image](https://user-images.githubusercontent.com/95240041/194572768-a35c788a-24da-4e1f-8ce2-a06ed098b6e3.png)
【NAME 結束位址】0x8a24
![image](https://user-images.githubusercontent.com/95240041/194572874-f67b208a-60ef-4e74-a7d8-0219bd312556.png)
【ID 起始位址】0x862c
![image](https://user-images.githubusercontent.com/95240041/194572949-18426461-beeb-4444-9615-6888bb8183e1.png)
【ID 結束位址】0x8a30
![image](https://user-images.githubusercontent.com/95240041/194573097-b604eabf-8c97-49b1-acad-3a0c5f148cc1.png)
【DRAWWW 起始位址】0x87d4
![image](https://user-images.githubusercontent.com/95240041/194573179-0c78e810-2753-4d14-b005-7c02735e6ade.png)
【DRAWWW 結束位址】0x8b5c
![image](https://user-images.githubusercontent.com/95240041/194573261-0d533c78-30b9-4d7f-9068-d674edb7825c.png)
【frame 起始位址】
由 mov r6, sp 可知，程式開始時的 sp 在 0xbef69448 ,sp目前存*frame，可知sp + 4 即為frame 的起始位址 == 0xbef6944c。
![image](https://user-images.githubusercontent.com/95240041/194573342-f79541d3-456b-4c20-a74e-f065e43a1ad2.png)
【frame 結束位址】
frame的結束位址在frame 的起始位址 == 0xbef6944c + 614400 = 0xbefff44c
![image](https://user-images.githubusercontent.com/95240041/194573415-8fbeca72-2eda-4eac-ba07-80555c651763.png)
【frame 某段位址】
其中記憶體內容存 303(16) = 771(10)。這個數值代表陣列中某個點的值。這個值會在之後轉會為某個 16-bit 顏色。
![image](https://user-images.githubusercontent.com/95240041/194573511-87b78f03-918f-4d6a-b505-299e1bca1007.png)


## 執行畫面

![pic1](https://user-images.githubusercontent.com/95240041/194571754-227cad85-2672-475f-85a9-78270f6bd0ec.png)
![pic2](https://user-images.githubusercontent.com/95240041/194571772-5aa3e754-31ba-41d4-a17e-850dd5c2692b.png)
![pic3](https://user-images.githubusercontent.com/95240041/194571785-64e0c257-919c-47d6-94f0-bb1054d98249.png)
![pic4](https://user-images.githubusercontent.com/95240041/194571799-f974db5d-4b02-4543-ade0-88bee7d609dc.png)
![pic5](https://user-images.githubusercontent.com/95240041/194571809-1a1b037b-8355-4c78-afe2-aace99ca3f68.png)
