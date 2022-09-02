# vps回程线路测试

基于BestTrace的回程线路测试：

```bash
curl -s https://raw.githubusercontent.com/BaeKey/BestTrace/master/BestTraceTest.sh | bash
```

结果说明可以参考：[Windows 和 Linux 下路由跟踪命令](https://v2try.com/archives/107.html)

对于默认禁PING的路由跳跃点显示结果隐藏了


# 网络介绍

## 中国三大 IP 中转运营商：

- 中国电信（China Telecom，CT）
- 中国联通（China Unicom，CU）
- 中国移动国际（China Mobile International，CMI）

## 一、电信

### 1、AS4134

AS4134（ChinaNet / 163 Net），ChinaNet也叫 163 骨干网，是大多数云运营商使用的最常见的往返中国的数据传输方式。

ip以 `202.97` 开头. 定位于承载普通质量的互联网业务, 基建早, 带宽大, 便宜。

### 2、AS4809 CN2 GT

> CN2，ip以 `59.43` 开头。CN2 相比较 163 网络，带宽小，稳定高速
>
> CN2分为 `CN2 GT` 和 `CN2 GIA`

CN2 GT（ChinaNet Next Carrier Network Global Transit 半程走 CN2）

CN2中端产品，本身接入网络是 ChinaNet（AS4134），省级骨干走163（去程和回程都会出现202.97节点），出口才走 CN2（AS4809）

### 3、AS4809 CN2 GIA

CN2 GIA（ChinaNet Next Carrier Networ Global Internet Access全程走 CN2）

CN2高端线路, 本身接入网络 CN2（AS4809），出口也是 CN2（AS4809） 

部分未部署CN2 节点的省份城市，会经163（202.97）然后接入CN2节点。CN2 GIA（Global Internet Access）的价格比CN2 CT（Global Transit）高出约3倍。

## 二、联通

### 1、AS4837

AS4837（联通 169 网络）是民用骨干网，定位相当于163。回程走海联通AS4837称之为 CU VIP

AS4837 的 IP 地址开头一般是 `219.158`

### 2、AS9929

AS9929 （联通A网, CU PM）， 定位相当于CN2，更像CN2 GT，服务于政企大客户。

AS9929  的 IP 地址开头一般是 `218.105` 或者 `210` 。也经常被称为 9929 网络。

### 3、AS10099

**AS10099**（中国联通国际，中国联通香港，CUG）。

提供至大陆方向的差异化接入，包括 CUG（AS10099 -> AS4837）和 CUG VIP（AS10099 -> AS9929 -> AS4837）

## 三、移动

### 1、CMI

CMI （China Mobile International Limited），移动自己的国际出口（AS58453--->AS9808） 一般回国有Qos限速

### 2、CMCB 

CMCB （移动商宽）国际出口，高Qos等级特权
