//
//  WHKNetRootOrderDataModel.m
//  WeiHouBao
//
//  Created by hsf on 2017/10/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKNetRootOrderDataModel.h"

#import "AddressInfo.h"
#import "AddressInfoEnd.h"

@implementation WHKNetRootOrderDataModel

@end


@implementation WHKNetResultOrderDataModel

@end


@implementation WHKNetInfoOrderDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data" : [WHKNetOrderDataModel class]
             };
}

@end


@implementation WHKNetOrderDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"lines" : [Lines class]
             };
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _weight = [NSString stringWithFormat:@"%@",@([dic[@"weight"] longValue])];
    _amount = [NSString stringWithFormat:@"%@",@([dic[@"amount"] longValue])];
    _priceMin = [NSString stringWithFormat:@"%@",@([dic[@"priceMin"] longValue])];
    _price = [NSString stringWithFormat:@"%@",@([dic[@"price"] longValue])];
    _num = [NSString stringWithFormat:@"%@",@([dic[@"num"] longValue])];
    
    return YES;
}

@end


@implementation Lines

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"start"   : [AddressInfo class],
             @"end"     : [AddressInfoEnd class],
             };
}

@end

//
//@implementation AddressInfo
//
//- (instancetype)initWithAddressEnd:(AddressInfoEnd *)addressInfo{
//    self = [super init];
//    if (self) {
//        self.title = addressInfo.title;
//        self.province = addressInfo.province;
//        self.recommend = addressInfo.recommend;
//        self.city = addressInfo.city;
//        
//        
//    }
//    return self;
//}
//
//@end
//
//
//@implementation AddressInfoEnd
//
//@end
