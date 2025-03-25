# Part 1 语法规则
## 一、命令处理
- 基本编辑内容与编程差不多
- 命令 + 参数 -> 结果0
## 二、 替换
### 1. 变量替换 `$`
- eg: **`set a 1; set b $a`** 这里 $a = 1.
- ps: 如果需要替换除**数字、字母、下划线**外的变量,需要**大括号** 
    - eg : **`set b ${a~}`**
### 2. 命令替换 `[]`
- eg: **`set a [expr 1+2]`** 
### 3. 反斜杠替换 `\`
- 转义符用法
## 三、 引用
- 用于阻止解析器 `$`、`；`、等特殊字符进行特殊处理
- eg: **`/$`**可以阻止`$`的替换直接输出字符`$`
### 1. 弱引用 `""`（不可嵌套）
- `""`内部的替换和[]仍有效
- eg : **`set msg "egg price is /$$price"`**
### 2. 强引用 `{}`（可嵌套）
- {}内都作为字符赋给变量
- eg : `waiting`
# Part 2 匹配方式
### 1. exact 严格匹配，无通配符
### 2. glob 有通配符
- 通配符  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-1.png?raw=true)
### 3. 正则表达式 
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-2.png?raw=true)
- 这个能随便搜个网站来练练:p
---
# Part 3 变量
- 1.用`set`创建,`unset`移除
- 2.用`$`调用
- 3.命名方式： 在C/Python的基础上可用特殊字符
- 4.类型：`string、list、array、direction……`
- 5. 存储类型： 字符串表达式、内部表达式形式
    - 内部表达式形式eg: `set a [expr $a+1]`.
---
## 1.`string`的常用命令
### `①string match Pattern str` 用于匹配
### `②string equal str1 str2` 用于*严格*匹配
### `③string compare str1 str2` 用于比较，按字典优先返回0、-1、1
### `④string length str` 返回字符串长度（空格、换行符也回被算上）
### `⑤string index str charlndex` 返回charlndex的位置字符
### `⑥string range str first last` 返回first-last区间的字符
### `⑦string replace str first last newstring` 用newstring替换first-last的字符串，如果呢我string不存在，则删除该区间的字符串 
### `⑧string map mapping str` 也是替换，例子自己额外查:p
### .........
## 2.`list`的用法
### (1)创建`list`
-  `set list_name "your context"`
-  `set list_name {your context}`
-  `set list_name [your context]`
### (2)`list`常用命令
- 略....需要用的时候自查
- 拼接、替换、重复、分割、添加...
## 3.`array`的用法
### (1)创建`array`
- `set arrayName(key) value`
### (2)其他用法自行查阅资料...
# Part 3 表达式
### `expr`命令
- 具体操作  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-3.png?raw=true)
- ！！表达式注意操作数类型  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-4.png?raw=true)
# Part 4 流控制
## 1.`if`
### `if`的用法类似于verilog的if
- eg：![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-6.png?raw=true)
- ！！`{`与`if`写在同一行 且 `if`与`{`之间必须要有空格
## 2.`while`
### 同样类似于verilog/C的`while`
- eg:![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-5.png?raw=true)
## 3.`for`
## 4.`foreach` （需熟练）
- `foreach varname list body`将list赋值给varname进行循环
- eg:![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-7.png?raw=true)
- 可支持多变量数组:  
 `foreach varlist1 list1 ?varlist2  list2?...`  
 `foreach {varlist1 varlist2...} {list}`
 ## 5.`switch`
 ### 用法类似于verilog 的`case`
 - 支持三种匹配方式（默认 **exact**）
 - eg：![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-8.png?raw=true)
# Part 5 函数
## 1. 基本结构  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-10.png?raw=true)  跟C语言差不多，不过规则必C语言稍严格
## 2. 写法
### (1)同基本结构的例子
### (2)带缺省值
- eg：![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-11.png?raw=true)
- ！注意：缺省值一定要写在参数的末尾，且有缺省值的参数必须含有缺省值（默认值）
### (3)可变参数
- eg:![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-12.png?raw=true) 
### 
# Part 6 文件操作
## 1.读写文件
### (1)打开文件  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-18.png?raw=true)  
- 操作符  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-19.png?raw=true)
### (2)读取文件内容
- 这里是逐行读取**rfile_handle**指向的文件，将带有**"VIOLATED"**的行打印到**wfile_handle**指向的文件  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-20.png?raw=true)
### (3)关闭文件  
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-21.png?raw=true)  
- 命令返回一个空字符串
## 2.文件操作
### (1)`glob`命令
- 多用于查找文件
- eg：![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-22.png?raw=true)
- glob的通配符在上边有，自行查看
### (2)`file`命令
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-23.png?raw=true)
# Part 7 常用命令
## 感觉跟linux里边用的差不多...
----------------
# Part 😈 其余小知识
### 1. 反斜杠
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/2.png?raw=true)
### 2. glob 返回的待处理长参数
- 比如空格可以在`glob`命令前用`{*}`进行分割
- eg: **`file delte {*}[glob *v]`**
### 3. option中如果有 `?-nocase?`两问号括住的表示为*可用可不用*
### 4.`incr`命令用于自增，`incr varName ?increment?`，默认为1
### 5.`-`表示使用和下一个模式一样的脚本
- eg：![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-9.png?raw=true)
### 6.实现`-help`
- `command_group proc_name` 写函数前需要提前创建proc_name![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-15.png?raw=true)
![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-16.png?raw=true)
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-17.png?raw=true)
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-13.png?raw=true)  注意下边红框的名称（定义很ez故不多说）
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/image-14.png?raw=true)
- `option`表示可指定可不指定，`required`表示必须
- 定义函数中只有一个参数`args`，所以必须解析参数，如上红框圈住的那一栏
---
# 思考/疑惑
 1. array相关得再看看..那么像matlab的字典的.  
 2. 看不懂那个讲课的脚本.再看看
# Test
自己写了个calculate.tcl，虚拟机突然莫名其妙连不上网传不到github.
- ![Alt text](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/1.png?raw=true)
- 运行  ![?](https://github.com/ArvailWei/NomalLearning/blob/main/tcl/1742881737019.jpg?raw=true)
