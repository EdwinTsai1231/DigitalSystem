# DigitalSystem FinalProject
## LittleDinosaur
### module Top () ;

圖的陣列 , 小恐龍狀態 , up and down 指令。

### module LD_state(); 按上下時小恐龍的狀態

### module Obstacle(); 生成新的圖

### module Hit() ; 撞到障礙物

### module Score(); 分數計算、遊戲加速


**備註： 此 top 也是此 Top**
```mermaid
classDiagram  
Top --> LD_state : 當按下 up 或 down\n 以及 每次更新時
Top --> Obstacle : 每次更新時
Top --> Hit : 每次更新時檢查\n小恐龍有沒有撞到
Top --> Score : 計算分數以及\n控制遊戲難度
LD_state --> top : 回傳新的小恐龍狀態
Obstacle --> top : 回傳新的地圖
Hit --> top : 回傳boolean 判斷是否撞到
Score --> top : 回傳目前計分\n以及更新後的遊戲難度
```