//
//  GlobalMacro.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//


/**
 *  主屏幕宽
 */
#define DEF_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  主屏幕高
 */
#define DEF_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  主屏幕高减去navigationBar的高度
 */
#define DEF_CONTENT_HEIGHT ([UIScreen mainScreen].bounds.size.height - 64)


/**
 *  NavigationBar 的高度
 */
#define DEF_NAVBARHEIGHT 44

/**
 *  StatusBar 的高度
 */
#define DEF_STATUSBARHEIGHT 20

/**
 *  获取视图的 X
 */
#define DEF_X_VIEW(view) view.frame.origin.x

/**
 *  获取视图的 Y
 */
#define DEF_Y_VIEW(view) view.frame.origin.y

/**
 *  获取视图的宽度
 */
#define DEF_WIDTH_VIEW(view) view.bounds.size.width

/**
 *  获取视图的高度
 */
#define DEF_HEIGHT_VIEW(view) view.bounds.size.height

/**
 *  视图的右边坐标的x值
 */
#define DEF_RIGHT_VIEW(view) (view.frame.origin.x + view.bounds.size.width)

/**
 *  视图的底部坐标的y值
 */
#define DEF_BOTTOM_VIEW(view) (view.frame.origin.y + view.bounds.size.height)

/**
 *  十六进制颜色
 */
#define DEF_STRING_COLOR(string) [UIColor colorWithString:string]

/**
 *  RGB颜色
 */
#define DEF_RGB_COLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]


/**
 *  自适应语言
 */
#define AUTO_CONVERT_LANGUAGEWITHTEXT(text) NSLocalizedString(text, nil)

/**
 *  判断系统版本
 */
#define IOS7_Later [[[UIDevice currentDevice] systemVersion] floatValue] > 7.0
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] == 7.0
#define IOS7_Before [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0
#define IOS9_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define IPAD_DEVICE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
/**
 *  判断设备型号
 */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  NSUserDefaults
 */
#define UserDefaults [NSUserDefaults standardUserDefaults]


/**********************宏************************/

/**
 *  请求数据ip
 */
#define URL_TEST @""
#define URL_APPSTOR @"http://121.199.42.130:3008/api/"
#define URL_FORMAL @"http://139.224.28.164:3008/api/"
#define URL_HEADER URL_APPSTOR

//#ifdef DEBUG    //处于开发阶段
//
//#define FLog(...) NSLog(__VA_ARGS__)
//
//#else           //处于发布阶段
//
//#define FLog(...)
//
//#endif

//输出宏 : 当程序还在调试阶段,系统会默认有一个DEBUG宏.当程序发布后,不需要再查看输出结果
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"function:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...)
#endif


#pragma mark － 项目相关
/**
 *  深绿色(导航栏颜色)
 */
#define DEEP_GREEN_COLOR [UIColor colorWithString:@"#546561"]

/**
 *  浅绿色
 */
#define GREEN_COLOR [UIColor colorWithString:@"#BBD547"]

/**
 *  高亮的绿色
 */
#define LIGHT_GREEN_COLOR [UIColor colorWithString:@"#8AA415"]

/**
 *  橘黄色
 */
#define ORANGE_COLOR [UIColor colorWithString:@"#F5A623"]

/**
 *  高亮的橘黄色
 */
#define LIGHT_ORANGE_COLOR [UIColor colorWithString:@"#F8B51C"]

/**
 *  蓝色
 */
#define BLUE_COLOR DEF_RGB_COLOR(99, 175, 253, 1)

/**
 *  紫色
 */
#define PURPLE_COLOR DEF_RGB_COLOR(101, 88, 164, 1)

/**
 *  黑色
 */
#define BLACK_COLOR [UIColor colorWithString:@"#4A4A4A"]
#define BLACK_GROUND [UIColor colorWithString:@"#595959"]
#define BLACK_BTN_GROUND DEF_RGB_COLOR(102, 102, 102, 1)
#define LIGHT_BLACK DEF_RGB_COLOR(58, 58, 58, 1)

/**
 *  输入框的边框灰
 */
#define GRAY_LEVEL1 [UIColor colorWithString:@"#979797"]

/**
 *  tableView的分割线灰
 */
#define GRAY_LEVEL2 [UIColor colorWithString:@"#E6E6E6"]

/**
 *  底色灰
 */
#define GRAY_LEVEL3 [UIColor colorWithString:@"#F0F0F0"]

/**
 *  背景色
 */
#define GRAY_BACKGROUND [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0]

/**
 *  所有的白色
 */
#define WHITE_COLOR [UIColor colorWithString:@"#FFFFFF"]

#define EXTRA_SIZE 2
/**
 *  H0号字体
 */
#define H0_Font [UIFont fontWithName:@"Helvetica" size:22 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H1号字体
 */
#define H1_Font [UIFont fontWithName:@"Helvetica" size:20 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H2字体
 */
#define H2_Font [UIFont fontWithName:@"Helvetica" size:18 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H3字体
 */
#define H3_Font [UIFont fontWithName:@"Helvetica" size:16 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  15号折中字体
 */
#define Font15 [UIFont fontWithName:@"Helvetica" size:15 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H4字体
 */
#define H4_Font [UIFont fontWithName:@"Helvetica" size:14 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H5字体
 */
#define H5_Font [UIFont fontWithName:@"Helvetica" size:12 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H6字体
 */
#define H6_Font [UIFont fontWithName:@"Helvetica" size:10 + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  H7字体
 */
#define H7_Font [UIFont fontWithName:@"Helvetica" size:8 + (IPAD_DEVICE?EXTRA_SIZE:0)]
/**
 *  自定义大小的字体
 */
#define Font(s) [UIFont fontWithName:@"Helvetica" size:s + (IPAD_DEVICE?EXTRA_SIZE:0)]

/**
 *  json解析
 */
#define LSJson(json) [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil]

#define DEF_SAVE_SEARCH_HISTORY @"saveSearchHistory"
#define DEF_DEFAULT_ONLINE @"defaultOnline"
#define DEF_AUTO_RECORD_VOCAB @"autoRecordVacab"
#define DEF_WORD_LIST @"WordList"
#define DEF_VOCAB_RECORD @"vocabRecord"
