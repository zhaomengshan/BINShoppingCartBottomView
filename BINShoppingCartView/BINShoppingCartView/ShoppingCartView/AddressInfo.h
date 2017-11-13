//
//  AddressInfo.h
//  WeiHouBao
//
//  Created by hsf on 2017/10/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressInfoEnd;

@interface AddressInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *city;

- (instancetype)initWithAddressEnd:(AddressInfoEnd *)addressInfo;

@end
