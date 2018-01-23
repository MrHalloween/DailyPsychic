#  1bu2bu基础类库使用须知

## 一、简介
### 1bu2bu基础类库主要包括6个文件夹：
```objc

AFBase      //AFBase    文件夹内是封装的一些基类
BUWidgets   //BUWidgets 文件夹内是封装的一些常用的控件
Category    //Category  文件夹内是常用的分类和扩展
Manager     //Manager   文件夹内是常用管理类
Macros      //Macros    文件夹内是宏定义
Common      //Common    文件夹内是AppConfigure和一个单例代码

```

#### AFBase
AFBase文件夹内是封装的一些基类，包括但不限于：
```objc

BUCustomViewController  （控制器基类）
AFBaseTableView         （基本表格类）
AFBaseCell               (cell基类)
BUAFHttpRequest         （网络请求基类）
AFBaseModuleData        （数据模型基类）
...

```

#### BUWidgets
BUWidgets文件夹内是封装的一些常用的控件，包括但不限于：
```objc

BUUserAvatar            （用户头像）
BUTopBannerView         （轮播图）
AFTimeSelctedView       （时间选择器）
...

```

#### Category
Category文件夹内是常用的分类和扩展，包括但不限于：
```objc

NSString+MD5            （MD5加密）
UIViewExt               （view尺寸）
...

```

#### Manager
Manager文件夹内是常用管理类，包括但不限于：
```objc

TextManager             文本属性管理者 （颜色、字体、字号...）
CheckoutManager         校验管理者（手机号、邮箱、银行卡、身份证...）
AlertManager            提示框管理者 加载进度管理者
...

```

#### Macros
Macros文件夹内是宏定义，包括但不限于：
##### 请把对应的宏写入相应的文件以方便查看管理
```objc

#import "DimensMacros.h"            //定义尺寸类的宏
#import "PathMacros.h"              //定义目录文件的宏
#import "UtilsMacros.h"             //工具类的宏
#import "NotificationMacros.h"      //系统Notification宏

```

#### Common
Common文件夹内是AppConfigure和一个单例代码
```objc

Singleton
AppConfigure

```
## 二、依赖的第三方框架
* AFNetworking
* MBProgressHUD
* MJRefresh
* SDwebImage

## 三、使用方法
### 1、将BULibrary文件夹拖入工程
### 2、拖入以上4个依赖的第三方框架
### 3、创建pch文件，需要引入的头文件如下：
```objc

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Macros.h"
#import "Manager.h"
#import "AppConfigure.h"
#import "UIViewExt.h"

```

#### 如报错，请按下面步骤逐步检查：
##### 1、Project > Build Settings > 搜索 “Prefix Header“；Precompile Prefix Header为YES；Prefix Header 后面填pch文件路径$(SRCROOT)/PrefixHeader.pch


## 四、使用注意
### 正常开发情况下不应该在BULibrary文件夹下增加任何文件夹或文件
### 如基类方法满足不了当前需求，请使用继承或分类等手段，不建议直接修改基类方法，避免引入不可预测的bug。


## 五、Remind
* ARC
* iOS>=8.0
* iPhone \ iPad screen anyway


## 六、修改历史
### version 1.0.0 （2018.1.20）  基础测试版本
#### 1、整理了文件夹分类
#### 2、删除了不应该属于基类的部分功能和方法
#### 3、细化了工具类的分工
#### 4、废弃了一些旧方法（UIAlertView相关）
#### 5、删除了部分常年不用的分类（僵尸分类）



