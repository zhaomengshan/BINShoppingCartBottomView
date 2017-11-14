//
//  BINMarco.h
//  BINIDropView
//
//  Created by hsf on 2017/10/26.
//  Copyright © 2017年 BIN. All rights reserved.
//

#ifndef BINMarco_h
#define BINMarco_h

#import "UIView+AddView.h"
#import "UIButton+EdgeInsets.h"
#import "UIView+Helper.h"
//#import "UIColor+Helper.h"
#import "NSObject+Helper.h"
#import "UIViewController+Helper.h"

#import "NSString+Helper.h"
#import "NSMutableArray+Helper.h"
#import "NSDictionary+Helper.h"

#import "UIImage+Helper.h"


#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLog(...)
#endif


#define kH_StatusBarHeight 20
//NavBar高度
#define kH_NaviagtionBarHeight 44
//状态栏 ＋ 导航栏 高度
#define kH_StatusAndNaviagtionBarHeight ((kH_StatusBarHeight) + (kH_NaviagtionBarHeight))

//屏幕 rect
#define kSCREEN_RECT ([UIScreen mainScreen].bounds)

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//强弱引用
#define kWeakSelf(type)    __weak __typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong __typeof(type) strongSelf = type;

#define kH_CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)


#define kSreenScale  ([UIScreen mainScreen].scale)
//屏幕分辨率
#define kSreenResolution (kSCREEN_WIDTH * kSCREEN_HEIGHT * kSreenScale)


//由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kMenuViewSize  CGSizeMake(kSCREEN_WIDTH*3/4, kSCREEN_HEIGHT)
#define kMenuViewRatio (3/4.0)

#define kLeftMenuRatio  0.8

#define kS_scaleOrder  0.7

#define kH_SegmentOfCustomeHeight  40
#define kH_CellHeight 50
#define kH_CellHeight_Filter 45

#define kPadding 5

#define kW_LayerBorderWidth 0.5

#define kWH_ArrowRight 25

#define kMBProgressMidOffset CGPointMake(0, 0)

#define kTimerValue 60

#define kRatio_IDCard  1.58

#define kAnimationDuration_Toast 1.5

#define kTAG_LABEL  100
#define kTAG_BTN  200
#define kTAG_BTN_RightItem  260
#define kTAG_BTN_BackItem  261

#define kTAG_IMGVIEW 300
#define kTAG_TEXTFIELD 400
#define kTAG_TEXTVIEW 500
#define kTAG_ALERT_VIEW 600
#define kTAG_ACTION_SHEET 700
#define kTAG_PICKER_VIEW 800
#define kTAG_DATE_PICKER 900

#define kTAG_VIEW 1000
#define kTAG_VIEW_Segment 1100
#define kTAG_VIEW_RADIO 1200

#define kTAG_UItableViewCell 1500


#define kTAG_ICAROUSEL 950
#define kTAG_PAGE_CONTROL 951

#define kH_Top_IMGVIEW  240
#define kH_LABEL 25
#define kH_LABEL_TITLE 30
#define kH_LABEL_SMALL 20

#define kH_TEXTFIELD 30

#define kH_LINE_VIEW  1/3.0

#define kW_HOUSE_TITLES  50+5
#define kW_HOUSE_CONTENTS  100-5
#define kH_HOUSE_CONTENTS  25

#define kX_GAP  10
#define kY_GAP  10

#define kH_CONTENT_INIT 40  //长文本默认高度
#define kH_BTN_SPREADOUT 15  //展开按钮高度


#define kH_CellHeight_Filter 45

//字体
#define KFZ_First 18
#define KFZ_Second 16
#define KFZ_Third 14
#define KFZ_Fouth 12
#define KFZ_Fifth 10


//颜色
#define kC_TextColor [UIColor colorWithHexString:@"#333333"]
#define kC_TextColor_Title [UIColor colorWithHexString:@"#666666"]
#define kC_TextColor_TitleSub [UIColor colorWithHexString:@"#999999"]
//橘色
#define kC_ThemeCOLOR [UIColor colorWithHexString:@"#fea914"]
#define kC_BackgroudColor [UIColor colorWithHexString:@"#f8f8f8"]
//#define kC_LineColor [UIColor colorWithHexString:@"#e0e0e0"]
#define kC_LineColor [UIColor greenColor]

//绿色
#define kC_ThemeCOLOR_One [UIColor colorWithHexString:@"#25b195"]
//水蓝色
#define kC_ThemeCOLOR_Two [UIColor colorWithHexString:@"#29b4f5"]


#define kC_BtnColor_N [UIColor colorWithHexString:@"#fea914"]
#define kC_BtnColor_H [UIColor colorWithHexString:@"#f1a013"]
#define kC_BtnColor_D [UIColor colorWithHexString:@"#999999"]


#define kC_ClearColor [UIColor clearColor]
//#define kC_MARK_COLOR [UIColor colorWithHexString:@"#f35f39"]

//测试用例
#define kC_WhiteColor [UIColor whiteColor]
#define kC_GreenColor [UIColor greenColor]
#define kC_YellowColor [UIColor yellowColor]
#define kC_BlueColor [UIColor blueColor]
#define kC_RedColor [UIColor redColor]
#define kC_BrownColor [UIColor brownColor]
#define kC_CyanColor [UIColor cyanColor]


//字体
#define KFZ_First 18
#define KFZ_Second 16
#define KFZ_Third 14
#define KFZ_Fouth 12
#define KFZ_Fifth 10


//图片最大尺寸500k
#define kFileSize_image 1024
//右指箭头
#define kIMAGE_arrowRight @"img_arrowRight.png"

#define kIMAGE_default @"img_headPortrait.png"
#define kIMAGE_default_User @"img_headPortrait_O.png"

#define kIMAGE_defaultAddPhoto @"img_photoAddDefault.png"

#define kIMAGE_SexBoy @"img_sex_boy.png"
#define kIMAGE_SexGril @"img_sex_gril.png"

#define kNIl_TEXT @"--"


#define kMsg_NetWorkRequesting @"网络请求中..."

#define kMsg_NetWorkFailed @"网络请求失败,请稍后再试"
#define kMsg_NetWorkNodata @"暂无数据"
#define kMsg_NetWorkNoMoredata @"没有更多数据了"

#define kMsg_NetWorkFailed_Params @"参数错误,稍后再试"


#define kMsg_IDCardFailed @"身份证识别失败,请稍后再试"
#define kMsg_IDCardSuccess @"身份证识别成功"

#define kActionTitle_Sure       @"确定"
#define kActionTitle_Cancell    @"取消"

#endif /* BINMarco_h */
