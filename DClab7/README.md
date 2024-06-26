# 数字钟

本次实验主要分为三个模块

- 计数器
- 分频显示
- BCD译码器

## 计数器

本数字钟为时分秒电子钟，根据常识，小时为24进制，分钟和秒为60进制，可以使用74160计数器（模十），则小时为3进制 + 10进制， 分钟和秒为6进制 + 10进制。

该电路为异步钟控，其中分和秒为59的时候clear（~~小时的忘了~~）。

## 分频显示

这个个人认为算是比较难理解的，该技术可以实现在IO设备不足的情况下，输出多种数据。

![](https://s2.loli.net/2024/04/14/HsRWMhXnEQYJCUm.png)

首先需要一个choose Clock，这个一般是很高频的，通过分频器(7493)，输出三路高频时钟脉冲，然后接到3-8Decoder 和 MUX的地址端。

当然上述描述确实很抽象，咱可以以choose Clock 为一个时间线，首先咱需要知道，经过7493分频后的三路信号是会从000~111（假定为CBA的顺序）一直循环的，所以这个时间线就是000, 001, 010, ..., 111, 000, 001, ...好，那么现在经过一段时间，choose Clock的时间为001，那么现在Decoder选中了LED2（$\overline{Y_1}$，然后各MUX均选中各自的D1，再跟着电路回溯，各D1其实是由第二个74160的$Q_A \text{  } Q_B \text{  } Q_C \text{  }Q_D$，发出的。

所以现在，是001时刻，LED2亮，数值由第二74160决定。

再到下一时刻，010，3-8译码器选中 $\overline{Y_2}$则LED3亮，各MUX选择$D_2$输出，数据为第三个74160的$Q_A \text{  } Q_B \text{  } Q_C \text{  }Q_D$。

....

如此循环往复，每一个时刻，选中一个LED灯，输出它的值。

当然，很显然，老师会叫我们把这个choose Clock接1kHz，这样可以创造一种illusion / 假象，每个LED看上去都常亮（独占显示资源），但其实只是因为时间片很小，各LED看似并行parallel实则并发concurrency（是不是很像OS hhhh）

## BCD译码器

跟之前用的不同，这个是封装得相对浅的，需要经过一个7448将四位二进制数（BCD）转为abcdefg各晶体管然后输出数值。

（随便找的图，仅供参考）

![](https://s2.loli.net/2024/04/14/QgwJptqYymUjHE5.png)