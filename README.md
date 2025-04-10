# ios开发练习：数独游戏

需求：设计一个9*9的数独游戏，有简单、中等、困难，三种难度。并且界面支持黑暗模式，有一个计时器、和重新开始的按钮。

## 第一版
使用回溯算法生成数独谜题。将输入数字的按钮做成3*3的九宫格。

## 第二版
新需求：将数独本身的数字用红色、用户填写的数字用蓝色。
对用户点格子的识别范围太小、改为和格子一样大。

修改后：报错：Cannot find type 'View' in scope和Unknown attribute 'Binding'

1. Cannot find type 'View' in scope
含义：编译器无法识别 View 类型。
可能原因：
文件缺少 import SwiftUI 语句。
文件未正确配置为 SwiftUI 视图文件（例如，可能是纯 Swift 文件）。
项目配置不支持 SwiftUI。

3. Unknown attribute 'Binding'
含义：编译器无法识别 @Binding 属性包装器。
可能原因：
同样由于缺少 import SwiftUI，因为 @Binding 是 SwiftUI 特有的功能。
文件未正确关联 SwiftUI 框架。
这两个错误通常表明您的代码文件没有正确导入 SwiftUI 框架，或者文件类型配置有误。

## 第三版
修改：1.将数独中3*3的部分用淡红色做背景，其中左三列的上面三行和下面三行用淡红色，其他的不变。最右边三列的上面三行和下面三行用淡红色，其他的不变。中间三列的中间三行用淡红色，其他不变。
2.黑暗模式时，整个数独的最外侧边框用白色，原来的淡红色的部分用深灰色代替。
3.当用户成功解题时，将数独部分的画面变成”🎉太棒了“，然后下面显示记录的时长。然后5秒钟后重置。

## 第四版
用户点击的格子，没有选中的颜色，对用户选中的颜色用淡蓝色，如果是黑暗模式的话，用浅灰色。

## 第五版
修改后的代码虽然有选中的颜色了，但是原本的淡红色区域没有了。放弃淡红色的分区方法，改成对应的区域，用比其他边框更粗一些的边框来区别。

## 第六版
点击识别的范围又变小了。

## 第七版
在初次启动，切换难度、点击重置按钮时数独都要重新生成、并且不能和上一个相同。
