//
//  NSObject+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Helper)

- (CGSize)sizeWithText:(id)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

- (CGSize)sizeWithText:(id)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps;

+ (NSString *)jsonToString:(id)data;

+ (NSString *)stringFromInteger:(NSInteger)integer;

+ (NSString *)stringDeleteWhiteSpace:(NSString *)string;

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr;

- (NSDate *)dateWithString:(NSString *)dateString;

- (NSString *)stringWithDate:(NSDate *)date;

//字符串转字典
- (NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString;
//字典转字符串
- (NSString *)stringFromDictionary:(NSDictionary *)dict;

//时间戳相关
+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp;
//当前时间戳
+ (NSString *)timestampFromNow;
//时间转化时间戳
+ (NSString *)timestampFromTime:(NSString *)formatTime;
//时间戳转化时间
+ (NSString *)timeFromTimestamp:(id)timestamp;

//获取随机数
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

- (void)handleCallPhone:(NSString *)phoneNumber;

/**
 timer创建及启动

 */
- (NSTimer *)createTimerAndStartWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target aSelector:(SEL)aSelector repeats:(BOOL)repeats;

/**
 定时器停止及销毁

 */
- (void)stopTimer:(NSTimer *)timer;


/**
 十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorString;


@end
