//
//  NSString+Helper.h
//  WeiHouBao
//
//  Created by 晁进 on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface NSString (Helper)

+ (NSString *)DDlogCoordinate:(CLLocationCoordinate2D)Coordinate;
+ (NSString *)DDlogLocationInfo:(CLPlacemark *)placemark;
//返回经纬度字符串数组
+ (NSArray *)getCoordinateStringInfo:(CLLocationCoordinate2D)coordinate;

- (NSDictionary *)dictionaryValue;

- (BOOL)isContainBlank;

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

- (NSString *)makeUnicodeToString;
    
- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

+ (NSString *) md5:(NSString *)str;

+ (NSString *)stringFromInter:(NSInteger)inter;

/**
 此方法无法捕捉nil,因为YYModel解析已对nil填充,否则需要在外边判断是否 == nil;

 */
- (BOOL)isInvalidData;

@end
