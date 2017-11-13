//
//  AddressInfo.m
//  WeiHouBao
//
//  Created by hsf on 2017/10/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "AddressInfo.h"

#import "AddressInfoEnd.h"

@implementation AddressInfo

- (instancetype)initWithAddressEnd:(AddressInfoEnd *)addressInfo{
    self = [super init];
    if (self) {
        self.title = addressInfo.title;
        self.province = addressInfo.province;
        self.recommend = addressInfo.recommend;
        self.city = addressInfo.city;
        
    }
    return self;
}

@end
